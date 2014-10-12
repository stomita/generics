module.exports = (grunt) ->
  require("load-grunt-tasks")(grunt)

  grunt.initConfig
    pkg: require "./package.json"

    tmpDir: "./.tmp"

    publicDir: "./public"

    srcDir: "./client"

    watch:
      build:
        files: [
          "<%= srcDir %>/scripts/**/*.coffee"
          "<%= srcDir %>/styles/**/*.less"
          "<%= srcDir %>/partials/**/*.html"
          "<%= srcDir %>/templates/**/*"
          "<%= srcDir %>/index.html"
        ]
        tasks: [ "build" ]

    coffee:
      build:
        files: [
          cwd: "<%= srcDir %>/scripts"
          expand: true
          src: "**/*.coffee"
          ext: ".js"
          dest: "<%= tmpDir %>/js"
        ]

    less:
      build:
        files:
          "<%= publicDir %>/css/main.css": "<%= srcDir %>/styles/main.less"

    copy:
      lib:
        files: [
          expand: true
          cwd: "<%= srcDir %>"
          src: [ "index.html", "./partials/**/*.html", "./templates/**" ]
          dest: "<%= publicDir %>"
        ]

    browserify:
      build:
        files:
          "<%= publicDir %>/js/main.js" : [ "<%= tmpDir %>/js/main.js" ]
        options:
          transform: [ "browserify-shim" ]

    clean:
      build: [ "<%= tmpDir %>" ]

  grunt.registerTask "build", [ "clean", "less", "coffee", "browserify", "copy" ]
  grunt.registerTask "default", [ "build"]