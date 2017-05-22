app.controller('authCtrl', function ($scope, $log, $timeout, $rootScope, $templateCache, $window, $route, $routeParams, $location, $http, Data) {
    //initially set those objects to null to avoid undefined error
    $scope.login = {};
    $scope.signup = {
        MinQty: 0,
        MaxQty: 1
    };
    $scope.pageSize = 10;
    var serviceBase = 'api/v1/api.php?request=';

   
    $scope.fileReaderSupported = window.FileReader != null;
    $scope.profilePhotoChanged = function(files){
        if (files != null) {
            var file = files[0];
            if ($scope.fileReaderSupported && file.type.indexOf('image') > -1) {
                $timeout(function() {
                    var fileReader = new FileReader();
                    fileReader.readAsDataURL(file);
                    fileReader.onload = function(e) {
                        $timeout(function(){
                        $scope.resultData.ProfilePhoto = e.target.result;
                        });
                    }
                });
            }
        }
    };
    $scope.dashboardPhotoChanged = function(files){
        if (files != null) {
            var file = files[0];
            if ($scope.fileReaderSupported && file.type.indexOf('image') > -1) {
                $timeout(function() {
                    var fileReader = new FileReader();
                    fileReader.readAsDataURL(file);
                    fileReader.onload = function(e) {
                        $timeout(function(){
                        $scope.resultData.DashboardLogo = e.target.result;
                        });
                    }
                });
            }
        }
    };

    // restrict SuperAdmin OnLoading 
    $scope.restrictSuperAdminOnLoading = function () {
        Data.get('Session').then(function (results) {
            if (results.UserID) {
                //alert(results.UserAccess);
                if (results.UserAccess == 'ADMIN') {
                    $location.path('organisation');
                }
            }
        });
    };

    $scope.loadCurrntActiveClassForauthCtrlSidebarMenu = function (ActiveClass) {
        $rootScope.activeClass = ActiveClass;
    };

    $scope.loadCurrntPageTitle = function (pageTitle) {
        $rootScope.pageTitle = pageTitle;
    };

    $scope.editAdminload = function (UserID) {
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({UserID: UserID}),
            url: serviceBase+'editAdminload',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            $rootScope.resultData = results.response_data;
            $scope.loading = false;
        });           
    };

    $scope.updateAdminProfile = function (reqparams, UserID) {
        var UserID = UserID;
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams, UserID: UserID}),
            url: serviceBase+'editAdminload',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if (results.status == "error") {
                Data.toast(results);
                $scope.loading = false;
            } else {
                Data.toast(results);
                $scope.loading = false;
                $timeout(function() {
                  $window.location.href = ''; 
                }, 1500);
            }
        });
    };

    $scope.updateAdminPassword = function (reqparams, UserID) {
        var UserID = UserID;
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams, UserID: UserID}),
            url: serviceBase+'updateAdminPassword',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if (results.status == "error") {
                Data.toast(results);
                $scope.loading = false;
            } else {
                $location.path('');
                Data.toast(results);
                $scope.loading = false;
            }
        });
    };

    // login request
    $scope.doLogin = function (reqparams) {
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams}),
            url: serviceBase+'Login',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            if (results.status_code == "1") {
                $route.reload(); 
            } else if (results.status_code == "2") {
                $location.path('organisation');
            }
            $scope.loading = false;
        })
        .error(function(results){

        });
    };

    $scope.loadSelectBoxData = function (PageName) {
        $scope.loading = true;
        Data.get('loadSelectBoxData').then(function (results) {            
            $rootScope.Status = results.status_data;
            $rootScope.Plans = results.licensesplan_data;
            $location.path(PageName);
            $scope.loading = false;
        });
    };

    // Load All Forms 
    $scope.loadAllForms = function () {
        Data.get('loadAllForms').then(function (results) {
            $scope.assessorFroms = results.assessor;
            $scope.careworkerFroms = results.careworker;
        });
    };

    // create user request
    //$scope.signup = {email:'',password:'',name:'',phone:'',address:''};
    $scope.signUp = function (reqparams) {
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams}),
            url: serviceBase+'signUp',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            if (results.status_code == "1") {
                $location.path("");
            }
        })
        .error(function(results){

        });
    };

    // create organizer request
    $scope.createOrgsignUp = function (reqparams) {
        var PlanID = angular.element('#PlanID').val();
        //var StatusID = angular.element('#StatusID').val();
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams, PlanID: PlanID}),
            url: serviceBase+'createOrgsignUp',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            if (results.status_code == "1") {
                $location.path('careOrgs');
            }
        })
        .error(function(results){

        });
    };

    $scope.loadCareOrg = function (OrgID) {
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({OrgID: OrgID}),
            url: serviceBase+'updateSessionByOrgID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            $location.path('organisation');
            $scope.loading = false;
        });
    };

    $scope.editCareOrgload = function () {
        var UserID = $routeParams.id;
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({UserID: UserID}),
            url: serviceBase+'getUpdateCareOrgByID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if (results.status_code == "1") {
                $rootScope.resultData = results.response_data;
                $rootScope.Status = results.status_data;
                $rootScope.Plans = results.licensesplan_data;
                $scope.loading = false;
            }
        });
    };

    // change plan statas request
    $scope.changeStatusCareOrg = function(UserID,StatusID){
        if(confirm("Are you sure to want to change organisation status")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({UserID: UserID,StatusID: StatusID}),
                url: serviceBase+'changeStatusCareOrg',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status_code == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    }; 

    $scope.updateCareOrg = function (reqparams) {
        var UserID = $routeParams.id;
        var PlanID = angular.element('#PlanID').val();
        var StatusID = angular.element('#StatusID').val();
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams, UserID: UserID, PlanID: PlanID, StatusID: StatusID}),
            url: serviceBase+'getUpdateCareOrgByID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if (results.status_code == "1") {
                Data.toast(results);
                $rootScope.resultData = results.response_data;
                $rootScope.Status = results.status_data;
                $rootScope.Plans = results.licensesplan_data;
                $scope.loading = false;
            }
        });
    };

    // create plan statas request
    $scope.createPlan = function (reqparams) {
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams}),
            url: serviceBase+'createPlan',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            if (results.status_code == "1") {
                $location.path('license/plans');
            }
        })
        .error(function(results){

        });
    };

    $scope.editPlanload = function () {
        var PlanID = $routeParams.id;
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({PlanID: PlanID}),
            url: serviceBase+'getUpdatePlanByID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if (results.status_code == "1") {
                $rootScope.resultData = results.response_data;
                $rootScope.Status = results.status_data;
                $scope.loading = false;
            }
        });
    };

    // edit plan statas request
    $scope.updatePlan = function(reqparams){
        $scope.loading = true;
        var PlanID = $routeParams.id;
        var StatusID = angular.element('#StatusID').val();
        //alert(StatusID);
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams,PlanID: PlanID,StatusID: StatusID}),
            url: serviceBase+'getUpdatePlanByID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            if (results.status_code == "1") {
                $rootScope.resultData = results.response_data;
                $rootScope.Status = results.status_data;
            }
            $scope.loading = false;
        });
    };

    // delete plan statas request
    $scope.deletePlan = function(index){
        if(confirm("Are you sure to want to delete plan")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({PlanID: index}),
                url: serviceBase+'deletePlan',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status_code == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    };

    // change plan statas request
    $scope.changeStatusPlan = function(PlanID,StatusID){
        if(confirm("Are you sure to want to change plan status")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({PlanID: PlanID,StatusID: StatusID}),
                url: serviceBase+'changeStatusPlan',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status_code == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    }; 

    // create license request
    $scope.createLicense = function (reqparams) {
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams}),
            url: serviceBase+'createLicense',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            if (results.status_code == "1") {
                $location.path('licenses');
                $scope.loading = false;
            }
        })
    }; 

    $scope.editLicenseload = function () {
        var LicenseID = $routeParams.id;
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({LicenseID: LicenseID}),
            url: serviceBase+'getUpdateLicenseByID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if (results.status_code == "1") {
                $rootScope.resultData = results.response_data;
                $rootScope.Status = results.status_data;
                $scope.loading = false;
            }
        });
    };

    // change plan statas request
    $scope.changeStatusLicense = function(LicenseID,StatusID){
        if(confirm("Are you sure to want to change license status")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({LicenseID: LicenseID,StatusID: StatusID}),
                url: serviceBase+'changeStatusLicense',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status_code == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    }; 

    // edit plan statas request
    $scope.updateLicense = function(reqparams){
        $scope.loading = true;
        var LicenseID = $routeParams.id;
        var StatusID = angular.element('#StatusID').val();
        //alert(StatusID);
        $http({
            method: 'post',
            data: $.param({reqparams: reqparams,LicenseID: LicenseID,StatusID: StatusID}),
            url: serviceBase+'getUpdateLicenseByID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if (results.status_code == "1") {
                Data.toast(results);
                $rootScope.resultData = results.response_data;
                $rootScope.Status = results.status_data;
                $scope.loading = false;
            }
        });
    };

    // delete plan statas request
    $scope.deleteLicense = function(index){
        if(confirm("Are you sure to want to delete License")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({LicenseID: index}),
                url: serviceBase+'deleteLicense',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status_code == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    };
    
    /*$scope.LicensePlans = function () {
       $scope.loading = true;
        Data.get('LicensePlans').then(function (results) {
            $scope.UserData = results.response_data;
            Data.toast(results);
            $location.path('license_plans');
            $scope.loading = false;
        });
    }
    $scope.CareOrga = function () {
        $scope.loading = true;
        Data.get('CareOrga').then(function (results) {
            $scope.UserData = results.response_data;
            Data.toast(results);
            $location.path('care_orga');
            $scope.loading = false;
        });
    }*/

    //************************* For form builder module ****************************//

    $( "#showModal" ).hide();
    // create Document request
    $scope.createDocument = function () {
        $( "#showModal" ).show();
    };

    $scope.createDocumentOk = function (reqparams) {
        $( "#showModal" ).hide();
        $( ".forms-default" ).hide();
        var UserTypeID = angular.element('#UserTypeID').val();
        $('#fb-builder').css('display','block');
        $('#fb-builder').css('border-top','1px dashed');
        $('#fb-builder').css('border-bottom','1px dashed');
        $('.formBuilderActionBtn').css('display','block');
        $( "#UTID" ).text(UserTypeID);
    };

    $scope.cancel = function () {
        $( "#showModal" ).hide();
    }

    // edit Document request
    $scope.editDocument = function (reqparams) {
        $('.formBuilderActionBtn').css('display','block');
    };

    var query = $location.path();
    var data = query.split("/");
    $scope.FormID = data[3];

    // Duplicate Document statas request
    $scope.duplicateDocument = function(index){
        if(confirm("Are you sure to want to create duplicate document")){
            $scope.loading = true;
            var FormDataJson = angular.element('#isShowScope').text();
            var FormDataJsonValue = angular.element('#isShowValueScope').text();
            $http({
                method: 'post',
                data: $.param({FormDataJson: FormDataJson,FormDataJsonValue: FormDataJsonValue}),
                url: serviceBase+'saveForm',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                $window.location.href = 'form-builder';
                $scope.loading = false;
            });
        }
    };

    // delete Document statas request
    $scope.deleteDocument = function(index){
        if(confirm("Are you sure to want to delete this document")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({FormID: index}),
                url: serviceBase+'deleteDocument',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status_code == "1") {
                    $location.path('form-builder');
                }
                $scope.loading = false;
            });
        }
    };

    // call Form request
    $scope.callForm = function (id) {
        $scope.loading = true;
        $window.location.href = 'form-builder/edit/'+id;
        $scope.loading = false;
    }; 
    $scope.callAllForms = function () {
        $window.location.href = 'form-builder';
    };

    // cancel Form request
    $scope.cancelForm = function () {
        $scope.loading = true;
        $templateCache.removeAll();
        $window.location.reload();
        $scope.loading = false;
    }; 

    // view Form request
    $scope.viewForm = function () {
        $scope.loading = true;
        $('.viewForm').css('display','block');
        $('html, body').animate({
              scrollTop: $(".viewForm").offset().top
        }, 1000);
        $scope.loading = false;
    }; 

    // save form request
    $scope.saveForm = function(){
        $scope.loading = true;
        var FormDataJson = angular.element('#isShowScope').text();
        var FormDataJsonValue = angular.element('#isShowValueScope').text();
        var UserTypeID = angular.element('#UTID').text();
        //alert(StatusID);
        $http({
            method: 'post',
            data: $.param({FormDataJson: FormDataJson,FormDataJsonValue: FormDataJsonValue,UserTypeID: UserTypeID}),
            url: serviceBase+'saveForm',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            $templateCache.removeAll();
            $window.location.reload();
            $scope.loading = false;
        });
    };

    // update form request
    $scope.updateForm = function(FormID){
        $scope.loading = true;
        var FormDataJson = angular.element('#isShowScope').text();
        //alert(StatusID);
        $http({
            method: 'post',
            data: $.param({FormDataJson: FormDataJson,FormID: FormID}),
            url: serviceBase+'updateForm',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            $window.location.href = 'form-builder';
            $scope.loading = false;
        });
    };
	

    // logout request
    $scope.logout = function () {
        $scope.loading = true;
        Data.get('Logout').then(function (results) {
            Data.toast(results);
            $route.reload(); 
            $scope.loading = false;
        });
    }
});



