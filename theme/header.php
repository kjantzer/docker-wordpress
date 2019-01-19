<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
  <meta charset="<?php bloginfo( 'charset' ); ?>">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
    
<header>
    <?php wp_nav_menu( array( 'theme_location' => 'header-menu' ) ); ?>
</header>
    
<div class="wrap">
  <div id="primary" class="content-area">
    <main id="main" class="site-main" role="main">