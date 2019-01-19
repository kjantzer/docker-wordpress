<?php

if( !is_admin() ){
	
	// wp_enqueue_script( 'script', get_template_directory_uri() . '/build/includes.js', [], 1.0, false);
	wp_enqueue_style( 'style', get_template_directory_uri() . '/style.css', false, '1.0', 'all');

	if( $_SERVER['SERVER_NAME'] == 'localhost' ){
		wp_register_script('livereload', 'http://localhost:35729/livereload.js?snipver=1', null, false, true);
		wp_enqueue_script('livereload');
	}
}

function register_my_menus() {
	register_nav_menus([
		'header-menu' => __( 'Header Menu' )
		// 'extra-menu' => __( 'Extra Menu' )
	]);
}
add_action( 'init', 'register_my_menus' );