describe("angular-bootstrap3-forms", function() {
  beforeEach(module('bootstrap3.forms'));

  beforeEach(
    inject(
      function($rootScope, _$compile_) {
        scope = $rootScope;
        $compile = _$compile_;
      }
    )
  );

  var createDirective = function(data, tmpl) {
    elt = $compile(tmpl)(scope);
    scope.$digest();
    return elt;
  };

  describe("no label", function() {
    beforeEach(function() {
      element = function() {
        return createDirective(null, "<bs-form-group></bs-form-group>");
      };
    });

    it('should render the expected output', function() {
      inject(function($rootScope, $compile) {
        expect(element()).toBe('div.form-group');
        expect(element().children('label.control-label')).toBeHidden();
      });
    });
  });

  describe("with label", function() {
    beforeEach(function() {
      element = function() {
        return createDirective(null, "<bs-form-group label='test' label-class='col-md-2'></bs-form-group>");
      };
    });

    it('should render the expected output', function() {
      inject(function($rootScope, $compile) {
        expect(element()).toBe('div.form-group');
        expect(element()).toContain('label.control-label');
        expect(element().children('label.control-label').text()).toEqual('test');
        expect(element().children('label.control-label')).toHaveClass('col-md-2');
      });
    });
  });

  describe("bs-field", function() {
    describe("with no ng-model", function() {
      beforeEach(function() {
        element = function() {
          return createDirective(null, "<bs-field></bs-field>");
        };
      });

      it("should require ng-model", function() {
        expect(function() { element() }).toThrow();
      });
    });
  });
});
