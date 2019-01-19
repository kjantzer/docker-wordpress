<?php get_header(); ?>

<?php if (have_posts()) : while (have_posts()) : the_post(); ?>

    <h1>
        <a href="<?php the_permalink(); ?>"><h3>Page: <?php the_title(); ?></h3></a>
    </h1>
    
    <?php the_content(); ?>

<?php endwhile; else: ?>
<?php endif; ?>

<?php get_footer(); ?>