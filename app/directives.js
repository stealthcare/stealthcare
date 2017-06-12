app.directive('focus', function() {
    return function(scope, element) {
        element[0].focus();
    }      
});

app.directive('passwordMatch', [function () {
    return {
        restrict: 'A',
        scope:true,
        require: 'ngModel',
        link: function (scope, elem , attrs,control) {
            var checker = function () {
 
                //get the value of the first password
                var e1 = scope.$eval(attrs.ngModel); 
 
                //get the value of the other password  
                var e2 = scope.$eval(attrs.passwordMatch);
                if(e2!=null)
                return e1 == e2;
            };
            scope.$watch(checker, function (n) {
 
                //set the form control to valid if both 
                //passwords are the same, else invalid
                control.$setValidity("passwordNoMatch", n);
            });
        }
    };
}]);

app.directive('usernameAvailable', function($http, $timeout, $q, $rootScope) {
    var serviceBase = 'api/v1/api.php?request='; 
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, elm, attr, control) { 
            elm.bind("change", function() {  
                var username = angular.element('#username').val(); 
                var UserID = angular.element('#UserID').val(); 
                $rootScope.checkExists = true;
                $http({
                    method: 'post',
                    data: $.param({username: username,UserID: UserID}),
                    url: serviceBase+'checkCareOrgEmailOrUsername',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'}
                })
                .success(function(results){
                    $rootScope.checkExists = false;
                    if (results.status_code == "1") {
                        control.$setValidity('usernameExists', false); 
                    } else {
                        control.$setValidity('usernameExists', true); 
                    }                       
                });
            });
        }
    } 
});

app.directive('emailAvailable', function($http, $timeout, $q, $rootScope) {
    var serviceBase = 'api/v1/api.php?request='; 
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, elm, attr, control) { 
            elm.bind("change", function() {  
                var email = angular.element('#email').val();
                var UserID = angular.element('#UserID').val();  
                $rootScope.checkExists = true;
                $http({
                    method: 'post',
                    data: $.param({email: email,UserID: UserID}),
                    url: serviceBase+'checkCareOrgEmailOrUsername',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'}
                })
                .success(function(results){
                    $rootScope.checkExists = false;
                    if (results.status_code == "1") {
                        control.$setValidity('emailExists', false); 
                    } else {
                        control.$setValidity('emailExists', true); 
                    }                       
                });
            });
        }
    } 
});

app.directive('lowerThan', [
  function() {

    var link = function($scope, $element, $attrs, ctrl) {

      var validate = function(viewValue) {
        var comparisonModel = $attrs.lowerThan;
        
        if(!viewValue || !comparisonModel){
          // It's valid because we have nothing to compare against
          ctrl.$setValidity('lowerThan', true);
        }

        // It's valid if model is lower than the model we're comparing against
        ctrl.$setValidity('lowerThan', parseInt(viewValue, 10) < parseInt(comparisonModel, 10) );
        return viewValue;
      };

      ctrl.$parsers.unshift(validate);
      ctrl.$formatters.push(validate);

      $attrs.$observe('lowerThan', function(comparisonModel){
        return validate(ctrl.$viewValue);
      });
      
    };

    return {
      require: 'ngModel',
      link: link
    };

  }
]);

app.directive( 'customSubmit' , function()
{
    return {
        restrict: 'A',
        link: function( scope , element , attributes )
        {
            var $element = angular.element(element);
            
            // Add novalidate to the form element.
            attributes.$set( 'novalidate' , 'novalidate' );
            
            $element.bind( 'submit' , function( e ) {
                e.preventDefault();
                
                // Remove the class pristine from all form elements.
                $element.find( '.ng-pristine' ).removeClass( 'ng-pristine' );
                
                // Get the form object.
                var form = scope[ attributes.name ];
                
                // Set all the fields to dirty and apply the changes on the scope so that
                // validation errors are shown on submit only.
                angular.forEach( form , function( formElement , fieldName ) {
                    // If the fieldname starts with a '$' sign, it means it's an Angular
                    // property or function. Skip those items.
                    if ( fieldName[0] === '$' ) return;
                    
                    formElement.$pristine = false;
                    formElement.$dirty = true;
                });
                
                // Do not continue if the form is invalid.
                if ( form.$invalid ) {
                    // Focus on the first field that is invalid.
                    $element.find( '.ng-invalid' ).first().focus();
                    
                    return false;
                }
                
                // From this point and below, we can assume that the form is valid.
                scope.$eval( attributes.customSubmit );
                
                scope.$apply();
            });
        }
    };
});

