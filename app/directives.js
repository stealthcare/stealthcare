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
                $rootScope.checkExists = true;
                $http({
                    method: 'post',
                    data: $.param({username: username}),
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
                $rootScope.checkExists = true;
                $http({
                    method: 'post',
                    data: $.param({email: email}),
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