describe "angular-bootstrap3-forms", ->
  element = scope = $compile = null

  beforeEach module 'bootstrap3.forms'

  beforeEach inject ($rootScope, _$compile_) ->
    scope = $rootScope
    $compile = _$compile_

  createDirective = (data, tmpl) ->
    scope.data = data if data
    elt = $compile(tmpl)(scope)
    scope.$digest()
    elt

  describe "no label", ->
    it 'should render the expected output', ->
      element = createDirective(null, "<bs-form-group></bs-form-group>")
      expect(element).toBe('div.form-group')
      expect(element.children('label.control-label')).toBeHidden()

  describe "with label", ->
    beforeEach ->
      element = createDirective(null, "<bs-form-group label='test' label-class='col-md-2'></bs-form-group>")

    it 'should render the expected output', ->
      inject ($rootScope, $compile) ->
        expect(element).toBe('div.form-group')
        expect(element).toContain('label.control-label')
        expect(element.children('label.control-label').text()).toEqual('test')
        expect(element.children('label.control-label')).toHaveClass('col-md-2')

  describe "bs-field", ->
    describe "with no ng-model", ->
      beforeEach ->
        element = ->
          createDirective(null, "<bs-field></bs-field>");

      it "should require ng-model", ->
        expect(-> element()).toThrow()

    describe "with ng-model", ->
      beforeEach ->
        element = createDirective('xxx', "<bs-field type='string' ng-model='var'></bs-field>")
      it 'should render the expected output', ->
        expect(element).toBe('input.form-control')
