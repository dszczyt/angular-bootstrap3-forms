module.exports = function (grunt) {
  'use strict';

  var initConfig;

  // Loading external tasks
  require('load-grunt-tasks')(grunt);

  // Project configuration.
  initConfig = {
    bower: 'bower_components',
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
        compile: {
            files: {
                'angular-bootstrap3-forms.js': 'src/*.coffee'
            }
        }
    },
    watch: {
      coffee: {
          files: ['src/**/*.coffee'],
          tasks: ['coffee']
      },
      test: {
        // Lint & run unit tests in Karma
        // Just running `$ grunt watch` will only lint your code; to run tests
        // on watch, use `$ grunt watch:karma` to start a Karma server first
        files: ['src/angular-boostrap3-forms.js.coffee', 'test/formSpec.js'],
        tasks: ['jshint', 'karma:unit:run']
      }
    },
    karma: {
      options: {
        configFile: 'test/karma.conf.js',
        browsers: ['Firefox', 'PhantomJS']
      },
      unit: {
        singleRun: true
      },
      watch: {
        autoWatch: true
      },
      server: {
        background: true
      }
    },
    jshint: {
      all:[
        'gruntFile.js',
        'angular-bootstrap3-forms.js',
        'test/**/*Spec.js'
      ],
      options: {
        jshintrc: '.jshintrc'
      }
    },
    changelog: {
      options: {
        dest: 'CHANGELOG.md'
      }
    }
  };

  // Register tasks
  grunt.registerTask('default', ['jshint', 'karma:unit']);
  grunt.registerTask('watch', ['jshint', 'karma:watch']);

  grunt.initConfig(initConfig);
};
