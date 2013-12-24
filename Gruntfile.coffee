module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    bower: 'bower_components'
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        files:
          './angular-bootstrap3-forms.js': ['./src/**/*.coffee']
      config:
        options:
          bare: true
        files: [
          expand: true
          src: ['./test/karma.coffee']
          dest: '.'
          ext: '.js'
        ]
    watch:
      coffeescript:
        files: ['src/*.coffee']
        tasks: ['coffee', 'jshint', 'karma:unit']
      test:
        files: ['angular-boostrap3-forms.js', 'test/**/*Spec.js', 'test/**/*Spec.coffee']
        tasks: ['jshint', 'karma:unit']
      config:
        files: ['test/karma.coffee']
        tasks: ['coffee:config']
    karma:
      options:
        configFile: 'test/karma.js'
        #browsers: ['Firefox', 'PhantomJS']
        browsers: ['PhantomJS']
      unit:
        singleRun: true
      watch:
        autoWatch: false
      server:
        background: true
    jshint:
      all:
        [
          'gruntFile.js'
          'angular-bootstrap3-forms.js'
          #'test/**/*Spec.js'
        ]
      options:
        jshintrc: '.jshintrc'
    changelog:
      options:
        dest: 'CHANGELOG.md'

  #grunt.loadNpmTasks 'grunt-contrib-watch'
  #grunt.loadNpmTasks 'grunt-contrib-coffee'
  #grunt.loadNpmTasks 'grunt-karma'

  grunt.registerTask 'default', ['jshint', 'karma:unit']
  grunt.registerTask 'run', [ 'coffee:compile', 'coffee:config', 'watch']
  
