'use strict';
var app = angular.module('myApp', ['ngRoute', 'ngAnimate', 'toaster', 'datatables', 'angularUtils.directives.dirPagination', 'builder', 'builder.components', 'validator.rules']);

app.config(['$locationProvider','$routeProvider', function($locationProvider, $routeProvider) {
        $locationProvider.html5Mode(true);
        $routeProvider. 
            // FOR SUPERADMIN PORTAL START
            when('/', {
                title: 'Home',
                templateUrl: 'partials/home.html',
                controller: 'authCtrl'
            })
            .when('/logout', {
                title: 'Logout',
                templateUrl: 'partials/login.html',
                controller: 'logoutCtrl'
            })
            .when('/setting', {
                title: 'Profile Setting',
                templateUrl: 'partials/profile_setting.html',
                controller: 'authCtrl'
            })
            .when('/signup', {
                title: 'Signup',
                templateUrl: 'partials/signup.html',
                controller: 'authCtrl'
            })
            /*.when('/dashboard', {
                title: 'Dashboard',
                templateUrl: 'partials/dashboard.html',
                controller: 'authCtrl'
            })*/
            .when('/careOrgs', {
                title: 'Care Organizer',
                templateUrl: 'partials/care_orga.html',
                controller: 'authCtrl'
            })
            .when('/careOrg/create', {
                title: 'Create Care Organizer',
                templateUrl: 'partials/create_care_orga.html',
                controller: 'authCtrl'
            })
            .when('/careOrg/edit/:id', {
                title: 'Update Care Organizer',
                templateUrl: 'partials/update_care_orga.html',
                controller: 'authCtrl'
            })
            .when('/licenses', {
                title: 'Licenses',
                templateUrl: 'partials/licenses.html',
                controller: 'authCtrl'
            })
            .when('/license/create', {
                title: 'Create License',
                templateUrl: 'partials/create_license.html',
                controller: 'authCtrl'
            })
            .when('/license/edit/:id', {
                title: 'Update License',
                templateUrl: 'partials/update_license.html',
                controller: 'authCtrl'
            })
            .when('/license/plans', {
                title: 'License Plans',
                templateUrl: 'partials/license_plans.html',
                controller: 'authCtrl'
            })
            .when('/license/plan/create', {
                title: 'Create Plan',
                templateUrl: 'partials/create_plan.html',
                controller: 'authCtrl'
            })
            .when('/license_plan/edit/:id', {
                title: 'Update Plan',
                templateUrl: 'partials/update_plan.html',
                controller: 'authCtrl'
            })
            /*.when('/', {
                title: 'blank',
                templateUrl: 'partials/blank.html',
                controller: 'authCtrl'
            })*/  
            // FOR SUPERADMIN PORTAL END

            // FOR ADMIN PORTAL START
            .when('/organization', {
                title: 'Organization Dashboard',
                templateUrl: 'partials/careOrg/dashboard.html',
                controller: 'orgCtrl'
            })
            .when('/organization/client/registration', {
                title: 'Organization Dashboard',
                templateUrl: 'partials/careOrg/client/registration.html',
                controller: 'orgCtrl'
            })
            .when('/organization/client/create', {
                title: 'Create Client',
                templateUrl: 'partials/careOrg/client/add_client.html',
                controller: 'orgCtrl'
            })
            .when('/organization/clients', {
                title: 'Clients',
                templateUrl: 'partials/careOrg/client/clients.html',
                controller: 'orgCtrl'
            })
            // FOR ADMIN PORTAL END

            // FOR ADMIN PORTAL FORM BUILDER START
            .when('/organization/form-builder', {
                title: 'Clients',
                templateUrl: 'partials/careOrg/form-builder/form-builder.html',
                controller: 'orgCtrl'
            })
            .otherwise({
                title: 'Page Not Found',
                templateUrl: 'partials/includes/pagenotfound.html',
                controller: 'authCtrl',
            });
}])
.run(function ($rootScope, $route, $location, Data) {
    $rootScope.$on("$routeChangeStart", function (event, next, current) {
        if($location.$$host == 'localhost') {
            var hostName = $location.$$protocol + '://' + $location.$$host;            
            $rootScope.baseUrl = hostName+'/stealthcare/';
        } else {
            $rootScope.baseUrl = $location.$$protocol + '://' + $location.$$host + '/';  
        }
        $rootScope.authenticated = false;
        $rootScope.loading = true;
        $rootScope.onlyNumbers = /^\d+$/;
        Data.get('Session').then(function (results) {
            if (results.UserID) {
                $rootScope.authenticated = true;
                $rootScope.UserID = results.UserID;
                $rootScope.UserName = results.UserName;
                $rootScope.EmailID = results.EmailID;
                $rootScope.UserAccess = results.UserAccess;
                $rootScope.ProfilePhoto = results.ProfilePhoto;
                $rootScope.DashboardLogo = results.DashboardLogo;
                $rootScope.CareOrgProfilePhoto = results.CareOrgProfilePhoto;
                $rootScope.CareOrgDashboardLogo = results.CareOrgDashboardLogo;
                var nextUrl = next.$$route.originalPath;
                //alert(nextUrl);
                if (nextUrl == '/') {
                    if (results.UserAccess == 'ADMIN') {
                        $location.path('organization');
                        $rootScope.loading = false;
                    } else {
                        $location.path("");
                        $rootScope.loading = false;
                    }
                } else if (nextUrl == '/careOrgs') {
                    Data.get('CareOrga').then(function (results) {
                        $rootScope.UserData = results.response_data;
                        //Data.toast(results);
                        $rootScope.loading = false;
                    });
                } else if (nextUrl == '/license/plans') {
                    Data.get('LicensePlans').then(function (results) {
                        $rootScope.LicensePlans = results.response_data;
                        //Data.toast(results);
                        $rootScope.loading = false;
                    });
                } else if (nextUrl == '/licenses') {
                    Data.get('Licenses').then(function (results) {
                        //Data.toast(results);
                        $rootScope.Licenses = results.response_data;
                        $rootScope.loading = false;
                    });
                } else {
                    $rootScope.loading = false;
                }
                //alert(nextUrl);
            } else {
                $rootScope.UserID = '';
                var nextUrl = next.$$route.originalPath;
                if (nextUrl == '/signup' || nextUrl == '/') {

                } else {
                    $location.path("");
                }
                $rootScope.loading = false;
            }
        });
    });
});

