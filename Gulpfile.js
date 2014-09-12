var gulp = require('gulp'),
    g = require('gulp-load-plugins')();

gulp.task("pelican-dev", function() {
 g.run("pelican -s ./local_settings_dev.py").exec();
});

gulp.task("install", function() {
  g.run("pip install -r requirements.txt").exec();
});

gulp.task("server", function() {
  gulp.src("output")
    .pipe(g.webserver({}));
});

gulp.task("watch", function() {
  gulp.watch(["_theme/**/*"], ["pelican-dev"]);
  gulp.watch(["_src/**/*"], ["pelican-dev"]);
});

gulp.task("default", ["pelican-dev", "server", "watch"]);

