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
			.when('/organisation/equipments/create', {
                title: 'Add Equipments',
                templateUrl: 'partials/careOrg/add_equipment.html',
                controller: 'orgCtrl'
            })
			.when('/organisation/equipments/edit/:id', {
                title: 'Edit Equipments',
                templateUrl: 'partials/careOrg/edit-equipment.html',
                controller: 'orgCtrl'
            })
			.when('/organisation/settings', {
                title: 'Settings',
                templateUrl: 'partials/careOrg/settings.html',
                controller: 'orgCtrl'
            })
			.when('/organisation/settings/assign_equipments', {
                title: 'Assign Equipments',
                templateUrl: 'partials/careOrg/assign_equipments.html',
                controller: 'orgCtrl'
            })
			.when('/organisation/equipmentSetting/edit/:id', {
                title: 'Edit Assign Equipments',
                templateUrl: 'partials/careOrg/edit-assign_equipments.html',
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
            .when('/organisation/roster/:time', {
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

// scheduler system for client section
app.controller('ClientSchedulerController', function ClientSchedulerController($scope, $location) {
    var query = $location.path();
    var data = query.split("/");
    var timestamp = data[3];

    var date = new Date(timestamp*1000);
    var year = date.getFullYear();
    var month = date.getMonth();
    var day = date.getDate();
    var actionDate = year + '-' + month + '-' + day;

    var visitData = [{
        id: 1,
        visitname: "Test 1",
        task: {"0":"Howard Hawks","1":"Howard Hawks"},
        outcomesachived: "yes",
        status: "complete",
        client: "Martin",
        careworker: "Jhon Smith",
        color: "#80BCA2"
    }, {
        id: 2,
        visitname: "Test 2",
        task: {"0":"Howard Hawks","1":"Howard Hawks"},
        outcomesachived: "no",
        status: "missed",
        client: "Martin",
        careworker: "Jhon",
        color: "#EAB624"
    }, {
        id: 3,
        visitname: "Test 3",
        task: {"0":"Howard Hawks","1":"Howard Hawks"},
        outcomesachived: "no",
        status: "incomplete",
        client: "Martin",
        careworker: "Jhon",
        color: "#DA4F4E"
    }];

    var clientData = [{
            text: "Martin 1",
            id: 1
        }, {
            text: "Martin 2",
            id: 2
        }, {
            text: "Martin 3",
            id: 3
        }, {
            text: "Martin 4",
            id: 4
        }, {
            text: "Martin 5",
            id: 5
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
            ClientId: 1,
            VisitID: 1,
            CareWorkerID: 2,
            startDate: new Date(2015, 4, 24, 9, 10),
            endDate: new Date(2015, 4, 24, 11, 1)
        }, {
            ClientId: 2,
            VisitID: 2,
            CareWorkerID: 1,
            startDate: new Date(2015, 4, 24, 11, 30),
            endDate: new Date(2015, 4, 24, 13, 2)
        }, {
            ClientId: 3,
            VisitID: 3,
            CareWorkerID: 1,
            startDate: new Date(2015, 4, 24, 12, 30),
            endDate: new Date(2015, 4, 24, 13, 1)
        }
    ];

    function showToast(event, value, type) {
        DevExpress.ui.notify(event +" \"" + value + "\"" + " task", type, 800);
    }

    $scope.options = {
        dataSource: visitTimeData,
        currentView: "timelineDay",
        currentDate: actionDate,
        firstDayOfWeek: 0,
        startDayHour: 7,
        endDayHour: 31,
        showAllDayPanel: false,
        width: "100%",
        height: 250,
        onAppointmentAdded: function(e) {
            showToast("Added", e.appointmentData.visitname, "success");
        },
        onAppointmentUpdated: function(e) {
            alert('update');
        },
        onAppointmentDeleted: function(e) {
            alert('delete');
        },
        groups: ["ClientId"],
        crossScrollingEnabled: true,
        cellDuration: 60,
        editing: { 
            allowAdding: true
        },
        resources: [{ 
            fieldExpr: "VisitID",
            dataSource: visitData,
            useColorAsDefault: true
        }, { 
            fieldExpr: "ClientId", 
            dataSource: clientData
        }],
        appointmentTooltipTemplate: "tooltip-template",
        appointmentTemplate: "appointment-template",
        onAppointmentFormCreated: function(data) {
            var form = data.form,
                visitInfo = getMovieById(data.appointmentData.VisitID) || {},
                startDate = data.appointmentData.startDate;
    
                form.option("items", [{
                    label: {
                        text: "Title"
                    },
                    name: "visitname",
                    editorType: "dxTextBox",
                    editorOptions: {
                        value: visitInfo.visitname,
                        readOnly: false
                    }
                }, {
                    label: {
                        text: "Care Worker"
                    },
                    editorType: "dxSelectBox",
                    dataField: "CareWorkerID",
                    editorOptions: {
                        items: careworkerData,
                        displayExpr: "text",
                        valueExpr: "id",
                        onValueChanged: function(args) {
                            visitInfo = getMovieById(args.value);
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
                                    60 * 1000 * visitInfo.duration));
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
        for(var i = 0; i < visitTimeData.length; i++) {
            if(visitTimeData[i].startDate.getTime() === objData.startDate.getTime() && visitTimeData[i].ClientId === objData.ClientId) {
                result = visitTimeData[i];
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

    //var r = $('.dx-scheduler-all-day-title').text();
    //alert(r);
});

// scheduler system for care worker section
/*app.controller('CareWorkerSchedulerController', function CareWorkerSchedulerController($scope) {
    var visitData = [{
        id: 1,
        text: "Test 1",
        task: ["Howard Hawks","Howard Hawks"],
        outcomesachived: "yes",
        status: "complete",
        client: "Martin",
        careworker: "Jhon Smith",
        color: "#80BCA2"
    }, {
        id: 2,
        text: "Test 2",
        task: ["Howard Hawks","Howard Hawks"],
        outcomesachived: "no",
        status: "missed",
        client: "Martin",
        careworker: "Jhon",
        color: "#EAB624"
    }, {
        id: 3,
        text: "Test 3",
        task: ["Howard Hawks","Howard Hawks"],
        outcomesachived: "no",
        status: "incomplete",
        client: "Martin",
        careworker: "Jhon",
        color: "#DA4F4E"
    }];

    var clientData = [{
            text: "Martin 1",
            id: 1
        }, {
            text: "Martin 2",
            id: 2
        }, {
            text: "Martin 3",
            id: 3
        }, {
            text: "Martin 4",
            id: 4
        }, {
            text: "Martin 5",
            id: 5
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
            ClientId: 1,
            VisitID: 1,
            CareWorkerID: 2,
            startDate: new Date(2015, 4, 24, 9, 10),
            endDate: new Date(2015, 4, 24, 11, 1)
        }, {
            ClientId: 2,
            VisitID: 2,
            CareWorkerID: 1,
            startDate: new Date(2015, 4, 24, 11, 30),
            endDate: new Date(2015, 4, 24, 13, 2)
        }, {
            ClientId: 3,
            VisitID: 3,
            CareWorkerID: 1,
            startDate: new Date(2015, 4, 24, 12, 30),
            endDate: new Date(2015, 4, 24, 13, 1)
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
            alert('insert');
        },
        onAppointmentUpdated: function(e) {
            alert('update');
        },
        onAppointmentDeleted: function(e) {
            alert('delete');
        },
        groups: ["ClientId"],
        crossScrollingEnabled: true,
        cellDuration: 60,
        editing: { 
            allowAdding: true
        },
        resources: [{ 
            fieldExpr: "VisitID",
            dataSource: visitData,
            useColorAsDefault: true
        }, { 
            fieldExpr: "ClientId", 
            dataSource: clientData
        }],
        //appointmentTooltipTemplate: "tooltip-template",
        appointmentTemplate: "appointment-template",
        onAppointmentFormCreated: function(data) {
            var form = data.form,
                visitInfo = getMovieById(data.appointmentData.VisitID) || {},
                startDate = data.appointmentData.startDate;
    
                form.option("items", [{
                    label: {
                        text: "Title"
                    },
                    name: "visitname",
                    editorType: "dxTextBox",
                    editorOptions: {
                        value: visitInfo.text,
                        readOnly: true
                    }
                }, {
                    label: {
                        text: "Care Worker"
                    },
                    editorType: "dxSelectBox",
                    dataField: "CareWorkerID",
                    editorOptions: {
                        items: careworkerData,
                        displayExpr: "text",
                        valueExpr: "id",
                        onValueChanged: function(args) {
                            visitInfo = getMovieById(args.value);
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
                                    60 * 1000 * visitInfo.duration));
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
            if(data[i].startDate.getTime() === objData.startDate.getTime() && data[i].ClientId === objData.ClientId) {
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
*/