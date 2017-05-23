app.controller('orgCtrl', function ($scope, $timeout, $rootScope, $window, $route, $routeParams, $location, $http, Data, DOBService) {
    //initially set those objects to null to avoid undefined error
    $scope.login = {};
    $scope.signup = {};

    $scope.mindate = new Date();

    $scope.loadCurrntOrgPageTitle = function (orgPageTitle) {
        $rootScope.orgPageTitle = orgPageTitle;
    };

    $scope.tab = 1;

    $scope.setTab = function(newTab){
      $scope.tab = newTab;
    };

    $scope.isSet = function(tabNum){
      return $scope.tab === tabNum;
    };

    /*var numberOfYears = (new Date()).getYear() - 0;
    var years = $.map($(Array(numberOfYears)), function (val, i) { return i + 1900; });
    var months = $.map($(Array(12)), function (val, i) { return i + 1; });
    var days = $.map($(Array(31)), function (val, i) { return i + 1; });

    var isLeapYear = function () {
        var year = $scope.SelectedYear || 0;
        return ((year % 400 === 0 || year % 100 !== 0) && (year % 4 === 0)) ? 1 : 0;
    }
    var getNumberOfDaysInMonth = function () {
        var selectedMonth = $scope.SelectedMonth || 0;
        return 31 - ((selectedMonth === 2) ? (3 - isLeapYear()) : ((selectedMonth - 1) % 7 % 2));
    }
    $scope.UpdateNumberOfDays = function () {
        $scope.NumberOfDays = getNumberOfDaysInMonth();
    }
    $scope.NumberOfDays = 31;
    $scope.Years = years;
    $scope.Days = days;
    $scope.Months = months;*/

    $scope.calcDays = DOBService.getDays(); 
    $scope.calcMonths = DOBService.getMonths();
    $scope.calcYears = DOBService.getYears();
    $scope.selectedDay = 0; $scope.selectedMonth = 0;

    /*Hack to remove default '?' in select dropdowns*/
    $scope.dob = {dayDefault: {name: "Day", value: "0"},
                monthDefault: {name: "Month", value: "0"},
                yearDefault: {name: "Year", value: "0"},
        collection:{},
                };

    $scope.$watch('dob.dayDefault', function (obj) {
        if(obj){
          $scope.selectedDay = obj.name;
          $scope.dob.monthDefault = {name: "Month", value: "0"};
          $scope.dob.yearDefault = {name: "Year", value: "0"};
          DOBService.changeDay(obj.name, function(err, result) {
             $scope.calcMonths = DOBService.getMonths(result);
          });
        }
    });
    $scope.$watch('dob.monthDefault', function (obj) {
        if(obj){
          $scope.dob.yearDefault = {name: "Year", value: "0"};
          $scope.selectedMonth = obj.name;
          DOBService.changeMonth({"day":$scope.selectedDay, "month":obj.value}, function(err, result) {
             $scope.calcYears = DOBService.getYears(result);
          });
        }
    });
    $scope.$watchCollection('[dob.dayDefault, dob.monthDefault, dob.yearDefault]', function(newValues, oldValues){
        $scope.dob.collection = newValues[0].value+'/'+newValues[1].value+"/"+newValues[2].value;
        //console.log($scope.dob.collection);
    });

    var serviceBase = 'api/v1/admin/restapi.php';

    $scope.loadMainMenuCurrntActiveClass = function (ActiveClass) {
        $scope.loading = true;
        $rootScope.activeClass = ActiveClass;
        $scope.loading = false;
    };
	
  	// create enquiry
	var requestID = angular.element('#requestID').val();
  	var statusid = angular.element('#statusid').val();
	if(statusid!=''){
	  $scope.signup = {id:requestID,statusid:statusid};
	}else{
	  $scope.signup = {id:requestID}; 	
	}
  	$scope.signup.title = 'Mr';
	$scope.signup.role = '3';
  	$scope.signup.gender = 'Male';
  	$scope.signup.support = 'Personal Care';
  	$scope.signup.makeenq = 'self';
	
    $scope.sendRequest = function (request,pathlink) {
		  request = angular.toJson(request);
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){							  
            Data.toast(results);
			$route.reload();
            if (results.status == "1") {  
			$route.reload();
      				//$scope.signup = {};
      				//$location.path(pathlink);
            }
        })
        .error(function(results){

        });
    };
	
	
	
