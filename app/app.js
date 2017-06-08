'use strict';
var app = angular.module('myApp', ['ngRoute', 'dx', 'ui.bootstrap', 'ngAnimate', 'toaster', 'datatables', 'angularUtils.directives.dirPagination', 'builder', 'builder.components', 'validator.rules']);

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
                title: 'Care Organiser',
                templateUrl: 'partials/care_orga.html',
                controller: 'authCtrl'
            })
            .when('/careOrg/create', {
                title: 'Create Care Organiser',
                templateUrl: 'partials/create_care_orga.html',
                controller: 'authCtrl'
            })
            .when('/careOrg/edit/:id', {
                title: 'Update Care Organiser',
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
            .when('/form-builder', {
                title: 'Form Builder',
                templateUrl: 'partials/form-builder.html',
                controller: 'authCtrl'
            })
            .when('/form-builder/edit/:id', {
                title: 'Edit Form',
                templateUrl: 'partials/edit-form-builder.html',
                controller: 'authCtrl'
            })
			.when('/qualification/create', {
                title: 'Create Qualification',
                templateUrl: 'partials/create_qualification.html',
                controller: 'authCtrl'
            })
			.when('/qualification', {
                title: 'Qualification',
                templateUrl: 'partials/qualification.html',
                controller: 'authCtrl'
            })
			.when('/qualification/edit/:id', {
                title: 'Edit Qualification',
                templateUrl: 'partials/edit-qualification.html',
                controller: 'authCtrl'
            })
            /*.when('/', {
                title: 'blank',
                templateUrl: 'partials/blank.html',
                controller: 'authCtrl'
            })*/  
            // FOR SUPERADMIN PORTAL END

            // FOR ADMIN PORTAL START
            .when('/organisation', {
                title: 'Organisation Dashboard',
                templateUrl: 'partials/careOrg/dashboard.html',
                controller: 'orgCtrl'
            })
            .when('/organisation/client/registration', {
                title: 'Organization Dashboard',
                templateUrl: 'partials/careOrg/client/registration.html',
                controller: 'orgCtrl'
            })
            .when('/organisation/client/create', {
                title: 'Create Client',
                templateUrl: 'partials/careOrg/client/add_client.html',
                controller: 'orgCtrl'
            })
            .when('/organisation/clients', {
                title: 'Clients',
                templateUrl: 'partials/careOrg/client/clients.html',
                controller: 'orgCtrl'
            })
			.when('/organisation/equipments', {
                title: 'Equipments',
                templateUrl: 'partials/careOrg/equipment.html',
                controller: 'orgCtrl'
            })

            // FOR ADMIN PORTAL SATFF MEMBERS
            .when('/organisation/carers', {
                title: 'Staffs',
                templateUrl: 'partials/careOrg/staff/staff.html',
                controller: 'orgCtrl'
            })
            .when('/organisation/carers/create', {
                title: 'Add Staff',
                templateUrl: 'partials/careOrg/staff/add-staff-Member.html',
                controller: 'orgCtrl'
            })
			.when('/organisation/carers/edit/:id', {
                title: 'Update Staff',
                templateUrl: 'partials/careOrg/staff/edit-staff-Member.html',
                controller: 'orgCtrl'
            })

            // FOR ADMIN PORTAL FORM BUILDER START
            .when('/organisation/form-builder', {
                title: 'Form Builder',
                templateUrl: 'partials/careOrg/form-builder/form-builder.html',
                controller: 'orgCtrl'
            })
            .when('/organisation/form-builder/edit/:id/:type/:UserTyepID', {
                title: 'Form Builder',
                templateUrl: 'partials/careOrg/form-builder/edit-form-builder.html',
                controller: 'orgCtrl'
            })

            // FOR ADMIN PORTAL ROSTER START
            .when('/organisation/roster', {
                title: 'Roster',
                templateUrl: 'partials/careOrg/roster/roster.html',
                controller: 'orgCtrl'
            })

            // FOR ADMIN PORTAL END
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
                $rootScope.OrgID = results.OrgID;
                $rootScope.AdminName = results.AdminName;
                $rootScope.CareOrgProfilePhoto = results.CareOrgProfilePhoto;
                $rootScope.CareOrgDashboardLogo = results.CareOrgDashboardLogo;
                var nextUrl = next.$$route.originalPath;
                //alert(nextUrl);
                if (nextUrl == '/') {
                    if (results.UserAccess == 'ADMIN') {
                        $location.path('organisation');
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
                } else if (nextUrl == '/qualification') {
                    Data.get('Qualification').then(function (results) {
                        //Data.toast(results);
						$rootScope.loading = false;	
						if(results.status_code==0){
						   $rootScope.responsemsg = results.message;
                           $rootScope.showAlert = true;	
						}else{
						   $rootScope.showAlert = false;	
                           $rootScope.Qualification = results.response_data;						
						} 
                    });
                }else {
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

app.config(function (datepickerConfig, datepickerPopupConfig) {
  datepickerConfig.showWeeks = false;
  datepickerPopupConfig.toggleWeeksText = null;
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

/*app.directive("datepicker", function () {
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
        startDate: new Date(),
		autoclose: true,
        onSelect: function (dateText) {
          updateModel(dateText);
        }
      };
      elem.datepicker(options);
    }
  }
});*/

/*app.run([
    '$builder', function($builder) {} ]).controller('DemoController', [ '$scope', '$builder', '$validator', function($scope, $builder, $validator) {
  var json = '[{"component":"textInput","editable":true,"index":0,"label":"National ID","description":"","placeholder":"","options":[],"required":true,"validation":"[number]"},{"component":"checkbox","editable":true,"index":1,"label":"Interest","description":"","placeholder":"","options":["Games","Reading","Movies"],"required":false,"validation":"\/.*\/"},{"component":"radio","editable":true,"index":2,"label":"Gender","description":"","placeholder":"","options":["Male","Female"],"required":false,"validation":"\/.*\/"},{"component":"select","editable":true,"index":3,"label":"Country","description":"","placeholder":"","options":["Egypt","Russia"],"required":false,"validation":"\/.*\/"},{"component":"textArea","editable":true,"index":4,"label":"Feedback","description":"","placeholder":"","options":[],"required":false,"validation":"\/.*\/"}]'; 

  var component = $.parseJSON(json);
  $.each(component, function(i, item){
      var formObj = $builder.addFormObject('default', item);
  });
  $scope.form = $builder.forms['default'];
  }
]);*/



app.directive('ngNicescroll', ngNicescroll);
ngNicescroll.$inject = ['$rootScope'];

/* @ngInject */
function ngNicescroll($rootScope) {
    // Usage:
    //
    // Creates:
    //
    var directive = {
        link: link
    };
    return directive;

    function link(scope, element, attrs, controller) {

        var niceOption = scope.$eval(attrs.niceOption)

        var niceScroll = $(element).niceScroll(niceOption);
        niceScroll.onscrollend = function (data) {
            if (data.end.y >= this.page.maxh) {
                if (attrs.niceScrollEnd) scope.$evalAsync(attrs.niceScrollEnd);

            }
        };


        scope.$on('$destroy', function () {
            if (angular.isDefined(niceScroll)) {
                niceScroll.remove()
            }
        })


    }
}

app.controller('ClientSchedulerControllers', function ClientSchedulerControllers($scope) {
    var resourcesData = [
        {
            text: "John",
            id: 1,
            color: "#cb6bb2"
        },{
            text: "John Smith",
            id: 2,
            color: "#cb6bb2"
        }
    ];

    var clientData = [
        {
            text: "Martin",
            id: 1,
            color: "#1e90ff"
        }, {
            text: "Martin",
            id: 2,
            color: "#ff9747"
        }, {
            text: "Martin",
            id: 3,
            color: "#ff9747"
        }, {
            text: "Martin",
            id: 4,
            color: "#ff9747"
        }, {
            text: "Martin",
            id: 5,
            color: "#ff9747"
        }
    ];

    var data = [{
        "text": "Google AdWords Strategy",
        "ownerId": [2],
        "startDate": new Date(2016, 1, 1, 9, 0),
        "endDate": new Date(2016, 1, 1, 12, 30),
        "priority": 5
    }];

    $scope.schedulerOptions = {
        dataSource: data,
        allDayExpr: "Test",
        //views: ["timelineDay", "timelineWeek", "timelineWorkWeek", "timelineMonth"],
        currentView: "timelineDay",
        currentDate: new Date(2016, 1, 1),
        firstDayOfWeek: 0,
        startDayHour: 7,
        endDayHour: 31,
        cellDuration: 60,
        editing: { 
            allowAdding: true
        },
        groups: ["priority"],
        resources: [{
            fieldExpr: "ownerId",
            allowMultiple: false,
            dataSource: resourcesData,
            label: "Care Worker",
            useColorAsDefault: true
        }, { 
            fieldExpr: "priority",
            allowMultiple: false,
            dataSource: clientData
        }],
        width: "100%",
        height: 280
    };
});


app.controller('CareWorkerSchedulerController', function CareWorkerSchedulerController($scope) {
    
    var resourcesData = [
        {
            text: "Martin",
            id: 1,
            color: "#cb6bb2"
        }
    ];

    var careworkerData = [
        {
            text: "John",
            id: 1,
            color: "#1e90ff"
        }, {
            text: "John Smith",
            id: 2,
            color: "#ff9747"
        }, {
            text: "John Smith New",
            id: 3,
            color: "#ff9747"
        }
    ];

    var data = [{
        "text": "Google AdWords Strategy",
        "ownerId": [1],
        "startDate": new Date(2016, 1, 1, 9, 0),
        "endDate": new Date(2016, 1, 1, 10, 30),
        "priority": 1
    }];

    $scope.schedulerOptions = {
        dataSource: data,
        //views: ["timelineDay", "timelineWeek", "timelineWorkWeek", "timelineMonth"],
        currentView: "timelineDay",
        currentDate: new Date(2016, 1, 1),
        firstDayOfWeek: 0,
        startDayHour: 7,
        endDayHour: 31,
        cellDuration: 60,
        groups: ["priority"],
        resources: [{
            fieldExpr: "ownerId",
            allowMultiple: false,
            dataSource: resourcesData,
            label: "Client",
            useColorAsDefault: true
        }, { 
            fieldExpr: "priority",
            allowMultiple: false,
            dataSource: careworkerData
        }],
        width: "100%",
        height: 280
    };
});
























app.controller('ClientSchedulerController', function ClientSchedulerController($scope) {
    var visitData = [{
        id: 1,
        text: "Test 1",
        director: "Howard Hawks",
        year: "1940",
        image: "images/movies/HisGirlFriday.jpg",
        duration: 92,
        color: "#cb6bb2"
    }, {
        id: 2,
        text: "Test 2",
        director: "Stanley Donen",
        year: "1951",
        image: "images/movies/RoyalWedding.jpg",
        duration: 93,
        color: "#56ca85"
    }, {
        id: 3,
        text: "Test 3",
        director: "William A. Wellman",
        year: "1937",
        image: "images/movies/AStartIsBorn.jpg",
        duration: 111,
        color: "#1e90ff"
    }, {
        id: 4,
        text: "Test 4",
        director: "Alex Nicol",
        year: "1958",
        image: "images/movies/ScreamingSkull.jpg",
        duration: 68,
        color: "#ff9747"
    }, {
        id: 5,
        text: "Test 5",
        director: "Frank Capra",
        year: "1946",
        image: "images/movies/ItsAWonderfulLife.jpg",
        duration: 130,
        color: "#f05797"
    }, {
        id: 6,
        text: "Test 6",
        director: "Charlie Chaplin",
        year: "1931",
        image: "images/movies/CityLights.jpg",
        duration: 87,
        color: "#2a9010"
    }];

    var clientData = [{
            text: "Martin 1",
            id: 0
        }, {
            text: "Martin 2",
            id: 1
        }, {
            text: "Martin 3",
            id: 2
        }, {
            text: "Martin 4",
            id: 3
        }, {
            text: "Martin 5",
            id: 4
        }
    ];

    var careworkerData = [
        {
            text: "John",
            id: 1,
            color: "#1e90ff"
        }, {
            text: "John Smith",
            id: 2,
            color: "#ff9747"
        }, {
            text: "John Smith New",
            id: 3,
            color: "#ff9747"
        }
    ];

    var visitTimeData = [{
            theatreId: 0,
            movieId: 3,
            price: 10,
            startDate: new Date(2015, 4, 24, 9, 10),
            endDate: new Date(2015, 4, 24, 11, 1)
        }, {
            theatreId: 0,
            movieId: 1,
            price: 5,
            startDate: new Date(2015, 4, 24, 11, 30),
            endDate: new Date(2015, 4, 24, 13, 2)
        }
    ];

    $scope.options = {
        dataSource: visitTimeData,
        currentView: "timelineDay",
        currentDate: new Date(2015, 4, 24),
        firstDayOfWeek: 0,
        startDayHour: 7,
        endDayHour: 31,
        showAllDayPanel: false,
        width: "100%",
        height: 250,
        onAppointmentAdded: function(e) {
            alert('sadasdasd');
        },
        onAppointmentUpdated: function(e) {
            showToast("Updated", e.appointmentData.text, "info");
        },
        onAppointmentDeleted: function(e) {
            showToast("Deleted", e.appointmentData.text, "warning");
        },
        groups: ["theatreId"],
        crossScrollingEnabled: true,
        cellDuration: 60,
        editing: { 
            allowAdding: true
        },
        resources: [{ 
            fieldExpr: "movieId",
            dataSource: visitData,
            useColorAsDefault: true
        }, { 
            fieldExpr: "theatreId", 
            dataSource: clientData
        }],
        //appointmentTooltipTemplate: "tooltip-template",
        appointmentTemplate: "appointment-template",
        onAppointmentFormCreated: function(data) {
            var form = data.form,
                movieInfo = getMovieById(data.appointmentData.movieId) || {},
                startDate = data.appointmentData.startDate;
    
                form.option("items", [{
                    label: {
                        text: "Title"
                    },
                    name: "visitname",
                    editorType: "dxTextBox"
                }, {
                    label: {
                        text: "Care Worker"
                    },
                    editorType: "dxSelectBox",
                    editorOptions: {
                        items: careworkerData,
                        displayExpr: "text",
                        valueExpr: "id",
                        onValueChanged: function(args) {
                            movieInfo = getMovieById(args.value);
                            form.getEditor("director")
                                .option("value", movieInfo.director);
                            form.getEditor("endDate")
                                .option("value", new Date (startDate.getTime() +
                                    60 * 1000 * movieInfo.duration));
                        }
                    }
                }, {
                    dataField: "startDate",
                    editorType: "dxDateBox",
                    editorOptions: {
                        type: "datetime",
                        onValueChanged: function(args) {
                            startDate = args.value;
                            form.getEditor("endDate")
                                .option("value", new Date (startDate.getTime() +
                                    60 * 1000 * movieInfo.duration));
                        }
                    }
                }, {
                    name: "endDate",
                    dataField: "endDate",
                    editorType: "dxDateBox",
                    editorOptions: {
                        type: "datetime",
                        readOnly: true
                    }
                }
            ]);
        }
    };
    
    $scope.getMovieById = getMovieById; 
    $scope.editDetails = function (showtime) {
        $('#scheduler').dxScheduler('instance').showAppointmentPopup(getDataObj(showtime), false);
    };
    
    function getDataObj(objData) {
        var result;
        for(var i = 0; i < data.length; i++) {
            if(data[i].startDate.getTime() === objData.startDate.getTime() && data[i].theatreId === objData.theatreId) {
                result = data[i];
                break;
            }
        }
        return result;
    }
    
    function getMovieById(id) {
        return DevExpress.data.query(visitData)
                .filter("id", id)
                .toArray()[0];
    }
});