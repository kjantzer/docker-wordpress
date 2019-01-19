#!/bin/bash

# Import Live Database
#
# This bash script will import the live catalog database into your local catalog db.
# You can choose to only dump the table structure, all the data, all the data
# except proofing light tables, or you can specify exactly which tables you wish to import.
#
# Simply run `bash dbsync.sh` and you will be prompted with what to do
#
# @author Kevin Jantzer, Blackstone Audio
# @since 2014-06-24, refactored 2017-01-17

PULLHOST=''
PULLPORT='3306'
PULLUSER=''
PULLPW=''
PULLDB=''

PUSHHOST='localhost'
PUSHPORT='3307'
PUSHUSER='root'
PUSHPW='somewordpress'
PUSHDB='wordpress'

################################################################################################
# change below at your own risk
################################################################################################

#WHERE='--where="timestamp_updated > now() - interval 72 hour" --skip-add-drop-table --no-create-info'
OPTIONS='--single-transaction --skip-triggers --compress --set-gtid-purged=OFF --verbose'

# print out where data is importing from and to
echo "================== DB Sync ==================="

TABLES=$1
	
# no table parameter given so prompt user to give us one
if [[ $TABLES =~ ^$ ]]
then
	# ask user which tables should be imported - if blank, all tables will be imported
	read -p "List tables to import (leave blank for ALL):
" TABLES
fi

# table name contains wildcard, lookup table names in live DB (http://stackoverflow.com/a/26514699/484780)
if [[ $TABLES == *"%"* ]]
then
TABLES=`mysql -h$PULLHOST --port=$PULLPORT -u$PULLUSER -p$PULLPW $PUSHDB -Bse "SHOW TABLES LIKE '$TABLES'"`
echo -e "\nIMPORTING TABLES:\n$TABLES\n"
fi

OPTIONS="$TABLES $WHERE $OPTIONS"


# if a password is required push database, setup that commmand
if [[ $PUSHPW ]]
then
	PUSHPW=" -p$PUSHPW"
fi

PULL="mysqldump -h$PULLHOST --port=$PULLPORT -u$PULLUSER -p$PULLPW $PULLDB $OPTIONS"
PUSH="mysql -h$PUSHHOST --port=$PUSHPORT -u$PUSHUSER $PUSHPW $PUSHDB --protocol tcp"
DOPULL="$PULL | pv | $PUSH"

eval $DOPULL

echo "------------------------------------------------"
echo "Sync complete"
echo "================================================"