$scope.sendReq = function (request,pathlink) {
		  request = angular.toJson(request);
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){	
            Data.toast(results);
			$scope.allStaff = results.responseData;
        })
        .error(function(results){

        });
		  
		  
		  
    };
	
	
	$scope.sendReqAlpha = function (name) {
		  var request = '[{"serviceRequestID":"18","name":"'+name+'"}]';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){	
            Data.toast(results);
			$scope.allStaff = results.responseData;
        })
        .error(function(results){

        });
		  
		  
		  
    };
	
	//search staff by parameters
	
	$scope.searchUniversalParam = function (param) {
		  var request = '[{"serviceRequestID":"19","param":"'+param+'"}]';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){	
            Data.toast(results);
			$scope.allStaff = results.responseData;
        })
        .error(function(results){

        });	  
    };
	
	//search staff by txt
	
	$scope.searchStaff = function (param) {
		 var searchTxt=angular.element('#searchTxt').val();
		
		  var request = '[{"serviceRequestID":"20","param":"'+param+'","searchTxt":"'+searchTxt+'"}]';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){	
            Data.toast(results);
			$scope.allStaff = results.responseData;
        })
        .error(function(results){

        });	  
    };
	
	//load staff
	
	$scope.loadAllStaff = function () {
		  var request = '[{"serviceRequestID":"17"}]';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){	
            Data.toast(results);
			$scope.allStaff = results.responseData;
        })
        .error(function(results){

        });
		  
		  
		  
    };
	
	
	$scope.toggleShow = function(){
		if($scope.showStartEvent==true){
		  var statusid = angular.element('#statusid').val('1');	
		}else{
		  var statusid = angular.element('#statusid').val('2');		
		}
       $scope.showStartEvent = !$scope.showStartEvent;
    }
	
	

	/*$scope.myhtml = function () {
        $scope.myhtml = '<div class="myclass">some content</div>';
    };*/
	

	// Profile Photo
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
                        $scope.signup.ProfilePhoto = e.target.result;
                        });
                    }
                });
            }
        }
    };

    // Load All Orgniser Forms 
    $scope.loadAllOrgniserForms = function () {
        var serviceBase = 'api/v1/api.php?request=';
        //var request = '[{"serviceRequestID":"10","OrgID":"'+OrgID+'"}]';
        $scope.loading = true;
        $http.get('Session').then(function (results) {
            var OrgID = $rootScope.OrgID;
            $http({
                method: 'post',
                data: $.param({OrgID: OrgID}),
                url: serviceBase+'loadAllFormsByOrgID',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){ 
                $scope.assessorFroms = results.assessor;
                $scope.careworkerFroms = results.careworker;
                $scope.loading = false;
            });
        });
    };

    // Load All Country
    $scope.loadAllCountry = function () {
        var request = '[{"serviceRequestID":"3"}]';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            $scope.allCountry = results.responseData;
        });
    };
    
    // logout request
    $scope.logout = function () {
        $scope.loading = true;
        Data.get('Logout').then(function (results) {
            Data.toast(results);
            $location.path("");
            $scope.loading = false;
        });
    };

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
    $scope.FormDataID = data[4];
    $scope.FormType = data[5];

    // Duplicate Document statas request
    $scope.duplicateDocument = function(OrgID){
        serviceBase = 'api/v1/api.php?request=';
        if(confirm("Are you sure to want to create duplicate document")){
            $scope.loading = true;
            var FormDataJson = angular.element('#isShowScope').text();
            var FormDataJsonValue = angular.element('#isShowValueScope').text();
            var UserTypeID = angular.element('#UTID').text();
            $http({
                method: 'post',
                data: $.param({FormDataJson: FormDataJson,FormDataJsonValue: FormDataJsonValue,OrgID :OrgID,UserTypeID: UserTypeID}),
                url: serviceBase+'saveOrgForm',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                $window.location.href = 'organisation/form-builder';
                $scope.loading = false;
            });
        }
    };

    // delete Document statas request
    $scope.deleteDocument = function(FormDataID){
        serviceBase = 'api/v1/api.php?request=';
        if(confirm("Are you sure to want to delete this document")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({FormDataID: FormDataID}),
                url: serviceBase+'deleteOrgDocument',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                $window.location.href = 'organisation/form-builder';
                $scope.loading = false;
            });
        }
    };

    // call Form request
    $scope.callOrgForm = function (id,type) {
        $scope.loading = true;
        $window.location.href = 'organisation/form-builder/edit/'+id+'/'+type;
        $scope.loading = false;
    }; 
    $scope.callAllForms = function () {
        $window.location.href = 'organisation/form-builder';
    };

    // cancel Form request
    $scope.cancelForm = function () {
        $scope.loading = true;
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
    $scope.saveForm = function(OrgID){
        serviceBase = 'api/v1/api.php?request=';
        $scope.loading = true;
        var FormDataJson = angular.element('#isShowScope').text();
        var FormDataJsonValue = angular.element('#isShowValueScope').text();
        var UserTypeID = angular.element('#UTID').text();
        //alert(StatusID);
        $http({
            method: 'post',
            data: $.param({FormDataJson: FormDataJson,FormDataJsonValue: FormDataJsonValue,UserTypeID: UserTypeID,OrgID :OrgID}),
            url: serviceBase+'saveOrgForm',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            $window.location.reload();
            $scope.loading = false;
        });
    };

    // update form request
    $scope.updateForm = function(OrgID,FormDataID,FormType){
        serviceBase = 'api/v1/api.php?request=';
        $scope.loading = true;
        var FormDataJson = angular.element('#isShowScope').text();
        var UserTypeID = angular.element('#UTID').text();
        //alert(StatusID);
        $http({
            method: 'post',
            data: $.param({FormDataJson: FormDataJson,FormDataID: FormDataID,UserTypeID: UserTypeID,OrgID :OrgID,FormType: FormType}),
            url: serviceBase+'updateOrgForm',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            $window.location.href = 'organisation/form-builder';
            $scope.loading = false;
        });
    };

    /***************************** ROSTER SYSTEM ****************************/
    // get format date request
    $scope.getCurrentDayWithFormat = function(dateObj){
        var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
          "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
        ];
        var dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        var todayMonth = monthNames[dateObj.getMonth()];
        var todayDate = dateObj.getDate();
        var todayYear = dateObj.getUTCFullYear();
        var todayDay = dayNames[dateObj.getDay()];
        return todayDay+', '+todayDate+' '+todayMonth+' '+todayYear;
    };

    // get current date with format
    $scope.getCurrentDate = function (date,OrgID) {
        var format = $scope.getCurrentDayWithFormat(date);
        $('h3.page-header').text(format);
        var timestamp = Math.floor(date / 1000);
        $('#timestamp').val(timestamp);
        var request = '[{"serviceRequestID":"21","date":"'+timestamp+'","OrgID":"'+OrgID+'"}]';
        $scope.loading = true;
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            $rootScope.clientVisits = results.response_data;
        });
        var request1 = '[{"serviceRequestID":"22","date":"'+timestamp+'","OrgID":"'+OrgID+'"}]';
        $http({
            method: 'post',
            data: $.param({request: request1}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            $rootScope.careWorkerVisits = results.response_data;
            $scope.loading = false;
        });
    };

    // laod all visit by Single date
    $scope.loadVisitsBySingleDate = function (date,OrgID) {
        var currentTimestamp = $('#timestamp').val();
        var timestamp = Math.floor(date / 1000);
        //alert(currentTimestamp+'-'+timestamp);
        if(currentTimestamp != timestamp) {
            var format = $scope.getCurrentDayWithFormat(date);
            $('h3.page-header').text(format);
            $('#timestamp').val(timestamp);
            var request = '[{"serviceRequestID":"21","date":"'+timestamp+'","OrgID":"'+OrgID+'"}]';
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({request: request}),
                url: serviceBase,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                $rootScope.clientVisits = results.response_data;
            });
            var request1 = '[{"serviceRequestID":"22","date":"'+timestamp+'","OrgID":"'+OrgID+'"}]';
            $http({
                method: 'post',
                data: $.param({request: request1}),
                url: serviceBase,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                $rootScope.careWorkerVisits = results.response_data;
                $scope.loading = false;
            });
        }
    };


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
  ]).controller('orgFormBuilderController', [
    '$scope', '$builder', '$http', '$location', '$validator', function($scope, $builder, $http, $location, $validator) {
        var serviceBase = 'api/v1/api.php?request=';
        var query = $location.path();
        var data = query.split("/");
        var FormDataID = data[4];
        var FormType = data[5];
        //alert(FormID);
        $http({
            method: 'post',
            data: $.param({FormDataID: FormDataID,FormType: FormType}),
            url: serviceBase+'getOrgForm',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            if(results.status === 'success') {
                var json = results.response_data; 
                var UserTypeID = results.UserTypeID; 
                $( "#UTID" ).text(UserTypeID);
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






app.$inject = ['$scope', 'DOBService'];

app.factory('DOBService', function() {
    var minimumAge = 0;var maximumAge = 35;
    var dob = { dayDefault: {name: "Day", value: "0"},
                monthDefault: {name: "Month", value: "0"},
                yearDefault: {name: "Year", value: "0"}
    };
    var factory = {
        getDays: function(){
          days = [{name: "Day", value: "0"}];
          for(i=1;i<=31;i++){
              if(i<=9){
                var val = '0' + i;
              } else {
                var val = i;
              }
              days.push({name: i, value:i});
          }
          return days;
    },
    getMonths: function(data){
      var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      months = [{name: "Month", value: "0"}];
      for(i=1;i<=12;i++){
            if(i<=9){
              var val = '0' + i;
            } else {
              var val = i;
            }
            months.push({name: monthNames[i - 1], value:val});
          }
          if(data){
            var n = data.length;
            for(j=n-1;j>=0;j--){
              months.splice(parseInt(data[j]), 1);
            }
          }
          return months;
    },
    getYears: function(data){
          years = [{name: "Year", value: "0"}];
          var date = new Date();
          var year = date.getFullYear();
          var start = year - minimumAge;
          var count = start - maximumAge;
          for(i=start;i>=count;i--){
            years.push({name: i, value:i});
          }
          if(data){
            var n = data.length;
            for(j=n-1;j>=0;j--){
              years.splice(parseInt(data[j]), 1);
            }
          }
          return years;
    },
        changeDay: function(value, done) {
        data = [];
        if(value >=1 && value <=29){
          data = [];
        }else if(value == 30){
          data = ['02'];
        }else if(value == 31){
          data = ['02', '04', '06', '09', '11'];
        }
            done(null, data);
        },
    changeMonth: function(obj, done) {
            data = [];
            if(obj.day ==29 && obj.month == '02'){
              var years = factory.getYears();
          var index = 0;
          for(var item in years){
                var leap = !((years[item].value % 4) || (!(years[item].value % 100) && (years[item].value % 400)));
                if(leap===false){
          data.push(index); 
            }
        index++;
              }
            }
            done(null, data);
        }
    }
    return factory;
});