app.controller('orgCtrl', function ($scope, $timeout, $rootScope, $window, $route, $routeParams, $location, $http, Data, DOBService) {
    //initially set those objects to null to avoid undefined error
    $scope.login = {};
    $scope.signup = {};

    $scope.mindate = new Date();

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
  	$scope.signup = {id:requestID};
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
            Data.toast(results.responseMessage);
            if (results.status == "1") {  
      				$scope.signup = {};
      				$location.path(pathlink);
            }
        })
        .error(function(results){

        });
    };
	
	
	
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
	
	
	

    // Load All Orgniser Forms 
    $scope.loadAllOrgniserForms = function (OrgID) {
        var request = '[{"id":"10","OrgID":"'+OrgID+'"}]';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            $scope.allForms = results.responseData;
        });
    };

    // Load All Country
    $scope.loadAllCountry = function () {
        var request = '[{"id":"3"}]';
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

    // laod all visit
    $scope.loadVisitCalander = function () {
        
    };

    // laod all visit by date
    $scope.loadVisitCalanderByDate = function (date) {
        alert(date);
    };

    $scope.loadCurrntOrgPageTitle = function (orgPageTitle) {
        $rootScope.orgPageTitle = orgPageTitle;
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