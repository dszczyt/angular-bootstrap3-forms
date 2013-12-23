angularBootstrap3Forms = angular.module('bootstrap3.forms', [])

angularBootstrap3Forms
.directive(
  'bsFormGroup'
  ($parse) ->
    {
      template: "
         <div class='form-group'>
           <label class='control-label' ng-class='labelClass' ng-show='label'>{{label}}</label>
           <div ng-class='wrapperClass' ng-transclude></div>
         </div>"
      transclude: 'element'
      replace: true
      restrict: 'AE'
      scope: {
        label: "@"
        labelClass: "@"
        wrapperClass: "@"
      }
    }
)
.directive(
  'bsField'
  ($compile, $parse) ->
    {
      restrict: 'AE'
      transclude: 'element'
      require: 'ngModel'
      scope: {
        rows: '@'
        source: '@'
        placeholder: '@'
        choices: '='
        value: '=ngModel'
        class: '@'
      }


      link: ($scope, $element, $attrs, controller) ->
        $scope.controller = controller

        tag = 'input'
        attrs = {
          'ng-model': 'value'
          class: 'form-control'
        }

        attrs.class += " " + $scope.class if $scope.class

        switch $attrs.type
          when 'string'
            attrs.type = 'text'
            attrs.placeholder = $scope.placeholder

          when 'text'
            tag = 'textarea'
            attrs.rows = $scope.rows if $scope.rows

          when 'select'
            tag = 'select'
            attrs['ui-select2'] = "SELECT_" + (+new Date())
            attrs['select2-width'] = '100%'
            attrs['data-placeholder'] = $scope.placeholder

          when 'select-remote'
            attrs['ui-select2'] = "SELECT_REMOTE_" + (+new Date())
            attrs['select2-width'] = '100%'
            attrs['select2-remote'] = $scope.source
            attrs['data-placeholder'] = $scope.placeholder

          when 'multiselect-remote'
            attrs['ui-select2'] = "MULTISELECT_REMOTE_" + (+new Date())
            attrs['select2-width'] = '100%'
            attrs['select2-remote'] = $scope.source
            attrs['multiple'] = true
            attrs['data-placeholder'] = $scope.placeholder

          when 'checkbox'
            attrs.type = 'checkbox'

        input = angular.element("<#{tag}/>").attr(attrs)
        if $scope.choices
          input.append("<option value='#{value}'>#{label}</option>") for value, label of $scope.choices
        tmpl = angular.element("<div></div>")
          .append(input)
          .append("<span class='help-block' ng-hide='controller.$pristine' ng-show='controller.$error.required'>This field is required.</span>")

        $element.replaceWith($compile(tmpl)($scope))
    }
)
