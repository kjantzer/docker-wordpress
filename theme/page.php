<?php get_header(); ?>

<h1>Page post</h1>

<?php if (have_posts()) : while (have_posts()) : the_post(); ?>

    <div>
      <a href="<?php the_permalink(); ?>"><h3><?php the_title(); ?></h3></a>
      <?php the_content(); ?>
    </div>

<?php endwhile; else: ?>
<?php endif; ?>

<?php get_footer(); ?>