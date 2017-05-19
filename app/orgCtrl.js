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
    $scope.loadAllOrgniserForms = function (OrgID) {
        var serviceBase = 'api/v1/api.php?request=';
        var request = '[{"serviceRequestID":"10","OrgID":"'+OrgID+'"}]';
        $http({
            method: 'post',
            data: $.param({OrgID: OrgID}),
            url: serviceBase+'loadAllFormsByOrgID',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            $scope.assessorFroms = results.assessor;
            $scope.careworkerFroms = results.careworker;
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

    // create Document request
    $scope.createDocument = function (reqparams) {
        $('#fb-builder').css('display','block');
        $('#fb-builder').css('border-top','1px dashed');
        $('#fb-builder').css('border-bottom','1px dashed');
        $('.formBuilderActionBtn').css('display','block');
    };

    // edit Document request
    $scope.editDocument = function (reqparams) {
        $('.formBuilderActionBtn').css('display','block');
    };

    var query = $location.path();
    var data = query.split("/");
    $scope.FormDataID = data[3];

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
    $scope.callOrgForm = function (id) {
        $scope.loading = true;
        $window.location.href = 'organisation/form-builder/edit/'+id;
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
        //alert(StatusID);
        $http({
            method: 'post',
            data: $.param({FormDataJson: FormDataJson,FormDataJsonValue: FormDataJsonValue}),
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