/*app.directive('validatePostcode', function() {
    return {
      require: 'ngModel',
      restrict: 'A',
      link: function(scope, elem, attr, ngModel) {
        var validator = function(value) {
            var postcode1 = angular.element('#postcode1').val(); 
            var postcode2 = angular.element('#postcode2').val(); 
            value = postcode1+' '+postcode2;
            if (/^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$/.test(value)) {
            ngModel.$setValidity('postcode', true);
            return value;
            } else {
            ngModel.$setValidity('postcode', false);
            return undefined;
            }
        };
        ngModel.$parsers.unshift(validator);
        ngModel.$formatters.unshift(validator);
      }
    };
});*/

app.directive('validatePostcode', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attr, ngModelCtrl) {
            element.bind('keypress', function(e) {
                if (e.which === 32) {
                    e.preventDefault();
                }
            });
            function fromUser(text) {
                if (text) {
                    var transformedInput = text.replace(/[^a-zA-Z0-9\s ]/g, '');

                    if (transformedInput !== text) {
                        ngModelCtrl.$setViewValue(transformedInput);
                        ngModelCtrl.$render();
                    }
                    return transformedInput;
                }
                return undefined;
            }            
            ngModelCtrl.$parsers.push(fromUser);
        }
    };
});

app.directive('moveFocus', function() {
    function getCaretPosition(elem) {
      // Internet Explorer Caret Position
      if (document.selection && document.selection.createRange) {
        var range = document.selection.createRange();
        var bookmark = range.getBookmark();
        return bookmark.charCodeAt(2) - 2;
      }

      // Firefox Caret Position
      return elem.setSelectionRange && elem.selectionStart;
    }

    return {
      restrict: 'A',
      link: function(scope, elem, attr) {
        var tabindex = parseInt(attr.tabindex);
        var maxlength = parseInt(attr.maxlength);

        elem.on('input, keydown', function(e) {
          var val = elem.val(),
              cp, 
              code = e.which || e.keyCode;

          if (val.length === maxlength && [8, 37, 38, 39, 40, 46].indexOf(code) === -1) {
            var next = document.querySelectorAll('#postcode' + (tabindex + 1));
            next.length && next[0].focus();
            return;
          }

          cp = getCaretPosition(this);
          if ((cp === 0 && code === 46) || (cp === 1 && code === 8)) {
            var prev = document.querySelectorAll('#postcode' + (tabindex - 1));
            e.preventDefault();
            elem.val(val.substring(1));
            prev.length && prev[0].focus();
            return;
          }
        });
      }
    };
});


app.directive('usernameAvailableorg', function($http, $timeout, $q, $rootScope) {
    var serviceBase = 'api/v1/api.php?request='; 
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, elm, attr, control) { 
            elm.bind("change", function() {  
                var username = angular.element('#UserName').val(); 				
                var UserID = angular.element('#UserID').val(); 
                $rootScope.checkExistsStaff = true;
                $http({
                    method: 'post',
                    data: $.param({username: username,UserID: UserID}),
                    url: serviceBase+'checkStaffEmailOrUsername',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'}
                })
                .success(function(results){
                    $rootScope.checkExistsStaff = false;
                    if (results.status_code == "1") {
                        control.$setValidity('usernameExists', false); 
                    } else {
                        control.$setValidity('usernameExists', true); 
                    }                       
                });
            });
        }
    } 
});