app.run([
    '$builder', function($builder) {
      return $builder.registerComponent('postCode', {
        group: 'Default',
        label: 'Postal Code',
        required: false,
        arrayToText: true,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-md-12 control-label\" ng-class=\"{'fb-required':required}\">{{label}} <i class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-md-8\">\n        <input type='hidden' ng-model=\"inputText\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\"/>\n        <div class=\"col-sm-6\" style=\"padding-left: 0;\">\n            <input type=\"text\"\n                ng-model=\"inputArray[0]\"\n                class=\"form-control\" id=\"{{formName+index}}-0\"/>\n             </div>\n        <div class=\"col-sm-6\" style=\"padding-left: 0;\">\n            <input type=\"text\"\n                ng-model=\"inputArray[1]\"\n                class=\"form-control\" id=\"{{formName+index}}-1\"/>\n             </div>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n    Required?        <input type='checkbox' ng-model=\"required\" />\n   </label>\n    </div>\n\n  <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n    </div>\n</form>"
      });
    }
  ]).controller('DemoController', [
    '$scope', '$builder', '$http', '$location', '$validator', function($scope, $builder, $http, $location, $validator) {
        var serviceBase = 'api/v1/api.php?request=';
        var query = $location.path();
        var data = query.split("/");
        var FormID = data[3];
        $http({
            method: 'post',
            data: $.param({FormID: FormID}),
            url: serviceBase+'getForm',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if(results.status === 'success') {
                var json = results.response_data; 
                var component = $.parseJSON(json);
                $.each(component, function(i, item){
                    var formObj = $builder.addFormObject('default', item);
                });
            }
        });
        $scope.form = $builder.forms['default'];
        $scope.input = [];
        $scope.defaultValue = {};
        return $scope.submit = function() {
            return $validator.validate($scope, 'default').success(function() {
                return console.log('success');
            }).error(function() {
                return console.log('error');
            });
        };
    }
]);