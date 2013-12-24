module.exports = function(config) {
  return config.set({
    basePath: '..',
    frameworks: ['jasmine'],
    files: ['bower_components/jquery/jquery.js', 'bower_components/angular/angular.js', 'bower_components/angular-mocks/angular-mocks.js', 'bower_components/select2/select2.js', 'bower_components/jasmine-jquery/lib/jasmine-jquery.js', 'angular-bootstrap3-forms.js', 'test/*Spec.coffee'],
    exclude: [],
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: false,
    browsers: ['PhantomJS'],
    captureTimeout: 60000,
    singleRun: false,
    preprocessors: {
      '**/*.coffee': 'coffee'
    }
  });
};
