(function() {
  var angularBootstrap3Forms;

  angularBootstrap3Forms = angular.module('bootstrap3.forms', []);

  angularBootstrap3Forms.directive('bsFormGroup', function($parse) {
    return {
      template: "       <div class='form-group'>         <label class='control-label' ng-class='labelClass' ng-show='label'>{{label}}</label>         <div ng-class='wrapperClass' ng-transclude></div>       </div>",
      transclude: 'element',
      replace: true,
      restrict: 'AE',
      scope: {
        label: "@",
        labelClass: "@",
        wrapperClass: "@"
      }
    };
  }).directive('bsField', function($compile, $parse) {
    return {
      restrict: 'AE',
      transclude: 'element',
      require: 'ngModel',
      scope: {
        rows: '@',
        source: '@',
        placeholder: '@',
        choices: '=',
        value: '=ngModel',
        "class": '@'
      },
      link: function($scope, $element, $attrs, controller) {
        var attrs, input, label, tag, tmpl, value, _ref;
        $scope.controller = controller;
        tag = 'input';
        attrs = {
          'ng-model': 'value',
          "class": 'form-control'
        };
        if ($scope["class"]) {
          attrs["class"] += " " + $scope["class"];
        }
        switch ($attrs.type) {
          case 'string':
            attrs.type = 'text';
            attrs.placeholder = $scope.placeholder;
            break;
          case 'text':
            tag = 'textarea';
            if ($scope.rows) {
              attrs.rows = $scope.rows;
            }
            break;
          case 'select':
            tag = 'select';
            attrs['ui-select2'] = "SELECT_" + (+new Date());
            attrs['select2-width'] = '100%';
            attrs['data-placeholder'] = $scope.placeholder;
            break;
          case 'select-remote':
            attrs['ui-select2'] = "SELECT_REMOTE_" + (+new Date());
            attrs['select2-width'] = '100%';
            attrs['select2-remote'] = $scope.source;
            attrs['data-placeholder'] = $scope.placeholder;
            break;
          case 'multiselect-remote':
            attrs['ui-select2'] = "MULTISELECT_REMOTE_" + (+new Date());
            attrs['select2-width'] = '100%';
            attrs['select2-remote'] = $scope.source;
            attrs['multiple'] = true;
            attrs['data-placeholder'] = $scope.placeholder;
            break;
          case 'checkbox':
            attrs.type = 'checkbox';
        }
        input = angular.element("<" + tag + "/>").attr(attrs);
        if ($scope.choices) {
          _ref = $scope.choices;
          for (value in _ref) {
            label = _ref[value];
            input.append("<option value='" + value + "'>" + label + "</option>");
          }
        }
        tmpl = angular.element("<div></div>").append(input).append("<span class='help-block' ng-hide='controller.$pristine' ng-show='controller.$error.required'>This field is required.</span>");
        return $element.replaceWith($compile(tmpl)($scope));
      }
    };
  });

}).call(this);
