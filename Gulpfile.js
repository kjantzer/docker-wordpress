
const gulp = require('gulp')
const livereload = require('gulp-livereload')
const less = require('gulp-less')
const sourcemaps = require('gulp-sourcemaps')
const cleanCSS = require('gulp-clean-css')


gulp.task('default', cb=>{
	
	livereload.listen(35729);
	
	gulp.watch('theme/style/**/*.less', gulp.series('build:css'))
	
	gulp.watch('theme/**/*.php').on('change', function(file) {
		livereload.changed(file);
	});
})


gulp.task('build:css', cb=>{
	
	gulp.src('theme/style/style.less')
		.pipe(sourcemaps.init())
		.pipe(less())
		.pipe(cleanCSS()) // for minification?
		.pipe(sourcemaps.write('./'))
		.pipe(livereload())
		.pipe(gulp.dest('theme'))
		.on('finish', resp=>{
			console.log('done');
			// console.log(chalk.green('✅ '+name)+chalk.gray(' '+src))
			cb()
		})
})
