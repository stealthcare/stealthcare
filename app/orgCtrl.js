app.controller('orgCtrl', function ($scope, $timeout, $rootScope, $window, $route, $routeParams, $location, $http, Data, DOBService) {
    //initially set those objects to null to avoid undefined error
    $scope.login = {};
    $scope.signup = {};

    $scope.mindate = new Date();

    $scope.loadCurrntOrgPageTitle = function (orgPageTitle) {
        $rootScope.orgPageTitle = orgPageTitle;
    };

    // for roster system page
    $scope.actionTimestamp = Math.floor(new Date() / 1000);
	
    $scope.BaseUrl = 'uploads/'; 
    $scope.pageSize='10';
    $scope.filter = "Name";
    $scope.search = {Name:'', Surname:'', DateOfBirth:'', full_address:''};
    $scope.changeFilterTo = function(pr) {
        $scope.filter = pr; 
    }
    $scope.employee='0';
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
	
   $scope.loadCurrntSidebarPageTitle = function (ActiveClassSidebar) {
        $scope.loading = true;
        $rootScope.activeClassSidebar = ActiveClassSidebar;
        $scope.loading = false;
    };
	

	
    
    // create enquiry
    var requestID = angular.element('#requestID').val();
    var statusid = angular.element('#statusid').val();
    if(statusid!=''){
      $scope.signup = {serviceRequestID:requestID,statusid:statusid};
    }else{
      $scope.signup = {serviceRequestID:requestID};     
    }
	$scope.dtmax = new Date();
    $scope.signup.title = 'Mr';
    $scope.signup.role = '3';
    $scope.signup.gender = 'Male';
    $scope.signup.support = 'Personal Care';
    $scope.signup.makeenq = 'self';
    $scope.sendRequest = function (request,pathlink) {
		$(".submit_btn").prop("disabled",true);
		$scope.loading = true;
        request = angular.toJson(request);
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
			$scope.loading = false;			  
			$(".submit_btn").prop("disabled",false);				  
            Data.toast(results);
            if (results.status == "1") { 
			    if(pathlink!=''){
				  $location.path(pathlink);
				}else{
				   $route.reload();	
				}  
            }
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
        });
    };  
    
    //alphabetic filteration staff    
    $scope.sendReqAlpha = function (name) {
		//$('#alpha'+name+' a').toggleClass('active');
		$scope.loading = true;
        var ArchiveUser=$('#employee :selected').val();
        var request = '{"serviceRequestID":"18","name":"'+name+'","ArchiveUser":"'+ArchiveUser+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
			$scope.loading = false;			  
            Data.toast(results);
            $scope.allStaff = results.responseData;
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });
    };
    
    //search staff by parameters    
    $scope.searchUniversalParam = function (param) {
		$scope.loading = true;
		var searchTxt = angular.element('#searchTxt2').val();
		var ArchiveUser=$('#employee :selected').val();
        var request = '{"serviceRequestID":"19","param":"'+param+'","searchTxt":"'+searchTxt+'","ArchiveUser":"'+ArchiveUser+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
			$scope.loading = false;			  
            //Data.toast(results);
            $scope.allStaff = results.responseData;
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });
    };
    
	
	//search append
	$scope.append_data=function (param) {
	  angular.element('#append_response').html('<input  placeholder="Search" type="text"  id="searchTxt" ng-model="searchKeywordStaff.'+param+'">');
	};
	
	$scope.append_datepicker=function (param){
	   if(param=='1'){
		 $('#searchTxt').hide();
		 $('#searchTxt2').show();
	   }else{
		 $('#searchTxt').show();
		 $('#searchTxt2').hide();	   
	   }	
		//$scope.opened = true;
	};
	

	
    
    //search staff by txt   
    $scope.searchStaff = function (param) {
		$scope.loading = true;
        var searchTxt=angular.element('#searchTxt').val();
        var request = '{"serviceRequestID":"20","param":"'+param+'","searchTxt":"'+searchTxt+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
			$scope.loading = false;			  
            Data.toast(results);
            $scope.allStaff = results.responseData;
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });   
    };
    
    //load staff    
    $scope.loadAllStaff = function () {
		$scope.loading = true;
        var ArchiveUser=$('#employee :selected').val();
        var request = '{"serviceRequestID":"17","ArchiveUser":"'+ArchiveUser+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            //Data.toast(results);
			$scope.loading = false;
            $scope.allStaff = results.responseData;
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });
    };
	
	//edit staff
	$scope.editStaffload = function () {
		$scope.loading = true;
        var StaffID = $routeParams.id;
        var request = '{"serviceRequestID":"23","StaffID":"'+StaffID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            //Data.toast(results);			
            //$rootScope.allStaff = results.responseData;
			$scope.loading = false;
			$scope.signup = results.responseData2;
        });
    };
	
	
	//update staff 
	$scope.updateStaff = function (request,pathlink) {
		$(".submit_btn").prop("disabled",true);
		$scope.loading = true;
		request = angular.toJson(request);
        //var request = '{"serviceRequestID":"24"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){	
			$scope.loading = false;			  
            Data.toast(results);
			$(".submit_btn").prop("disabled",false);
			//$location.path(pathlink);
			setTimeout(function(){ $location.path(pathlink) }, 1000);
        });
    };
	
	//load Equipments    
    $scope.loadAllEquipments = function () {
        var request = '{"serviceRequestID":"26"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            Data.toast(results);
            $scope.allEquipments = results.responseData;			
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });
    };
	
	//create Equipments
	$scope.createEquipment = function (reqparams,pathlink) {
		$(".button2").prop("disabled",true);
		 request = angular.toJson(reqparams);
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
			$(".button2").prop("disabled",false);
            if (results.status == "1") {
                $location.path(pathlink);
            }
        })
        .error(function(results){

        });
    };
	
	
	
	//edit Equipments load
	$scope.editEquipmentsload = function () {
		
        var EquipmentID = $routeParams.id;
        var request = '{"serviceRequestID":"28","EquipmentID":"'+EquipmentID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
            $rootScope.allEquipments = results.responseData;
        });
    };
	
	
	//update Equipments 
	$scope.updateEquipments = function (request,pathlink) {
		$(".button2").prop("disabled",true);
		request = angular.toJson(request);
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){	  
            Data.toast(results);
			$(".button2").prop("disabled",false);		
			$location.path(pathlink);
        });
    };
	
	
	// change Equipments statas request
    $scope.changeStatusEquipment = function(EquipmentID,StatusID){
		var request = '{"serviceRequestID":"30","EquipmentID":"'+EquipmentID+'","StatusID":"'+StatusID+'"}';
        if(confirm("Are you sure to want to change Equipment status")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({request: request}),
                url: serviceBase,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    }; 
	
	

	
	//load all staff org
	$scope.loadAllStaffOrg = function () {
        var request = '{"serviceRequestID":"32"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            //Data.toast(results);
            $scope.allAllStaffOrg = results.responseData;			
        });
    };
	
	//load all Equipments org    
    $scope.loadAllEquipmentsOrg = function () {
        var request = '{"serviceRequestID":"33"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            //Data.toast(results);
            $scope.allAllEquipmentsOrg = results.responseData;	
        });
    };
	
	// load qualification by staff id
	$scope.loadQualificationStaff = function () {
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
        var request = '{"serviceRequestID":"39","StaffID":"'+StaffID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            //Data.toast(results);
			$scope.loading = false;
			$(".button2").prop("disabled",false);
            $scope.QualificationStaff  = results.responseData;
        });
    };
	

	
	
	// update qualification by staff id
	$scope.assignQualifications= function (post) {	
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
		var values = new Array();
		$.each($("input[name='QualificationID[]']:checked"), function() {
		  values.push($(this).val());
		
		});	
		if(values==''){
			$scope.showValidation = true;
			$scope.loading = false;
		    $(".button2").prop("disabled",false);
		}else{
			$scope.showValidation = false;
			$scope.loading = true;
		    $(".button2").prop("disabled",true);
		var request = '{"serviceRequestID":"40","StaffID":"'+StaffID+'","QualificationID":"'+values+'"}';
		$http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
			$scope.loading = false;
			$(".button2").prop("disabled",false);
        }); 
	   }	
    };
	
	
   // load Equipments by staff id
   $scope.loadEquipmentsStaff = function () {
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
        var request = '{"serviceRequestID":"41","StaffID":"'+StaffID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            //Data.toast(results);
			$scope.loading = false;
			$(".button2").prop("disabled",false);
            $scope.EquipmentsStaff  = results.responseData;
        });
    };
	
	
	// update Equipments by staff id
	$scope.assignEquipmentsStaff= function (post) {	
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
		var values = new Array();
		$.each($("input[name='EquipmentID[]']:checked"), function() {
		  values.push($(this).val());
		
		});
		
		if(values==''){
			$scope.showValidation = true;
			$scope.loading = false;
		    $(".button2").prop("disabled",false);
		}else{
			$scope.showValidation = false;
			$scope.loading = true;
		    $(".button2").prop("disabled",true);
			var request = '{"serviceRequestID":"42","StaffID":"'+StaffID+'","EquipmentID":"'+values+'"}';
			$http({
				method: 'post',
				data: $.param({request: request}),
				url: serviceBase,
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
			})
			.success(function(results){
				Data.toast(results);
				$scope.loading = false;
				$(".button2").prop("disabled",false);
			}); 
		}
    };
		
	
   // load loadChecks by staff id
   $scope.loadChecksStaff = function () {
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
        var request = '{"serviceRequestID":"43","StaffID":"'+StaffID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            //Data.toast(results);
			$scope.loading = false;
			$(".button2").prop("disabled",false);
            $scope.EquipmentsStaff  = results.responseData;
        });
    };
	
	
	// update Checks by staff id
	$scope.assignChecksStaff= function (post) {	
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
		var values = new Array();
		$.each($("input[name='ChecksID[]']:checked"), function() {
		  values.push($(this).val());
		
		});
		
		if(values==''){
			$scope.showValidation = true;
			$scope.loading = false;
		    $(".button2").prop("disabled",false);
		}else{
			$scope.showValidation = false;
			$scope.loading = true;
		    $(".button2").prop("disabled",true);
			var request = '{"serviceRequestID":"44","StaffID":"'+StaffID+'","ChecksID":"'+values+'"}';
			$http({
				method: 'post',
				data: $.param({request: request}),
				url: serviceBase,
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
			})
			.success(function(results){
				Data.toast(results);
				$scope.loading = false;
				$(".button2").prop("disabled",false);
			}); 
		}
    };
	
	
	//edit setting load
	$scope.editSettingload = function () {
		$scope.loading = true;
        var request = '{"serviceRequestID":"45"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            //Data.toast(results);			
            //$rootScope.allStaff = results.responseData;
			$scope.loading = false;
			$scope.resultData = results.responseData2;
        });
    };
	

	//load Equipments    
    $scope.loadAllChecksSetting = function () {
        var request = '{"serviceRequestID":"46"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            Data.toast(results);
            $scope.allChecksSetting = results.responseData;			
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });
    };
	
	
	// change Checks status request
    $scope.changeStatusChecks = function(ChecksID,StatusID){
		var request = '{"serviceRequestID":"47","ChecksID":"'+ChecksID+'","StatusID":"'+StatusID+'"}';
        if(confirm("Are you sure to want to change Checks status")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({request: request}),
                url: serviceBase,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    }; 
	
	
	//Common create Function
	$scope.commonCreate = function (reqparams,pathlink) {
		$(".button2").prop("disabled",true);
		$scope.loading = true;
		 request = angular.toJson(reqparams);
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            Data.toast(results);
			$(".button2").prop("disabled",false);
			$scope.loading = false;
            if (results.status == "1") {
                $location.path(pathlink);
            }
        })
        .error(function(results){

        });
    };
	
	
	//edit Checks Load Setting
	$scope.editChecksload = function () {
		$scope.loading = true;
        var ChecksID = $routeParams.id;
        var request = '{"serviceRequestID":"49","ChecksID":"'+ChecksID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
			$scope.loading = false;			  
            Data.toast(results);
            $scope.signup = results.responseData2;
        });
    };
	
	
	//load Group Setting    
    $scope.loadAllGroupSetting = function () {
        var request = '{"serviceRequestID":"51"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            Data.toast(results);
            $scope.allGroupSetting = results.responseData;			
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });
    };
	
	//edit Group Load Setting
	$scope.editGroupload = function () {
		$scope.loading = true;
        var GroupID = $routeParams.id;
        var request = '{"serviceRequestID":"53","GroupID":"'+GroupID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
			$scope.loading = false;			  
            Data.toast(results);
            $scope.signup = results.responseData2;
        });
    };
    
	// change Group status request
    $scope.changeStatusGroup = function(GroupID,StatusID){
		var request = '{"serviceRequestID":"55","GroupID":"'+GroupID+'","StatusID":"'+StatusID+'"}';
        if(confirm("Are you sure to want to change Group status")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({request: request}),
                url: serviceBase,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    }; 
	
	
   // load Groups by staff id
   $scope.loadGroupsStaff = function () {
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
        var request = '{"serviceRequestID":"56","StaffID":"'+StaffID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            //Data.toast(results);
			$scope.loading = false;
			$(".button2").prop("disabled",false);
            $scope.GroupsStaff  = results.responseData;
        });
    };
	
	// update Checks by staff id
	$scope.assignGroupStaff= function (post) {	
		$scope.loading = true;
		$(".button2").prop("disabled",true);
		var StaffID = $routeParams.id;
		var values = new Array();
		$.each($("input[name='GroupID[]']:checked"), function() {
		  values.push($(this).val());
		
		});
		
		if(values==''){
			$scope.showValidation = true;
			$scope.loading = false;
		    $(".button2").prop("disabled",false);
		}else{
			$scope.showValidation = false;
			$scope.loading = true;
		    $(".button2").prop("disabled",true);
			var request = '{"serviceRequestID":"57","StaffID":"'+StaffID+'","GroupID":"'+values+'"}';
			$http({
				method: 'post',
				data: $.param({request: request}),
				url: serviceBase,
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
			})
			.success(function(results){
				Data.toast(results);
				$scope.loading = false;
				$(".button2").prop("disabled",false);
			}); 
		}
    };
	
	//load Qualification setting    
    $scope.loadAllQualificationSetting = function () {
        var request = '{"serviceRequestID":"58"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            Data.toast(results);
            $scope.allQualificationSetting = results.responseData;			
            if(results.status==0){
              $scope.responsemsg = results.message;
              $scope.showAlert = true;
              $scope.showPaging = false;
            }else{
              $scope.showAlert = false;
              $scope.showPaging = true;
            }
        });
    };
	
	// change Qualification status request
    $scope.changeStatusQualification = function(QualificationID,StatusID){
		var request = '{"serviceRequestID":"60","QualificationID":"'+QualificationID+'","StatusID":"'+StatusID+'"}';
        if(confirm("Are you sure to want to change Qualification status")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({request: request}),
                url: serviceBase,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            })
            .success(function(results){
                Data.toast(results);
                if (results.status == "1") {
                    $route.reload(); 
                }
                $scope.loading = false;
            })
            .error(function(results){

            });
        }
    }; 
	
	
	//edit Qualification Load Setting
	$scope.editQualificationload = function () {
		$scope.loading = true;
        var QualificationID = $routeParams.id;
        var request = '{"serviceRequestID":"61","QualificationID":"'+QualificationID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
			$scope.loading = false;			  
            Data.toast(results);
            $scope.signup = results.responseData2;
        });
    };
	
	

    $scope.toggleShow = function(){
        if($scope.showStartEvent==true){
          $scope.signup.statusid='1';
        }else{
          $scope.signup.statusid='2';  
        }
       $scope.showStartEvent = !$scope.showStartEvent;
    }
	$scope.IsVisible = false;
	$scope.changeStatus = function(id){	
		if(id==1){
		  $scope.deactivebtn=$scope.deactivebtn;	
		  $scope.activebtn=!$scope.activebtn;		
		}else if(id==2){
		  $scope.deactivebtn=$scope.deactivebtn;	
		  $scope.activebtn=!$scope.activebtn;				
		}
	}
	
	 $scope.ShowHide = function () {
        $scope.IsVisible = $scope.IsVisible ? false : true;
     }
	
	

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
        var request = '{"serviceRequestID":"3"}';
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
	
	// Load All Qualification
    $scope.loadAllQualification = function () {
        var request = '{"serviceRequestID":"25"}';
        $http({
            method: 'post',
            data: $.param({request: request}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){ 
            $scope.allQualification = results.responseData;
			$scope.setSelected=results.selectedQual;
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
    $scope.removePopover = function () {
        jQuery('.popover.fade.left.in').remove();
    };
    // create Document request
    $scope.createDocument = function (index) {
        if(index === 'new') {
            $window.location.href = 'organisation/form-builder';
        }
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
        $('.fb-components-section').css('display','block');
        //$('#fb-builder .fb-form-object-editable').addClass('dragging');
        $('#fb-builder').addClass('showfaicon');
        $( "#UTID" ).text(UserTypeID);
    };

    $scope.cancel = function () {
        $( "#showModal" ).hide();
    }

    // edit Document request
    $scope.editDocument = function (reqparams) {
        $('.formBuilderActionBtn').css('display','block');
        $('#fb-builder .edit-component-field, #fb-builder .delete-component-field, .fb-components-section').css('display','block');
        //$('#fb-builder .fb-form-object-editable').addClass('dragging');
        $('#fb-builder').addClass('showfaicon');
        $('.opration > a:nth-child(3)').addClass('disabled');
    };

    var query = $location.path();
    var data = query.split("/");
    $scope.FormDataID = data[4];
    $scope.FormType = data[5];
    $scope.UserTypeID = data[6];

    if(data[6] === '4') {
        $scope.tab = 1;
    } else if(data[6] === '5') {
        $scope.tab = 2;
    } else {
        $scope.tab = 1;
    }
    $scope.setTab = function(newTab){
      $scope.tab = newTab;
    };

    $scope.isSet = function(tabNum){
      return $scope.tab === tabNum;
    };

    // Duplicate Document statas request
    $scope.duplicateDocument = function(FormDataID,FormType,OrgID){
        serviceBase = 'api/v1/api.php?request=';
        if(confirm("Are you sure to want to create duplicate document?")){
            $scope.loading = true;
            $http({
                method: 'post',
                data: $.param({FormDataID: FormDataID,FormType: FormType,OrgID: OrgID}),
                url: serviceBase+'duplicateOrgForm',
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
        if(confirm("Are you sure to want to delete this document?")){
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
    $scope.callOrgForm = function (id,type,UserTypeID) {
        $scope.loading = true;
        $window.location.href = 'organisation/form-builder/edit/'+id+'/'+type+'/'+UserTypeID;
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
            if(results.status_code === '0') {
                Data.toast(results);
            } else {
                $window.location.reload();
            }
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
            if(results.status_code === '0') {
                Data.toast(results);
            } else {
                $window.location.href = 'organisation/form-builder';
            }
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
    $scope.getCurrentDate = function (date) {
        var format = $scope.getCurrentDayWithFormat(date);
        $('h3.page-header').text(format);
        var timestamp = Math.floor(date / 1000);
        $('#timestamp').val(timestamp);
        /*var OrgID = 9;
        var request = '{"serviceRequestID":"21","date":"'+timestamp+'","OrgID":"'+OrgID+'"}';
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
        var request1 = '{"serviceRequestID":"22","date":"'+timestamp+'","OrgID":"'+OrgID+'"}';
        $http({
            method: 'post',
            data: $.param({request: request1}),
            url: serviceBase,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        })
        .success(function(results){
            $rootScope.careWorkerVisits = results.response_data;
            $scope.loading = false;
        });*/
    };

    // laod all visit by Single date
    /*$scope.loadVisitsBySingleDate = function (date) {
        var currentTimestamp = $('#timestamp').val();
        var timestamp = Math.floor(date / 1000);
        //alert(currentTimestamp+'-'+timestamp);
        var OrgID = 9;
        if(currentTimestamp != timestamp) {
            var format = $scope.getCurrentDayWithFormat(date);
            $('h3.page-header').text(format);
            $('#timestamp').val(timestamp);
            var request = '{"serviceRequestID":"21","date":"'+timestamp+'","OrgID":"'+OrgID+'"}';
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
            var request1 = '{"serviceRequestID":"22","date":"'+timestamp+'","OrgID":"'+OrgID+'"}';
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
    };*/


});


app.run([
    '$builder', function($builder) {
      return $builder.registerComponent('postCode', {
        group: 'Default',
        label: 'Postal Code',
        required: false,
        arrayToText: true,
        template: "<div class=\"form-group\">\n    <label for=\"{{formName+index}}\" class=\"col-md-12 control-label\" ng-class=\"{'fb-required':required}\"><span>{{label}}</span> <i class=\"fa fa-pencil edit-component-field\" title=\"Edit Field\"></i> <i ng-click=\"popover.remove($event)\" class=\"fa fa-trash-o delete-component-field\" title=\"Delete Field\"></i></label>\n    <div class=\"col-md-8\">\n        <input type='hidden' ng-model=\"inputText\" validator-required=\"{{required}}\" validator-group=\"{{formName}}\"/>\n        <div class=\"col-sm-6\" style=\"padding-left: 0;\">\n            <input type=\"text\"\n                ng-model=\"inputArray[0]\"\n                class=\"form-control\" id=\"{{formName+index}}-0\"/>\n             </div>\n        <div class=\"col-sm-6\" style=\"padding-left: 0;\">\n            <input type=\"text\"\n                ng-model=\"inputArray[1]\"\n                class=\"form-control\" id=\"{{formName+index}}-1\"/>\n             </div>\n    </div>\n</div>",
        popoverTemplate: "<form>\n    <div class=\"form-group\">\n        <label class='control-label'>Field Label</label>\n        <input type='text' maxlength=\"100\" ng-model=\"label\" validator=\"[required]\" class='form-control'/>\n    </div>\n    <div class=\"checkbox\">\n        <label>\n    Required?        <input type='checkbox' ng-model=\"required\" />\n   </label>\n    </div>\n\n  <div class='form-group'>\n        <input type='submit' ng-click=\"popover.save($event)\" class='btn button2' value='Save'/>\n        <input type='button' ng-click=\"popover.cancel($event)\" class='btn button2' value='Cancel'/>\n    </div>\n</form>"
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



//text trim
app.filter('cut', function () {
        return function (value, wordwise, max, tail) {
            if (!value) return '';

            max = parseInt(max, 10);
            if (!max) return value;
            if (value.length <= max) return value;

            value = value.substr(0, max);
            if (wordwise) {
                var lastspace = value.lastIndexOf(' ');
                if (lastspace !== -1) {
                  //Also remove . and , so its gives a cleaner result.
                  if (value.charAt(lastspace-1) === '.' || value.charAt(lastspace-1) === ',') {
                    lastspace = lastspace - 1;
                  }
                  value = value.substr(0, lastspace);
                }
            }

            return value + (tail || ' �');
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