app.directive('numbersOnly', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attr, ngModelCtrl) {
            function fromUser(text) {
                if (text) {
                    var transformedInput = text.replace(/[^0-9]/g, '');

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

app.directive("mwInputRestrict", [
    function () {
        return {
            restrict: "A",
            link: function (scope, element, attrs) {
                element.on("keypress", function (event) {
                    if (attrs.mwInputRestrict === "onlynumbers") {
                        // allow only digits to be entered, or backspace and delete keys to be pressed
                        return (event.charCode >= 48 && event.charCode <= 57) ||
                               (event.keyCode === 8 || event.keyCode === 46);
                    }
                    return true;
                });
            }
        }
    }
]);


app.directive('stringNumber', function() {
  return {  
        restrict: 'A',  
        link: function (scope, elm, attrs, ctrl) {  
            elm.on('keypress', function (event) {  
                var $input = $(this);  
                var value = $input.val();  
                value = value.replace(/[^0-9]/g, '')  
                $input.val(value);  
                if (event.which == 64 || event.which == 16) {  
                    // to allow numbers  
                    return false;  
                } else if (event.which >= 48 && event.which <= 57) {  
                    // to allow numbers  
                    return true;  
                } else if (event.which >= 96 && event.which <= 105) {  
                    // to allow numpad number  
                    return true;  
                } else if ([8, 13, 27, 37, 38, 39, 40].indexOf(event.which) > -1) {  
                    // to allow backspace, enter, escape, arrows  
                    return true;  
                } else {  
                    event.preventDefault();  
                    // to stop others  
                    //alert("Sorry Only Numbers Allowed");  
                    return false;  
                }  
            });  
        }  
    }  
});  

app.directive("datepicker", function () {
  return {
    restrict: "A",
    require: "ngModel",
    link: function (scope, elem, attrs, ngModelCtrl) {
      var updateModel = function (dateText) {
        scope.$apply(function () {
          ngModelCtrl.$setViewValue(dateText);
        });
      };
      var options = {
        dateFormat: "dd/mm/yy",
        onSelect: function (dateText) {
          updateModel(dateText);
        }
      };
      elem.datepicker(options);
    }
  }
});

app.run([
    '$builder', function($builder) {
      /*$builder.registerComponent('sampleInput', {
        group: 'from html',
        label: 'Sample',
        description: 'From html template',
        placeholder: 'placeholder',
        required: false,
        validationOptions: [
          {
            label: 'none',
            rule: '/.*'
          /*}, {
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
        templateUrl: 'assets/form-builder/template.html',
        popoverTemplateUrl: 'assets/form-builder/popoverTemplate.html'
      });*/
      return $builder.registerComponent('name', {
        group: 'Default',
        label: 'Postal Code',
        required: false,
        arrayToText: true,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-md-12 control-label\" ng-class=\"{'fb-required':required}\">{{label}} <i class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-md-8\">\n        <input type='hidden' ng-model=\"inputText\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\"/>\n        <div class=\"col-sm-6\" style=\"padding-left: 0;\">\n            <input type=\"text\"\n                ng-model=\"inputArray[0]\"\n                class=\"form-control\" id=\"{{formName+index}}-0\"/>\n             </div>\n        <div class=\"col-sm-6\" style=\"padding-left: 0;\">\n            <input type=\"text\"\n                ng-model=\"inputArray[1]\"\n                class=\"form-control\" id=\"{{formName+index}}-1\"/>\n             </div>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n    Required?        <input type='checkbox' ng-model=\"required\" />\n   </label>\n    </div>\n\n  <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n    </div>\n</form>"
      });
    }
  ]).controller('DemoController', [
    '$scope', '$builder', '$validator', function($scope, $builder, $validator) {
      /*var checkbox, textbox;
      textbox = $builder.addFormObject('default', {
        id: 'textbox',
        component: 'textInput',
        label: 'Name',
        description: 'Your name',
        placeholder: 'Your name',
        required: true,
        editable: false
      });
      checkbox = $builder.addFormObject('default', {
        id: 'checkbox',
        component: 'checkbox',
        label: 'Pets',
        description: 'Do you have any pets?',
        options: ['Dog', 'Cat']
      });
      $builder.addFormObject('default', {
        component: 'sampleInput'
      });
      $builder.addFormObject('default', {
        component: 'header'
      });*/
      $scope.form = $builder.forms['default'];
      $scope.input = [];
      $scope.defaultValue = {};
      //$scope.defaultValue[textbox.id] = 'default value';
      //$scope.defaultValue[checkbox.id] = [true, true];
      return $scope.submit = function() {
        return $validator.validate($scope, 'default').success(function() {
          return console.log('success');
        }).error(function() {
          return console.log('error');
        });
      };
    }
]);