(function () {
  'use strict';

  var gulp = require('gulp'),
    plugins = require('gulp-load-plugins')(),
    NwBuilder = require('node-webkit-builder'),
    help = plugins.help(gulp),
    rimraf = require('rimraf'),
    path = require('path'),
    browserify = require('browserify'),
    source = require('vinyl-source-stream'),
    paths = {
      out: './out/',
      clean: ['./out/'],
      bundle: ['./out/modules/app.js'],
      coffee: ['./src/*.coffee', './src/**/*.coffee'],
      cjsx: ['./src/*.cjsx', './src/**/*.cjsx'],
      sass: './src/sass/app.scss',
      css: './out/app.css',
      views: ['./src/*.jade', './src/**/*.jade'],
      temp: ['./out/components/', './out/modules']
    };

  // Utility tasks
  gulp.task('clean', 'Removes prior build output', function () {
    // TODO: Make this async
    var fn = function (path) { rimraf.sync(path); };
    paths.clean.forEach(fn);
  });

  gulp.task('temp', 'Removes temp build output', ['build'], function () {
    // TODO: Make this async
    var fn = function (path) { rimraf.sync(path); };
    paths.temp.forEach(fn);
  });

  gulp.task('watch', ['temp'], function () {
    gulp.watch(paths.coffee, ['browserify']);
    gulp.watch(paths.cjsx, ['cjsx', 'browserify']);
    gulp.watch(paths.views, ['views']);
    gulp.watch(paths.sass, ['sass']);
  });

  gulp.task('run', ['temp'], function() {
    var svr = plugins.liveServer.new('./out/server.js');
    svr.start();

    gulp.watch(['./out/app.js', './out/app.css', './out/**/*.html'], svr.notify);
    gulp.watch(['./out/server.js'], svr.start);
  });

  gulp.task('build', 'Builds the application', ['clean', 'views', 'browserify', 'sass']);

  gulp.task('default', ['watch', 'run']);

  // Conversion tasks
  gulp.task('views', function() {
    return gulp.src(paths.views)
      .pipe(plugins.jade())
      .pipe(plugins.minifyHtml({ conditionals: true, spare: true }))
      .pipe(gulp.dest(paths.out))
      .on('error', plugins.util.log.bind(plugins.util, 'Jade Error'));
  });

  gulp.task('coffee', function() {
    return gulp.src(paths.coffee)
      .pipe(plugins.coffee())
      .pipe(gulp.dest(paths.out))
      .on('error', plugins.util.log.bind(plugins.util, 'CoffeeScript Error'));
  });

  gulp.task('browserify', 'Creates a Browserify bundle', ['coffee', 'cjsx'], function () {
    return browserify(paths.bundle)
      .bundle()
      .pipe(source('app.js'))
      .pipe(gulp.dest(paths.out))
      .on('error', plugins.util.log.bind(plugins.util, 'Browserify Error'));
  });

  gulp.task('scripts', ['browserify'], function() {
    return gulp.src(paths.out + 'app.js')
      .pipe(plugins.uglify())
      .pipe(gulp.dest(paths.out))
      .on('error', plugins.util.log.bind(plugins.util, 'Uglify Error'));
  });

  gulp.task('sass', 'Creates the SASS sourcemap', function () {
    return plugins.rubySass(paths.sass, { sourcemap: true, compass: true })
      .on('error', plugins.util.log.bind(plugins.util, 'SASS Error'))
      .pipe(plugins.sourcemaps.write())
      .pipe(gulp.dest(paths.out));
  });

  gulp.task('cjsx', 'Transform CJSX files to JavaScript', function() {
    gulp.src(paths.cjsx)
      .pipe(plugins.cjsx({ bare: true }))
      .pipe(gulp.dest(paths.out))
      .on('error', plugins.util.log.bind(plugins.util, 'CJSX Error'));
  });
})();
