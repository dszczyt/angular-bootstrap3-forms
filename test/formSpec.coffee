describe "angular-bootstrap3-forms", ->
  element = scope = $compile = null

  beforeEach module 'bootstrap3.forms'

  beforeEach inject ($rootScope, _$compile_) ->
    scope = $rootScope
    $compile = _$compile_

  describe "bs-form-group", ->
    describe "no label", ->
      it 'should render the expected output', ->
        element = $compile("<bs-form-group></bs-form-group>")(scope)
        expect(element).toBe('div.form-group')
        expect(element.children('label.control-label')).toBeHidden()

    describe "with label", ->
      it 'should render the expected output', ->
        element = $compile("<bs-form-group label='test' label-class='col-md-2'></bs-form-group>")(scope)
        scope.$digest()
        expect(element).toBe('div.form-group')
        expect(element).toContain('label.control-label')
        expect(element.children('label.control-label').text()).toEqual('test')
        expect(element.children('label.control-label')).toHaveClass('col-md-2')

  describe "bs-field", ->
    describe "with no ng-model", ->
      it "should require ng-model", ->
        element = ->
          $compile("<bs-field></bs-field>")(scope)
        expect(-> element()).toThrow()

    describe "with ng-model", ->
      it 'should render the expected output with type string', ->
        element = $compile("<bs-form-group label='test'><bs-field type='string' ng-model='var'></bs-field></bs-form-group>")(scope)
        input = element.find(':input')
        expect(input).toBe('input[type=text].form-control')
        expect(input.val()).toEqual ''
        scope.var = 'myVarContent'
        scope.$digest()
        expect(input.val()).toEqual 'myVarContent'


      it 'should render the expected output with type text', ->
        element = $compile("<bs-form-group label='test'><bs-field type='text' ng-model='var' rows='42'></bs-field></bs-form-group>")(scope)
        input = element.find(':input')
        expect(input).toBe('textarea.form-control')
        expect(input).toHaveAttr('rows', '42')
        scope.$digest()
