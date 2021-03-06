(function() {
  angular.module('builder.components', ['builder', 'validator.rules']).config([
    '$builderProvider', function($builderProvider) {
      $builderProvider.registerComponent('header', {
        group: 'Default',
        label: 'Heading',
        description: '',
        placeholder: 'Title',
        required: false,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 document-name control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n  </div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n       <div class=\"form-group\" ng-if=\"validationOptions.length > 0\">\n        <label class='control-label'>Validation</label>\n        <select ng-model=\"$parent.validation\" class='form-control' ng-options=\"option.rule as option.label for option in validationOptions\"></select>\n    </div>\n\n        <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });
      $builderProvider.registerComponent('textInput', {
        group: 'Default',
        label: 'Single line input',
        description: '',
        placeholder: 'Single line input',
        required: false,
        validationOptions: [
          {
            label: 'none',
            rule: '/.*/'
          }, {
            label: 'number',
            rule: '[number]'
          }, {
            label: 'email',
            rule: '[email]'
          }, {
            label: 'url',
            rule: '[url]'
          }
        ],
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n        <input type=\"text\" ng-model=\"inputText\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\" id=\"{{formName+index}}\" class=\"form-control\" placeholder=\"{{placeholder}}\"/>\n        <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Placeholder</label>\n        <input type='text' ng-model=\"placeholder\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n      Required?       <input type='checkbox' ng-model=\"required\" />\n  </label>\n    </div>\n     <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });      
      $builderProvider.registerComponent('textArea', {
        group: 'Default',
        label: 'Multi line input',
        description: '',
        placeholder: 'Multi line input',
        required: false,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n        <textarea type=\"text\" ng-model=\"inputText\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\" id=\"{{formName+index}}\" class=\"form-control\" rows='6' placeholder=\"{{placeholder}}\"/>\n        <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Placeholder</label>\n        <input type='text' ng-model=\"placeholder\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n       Required?      <input type='checkbox' ng-model=\"required\" />\n  </label>\n    </div>\n\n        <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });
      $builderProvider.registerComponent('select', {
        group: 'Default',
        label: 'Dropdown',
        description: '',
        placeholder: 'Dropdown',
        required: false,
        options: ['value one', 'value two'],
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n        <select ng-options=\"value for value in options\" id=\"{{formName+index}}\" class=\"form-control droupdown1\"\n            ng-model=\"inputText\" ng-init=\"inputText = options[0]\"/>\n        <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Options</label>\n        <textarea class=\"form-control\" rows=\"3\" validator=\"[required]\" ng-model=\"optionsText\"/>\n    </div>\n\n        <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });
      $builderProvider.registerComponent('radio', {
        group: 'Default',
        label: 'Radio',
        description: '',
        placeholder: 'Radio',
        required: false,
        options: ['value one', 'value two'],
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n        <div class='radio' ng-repeat=\"item in options track by $index\">\n            <label><input name='{{formName+index}}' ng-model=\"$parent.inputText\" validator-group=\"{{formName}}\" value='{{item}}' type='radio'/>\n                {{item}}\n            </label>\n        </div>\n        <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Options</label>\n        <textarea class=\"form-control\" rows=\"3\" validator=\"[required]\" ng-model=\"optionsText\"/>\n    </div>\n\n        <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });
      $builderProvider.registerComponent('checkbox', {
        group: 'Default',
        label: 'Checkbox',
        description: '',
        placeholder: 'Checkbox',
        required: false,
        options: ['value one', 'value two'],
        arrayToText: true,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n        <input type='hidden' ng-model=\"inputText\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\"/>\n        <div class='checkbox' ng-repeat=\"item in options track by $index\">\n            <label><input type='checkbox' ng-model=\"$parent.inputArray[$index]\" value='item'/>\n                {{item}}\n            </label>\n        </div>\n        <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Options</label>\n        <textarea class=\"form-control\" rows=\"3\" validator=\"[required]\" ng-model=\"optionsText\"/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n       Required?     <input type='checkbox' ng-model=\"required\" />\n        </label>\n    </div>\n\n     <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });
      $builderProvider.registerComponent('date', {
        group: 'Default',
        label: 'Date',
        description: '',
        placeholder: 'dd-mm-yyyy',
        required: false,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n        <input type=\"text\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\" id=\"{{formName+index}}\" class=\"form-control\" placeholder=\"{{placeholder}}\"/>\n        <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Placeholder</label>\n        <input type='text' ng-model=\"placeholder\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n    Required?        <input type='checkbox' ng-model=\"required\" />\n  </label>\n    </div>\n    <div class=\"form-group\" ng-if=\"validationOptions.length > 0\">\n        <label class='control-label'>Validation</label>\n        <select ng-model=\"$parent.validation\" class='form-control' ng-options=\"option.rule as option.label for option in validationOptions\"></select>\n    </div>\n\n        <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });  
      $builderProvider.registerComponent('signature', {
        group: 'Default',
        label: 'Signature',
        description: '',
        placeholder: 'Signature',
        required: false,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n  <a class=\"btn-file\" href=\"javascript:;\">Upload Signature <input type=\"file\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\" id=\"{{formName+index}}\" class=\"form-control\" placeholder=\"{{placeholder}}\"/>\n    </a>    <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n Required?  <input type='checkbox' ng-model=\"required\" />\n</label>\n    </div>\n    <div class=\"form-group\" ng-if=\"validationOptions.length > 0\">\n        <label class='control-label'>Validation</label>\n        <select ng-model=\"$parent.validation\" class='form-control' ng-options=\"option.rule as option.label for option in validationOptions\"></select>\n    </div>\n\n        <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      }); 
      $builderProvider.registerComponent('file', {
        group: 'Default',
        label: 'File',
        description: '',
        placeholder: 'File',
        required: false,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-sm-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i ng-click=\"popover.addClass($event)\" class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-sm-8\">\n  <a class=\"btn-file\" href=\"javascript:;\">Upload File <input type=\"file\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\" id=\"{{formName+index}}\" class=\"form-control\" placeholder=\"{{placeholder}}\"/>\n    </a>    <p class='help-block'>{{description}}</p>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"form-group\">\n        <label class='control-label'>Description</label>\n        <input type='text' ng-model=\"description\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n Required?  <input type='checkbox' ng-model=\"required\" />\n</label>\n    </div>\n    <div class=\"form-group\" ng-if=\"validationOptions.length > 0\">\n        <label class='control-label'>Validation</label>\n        <select ng-model=\"$parent.validation\" class='form-control' ng-options=\"option.rule as option.label for option in validationOptions\"></select>\n    </div>\n\n        <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n            </div>\n</form>"
      });      
    }
  ]);

}).call(this);
