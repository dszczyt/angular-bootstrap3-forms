geniustradeApp.directive(
  'bsFormGroup'
  ($parse) ->
    {
      template: "
         <div class='form-group'>
           <label class='control-label' ng-class='labelClass'>{{label}}</label>
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

