<?php

include 'libXML.php';
include 'lib.php';
include '../../config.php';

/* Store the id number sent by the application */
if(@$_POST['request']) {
    $post = json_decode($_POST['request']);
    ///print_r($post); die();
	if(is_array($post)){
	  $post = $post['0'];
	}
    $postArray = array();
    foreach($post as $key => $field){
        $postArray[$key] = $field;
    }
    $post = $postArray;
    $ID = @$post['serviceRequestID'];
    $deviceType = @$_SERVER['HTTP_DEVICETYPE'];
    $appVersion = @$_SERVER['HTTP_APPVERSION'];
    $OSVersion = @$_SERVER['HTTP_OSVERSION'];
    $browserVersion = @$_SERVER['HTTP_BROWSERVERSION'];
} else {
    $ID = '0';
}

$_content_type = "application/json;charset=utf-8";
header("Content-Type:".$_content_type);

$dbDBname = DB;
$dbUsername= DB_USER;
$dbPassword= DB_PASSWORD;
$hostName = DB_SERVER;
$URLName = URL;
$baseUrl = base_url;

//////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// FUNCTIONS /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

/******************************************************************************************************************/
/* 
*   ID=1
*   A function used as a response to ID=1
*   It is used to loginWithUsername
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loginWithUsername($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $username = $post['UserName'];
    $password = $post['Password'];
    if ($deviceType == '1' || $deviceType == '2') {
        $UserTypeID = 5;
    } elseif ($deviceType == '4' || $deviceType == '5') {
        $UserTypeID = 4;
    }
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');   
    $password = md5($password); 
    $result = mysql_query("call loginWithUsername('".$username."','".$password."');");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $row = mysql_fetch_assoc($result);
    //print_r($row); die();
    if($row) {
        if($row['StatusID'] != 1) {
            $data['ResponseData'] = "";
            $data['Message'] = "Your account is currently disabled";
            $data['ResponseCode'] = "200";
            $data['Status'] = "Failed";
            $data['StatusCode'] = "0";
        } else {
            if($row['UserTypeID'] == $UserTypeID) {
                $data['ResponseData'] = $row;
                $data['Message'] = "Your have successfully loggedin!!!";
                $data['ResponseCode'] = "200";
                $data['Status'] = "Success";
                $data['StatusCode'] = "1";
            } else {
                $data['ResponseData'] = "";
                $data['Message'] = "Your are not authorized to access this device";
                $data['ResponseCode'] = "200";
                $data['Status'] = "Failed";
                $data['StatusCode'] = "0";
            }
        }
    } else {
        $data['ResponseData'] = "";
        $data['Message'] = "Please check your Username and Password";
        $data['ResponseCode'] = "200";
        $data['Status'] = "Failed";
        $data['StatusCode'] = "0";
    }
    //$data['Request'] = 'deviceType:-'.$deviceType.'-appVersion:-'.$appVersion.'-OSVersion:-'.$OSVersion.'-browserVersion:-'.$browserVersion;
    print json_encode($data);
    mysql_close($con);   //close the connection
}

/******************************************************************************************************************/
/* 
*   ID=2
*   A function used as a response to ID=2
*   It is used to createEnquiry
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function createEnquiry($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $CustomerTitle = $post['title'];
    $CustomerName = $post['fname'];
    $CustomerSurname = $post['sname'];
    $CustomerMiddleName = $post['mname'];
    $DateOfBirth = $post['dob'];
    $NHSNumber = $post['nhsno'];
    $Gender = $post['gender'];
    $Ethnicity=$post['ethnicity'];
    $Address1=$post['address1'];
    $Address2=$post['address2'];
    $PostCode=strtoupper($post['postcode1'].' '.$post['postcode2']);
    $City=$post['city'];
    $Landline=$post['landline'];
    $ContactNo=$post['mobile'];
    $OtherDetails=$post['otherinfo'];
    $CareInfo=$post['desc'];
    $OutcomesInfo=$post['outcomes'];
    $SupportInfo=$post['support'];
    $MakeEnq=$post['makeenq'];
    $CreatedDateTime = date('Y-m-d H:i:s');
    $ModifyDateTime = date('Y-m-d H:i:s');
    $AccessLevelID='5';
    //$RightsID='9';
	$RightsID='8';
   // $UserTypeID='6';
    $UserTypeID='6';
    $StatusID='1';
    session_start();
    $OrgID=$_SESSION['OrgID'];

    $con=connectToDB(); //connect to the DB

    $result = mysql_query("call createEnquiry('".$OrgID."','".$CustomerTitle."','".$CustomerName."','".$CustomerSurname."','".$CustomerMiddleName."','".$DateOfBirth."','".$NHSNumber."','".$Gender."','".$Ethnicity."','".$Address1."','".$Address2."','".$PostCode."','".$City."','".$Landline."','".$ContactNo."','".$OtherDetails."','".$CareInfo."','".$OutcomesInfo."','".$SupportInfo."','".$MakeEnq."','".$RightsID."','".$AccessLevelID."','".$UserTypeID."','".$CreatedDateTime."','".$ModifyDateTime."','".$StatusID."')")or die(mysql_error());
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Created successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Creation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

/******************************************************************************************************************/
/* 
*   ID=3
*   A function used as a response to ID=3
*   It is used to loadAllCountry
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllCountry($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call loadAllCountry();");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['responseMessage'] = "All country get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['responseMessage'] = "Request error";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

/******************************************************************************************************************/
/* 
*   ID=10
*   A function used as a response to ID=10
*   It is used to loadAllOrgniserForms
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllOrgniserForms($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $UserID = $post['UserID'];
    //$OrgID = $post['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $sql = "SELECT S.OrgID, UA.UserTypeID FROM 
            SCP_Staff AS S 
            INNER JOIN SCP_UserAccess AS UA ON UA.UserID='$UserID'
            WHERE S.UserID='$UserID'";

    $resultset = mysql_query($sql);
    $accessRow = mysql_fetch_assoc($resultset);  
    //print_r($accessRow); 

    $OrgID = $accessRow['OrgID'];
    $UserTypeID = $accessRow['UserTypeID'];
    $result = mysql_query("call loadAllOrgniserForms('".$OrgID."','".$UserTypeID."');");
    //CHECK FOR ERROR       
    if (!$result) die('Invalid query: ' . mysql_error());
    $orgForms = array();
    while($row = mysql_fetch_assoc($result)) {
        $orgForms[] = $row;
    }
    mysql_close($con);   //close the connection
    $allForms = loadAllForms($UserTypeID);
    //print_r($allForms); 
    $filterAllForms = array();
    foreach ($allForms as $key => $value) {
        if(!in_array_r($value['FormDataID'], $orgForms)) {
            $array['FormID'] = $value['FormID'];
            $array['FormDataID'] = $value['FormDataID'];
            $array['FormName'] = $value['FormName'];
            $array['FormDataJson'] = $value['FormDataJson'];
            $array['FormDataJsonValue'] = $value['FormDataJsonValue'];
            $array['UserID'] = $value['UserID'];
            $array['StatusID'] = $value['StatusID'];
            $array['FromType'] = 2;
            $array['UserTypeID'] = $value['UserTypeID'];
            $array['CreatedDateTime'] = $value['CreatedDateTime'];
            $array['ModifyDateTime'] = $value['ModifyDateTime'];
            $filterAllForms[] = $array;
        }
    }
    //print_r($orgForms); die();
    $rows = array_merge($orgForms,$filterAllForms);
    if($rows) {
        $data['ResponseData'] = $rows;
        $data['Message'] = "Get all forms successfully.";
        $data['ResponseCode'] = "200";
        $data['Status'] = "Success";
        $data['StatusCode'] = "1";
    } else {
        $data['ResponseData'] = "";
        $data['Message'] = "Request error";
        $data['ResponseCode'] = "200";
        $data['Status'] = "Failed";
        $data['StatusCode'] = "0";
    }
    print json_encode($data);
}

function loadAllForms($UserTypeID)
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call loadAllForms('".$UserTypeID."');");
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    return $rows;
    mysql_close($con);   //close the connection
}

/******************************************************************************************************************/
/* 
*   ID=11
*   A function used as a response to ID=11
*   It is used to loadAllOrgniserForms
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function getFormWithdataByFormDataIDAndUserID($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $UserID = $post['UserID'];
    $FormDataID = $post['FormDataID'];
    //$OrgID = $post['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    /******************** userData start *******************/
    $sql = "SELECT S.OrgID, UA.UserTypeID FROM 
            SCP_Staff AS S 
            INNER JOIN SCP_UserAccess AS UA ON UA.UserID='$UserID'
            WHERE S.UserID='$UserID'";
    $resultset = mysql_query($sql);
    $accessRow = mysql_fetch_assoc($resultset); 
    $OrgID = $accessRow['OrgID'];
    $UserTypeID = $accessRow['UserTypeID'];
    /******************** userData end *******************/ 
    /******************** userformData start *******************/
    $sql1 = "SELECT * FROM SCP_OrgFormBuilderDataAction WHERE UserID='$UserID' AND OrgID='$OrgID' AND FormDataID='$FormDataID'";
    $resultset1 = mysql_query($sql1);
    $rowData = mysql_fetch_assoc($resultset1); 
    /******************** userformData end *******************/ 
    print_r(unserialize($rowData['FormValueData']));
    //print_r($rowData); die();
    $result = mysql_query("call getFormWithdataByFormDataIDAndUserID('".$OrgID."','".$UserTypeID."','".$FormDataID."');");
    //CHECK FOR ERROR       
    if (!$result) die('Invalid query: ' . mysql_error());
    $row = mysql_fetch_assoc($result);
    mysql_close($con);   //close the connection
    print_r(json_decode($row['FormDataJson'])); die();
    $allForms = loadAllForms($UserTypeID);
    $filterAllForms = array();
    foreach ($allForms as $key => $value) {
        if(!in_array_r($value['FormDataID'], $orgForms)) {
            $array['FormID'] = $value['FormID'];
            $array['FormDataID'] = $value['FormDataID'];
            $array['FormName'] = $value['FormName'];
            $array['FormDataJson'] = $value['FormDataJson'];
            $array['FormDataJsonValue'] = $value['FormDataJsonValue'];
            $array['UserID'] = $value['UserID'];
            $array['StatusID'] = $value['StatusID'];
            $array['FromType'] = 2;
            $array['UserTypeID'] = $value['UserTypeID'];
            $array['CreatedDateTime'] = $value['CreatedDateTime'];
            $array['ModifyDateTime'] = $value['ModifyDateTime'];
            $filterAllForms[] = $array;
        }
    }
    //print_r($newArray2); die();
    $rows = array_merge($orgForms,$filterAllForms);
    if($rows) {
        $data['ResponseData'] = $row;
        $data['Message'] = "Get form data successfully.";
        $data['ResponseCode'] = "200";
        $data['Status'] = "Success";
        $data['StatusCode'] = "1";
    } else {
        $data['ResponseData'] = "";
        $data['Message'] = "Error";
        $data['ResponseCode'] = "200";
        $data['Status'] = "Failed";
        $data['StatusCode'] = "0";
    }
    print json_encode($data);
}

/******************************************************************************************************************/
/* 
*   ID=16
*   A function used as a response to ID=16
*   It is used to insertDynamicFormData
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function insertDynamicFormData($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $FormValueData = serialize(json_decode($post['data']));
    //print_r(unserialize($imagesIndex)); die;
    $explode = explode(',', $_POST['imagesIndex']);
    //print_r($explode); die();
    $UserID = $post['UserID'];
    $FormDataID = $post['FormDataID'];
    $StatusID='1';
    $success = false;
    $CreatedDateTime = date('Y-m-d H:i:s');
    $ModifyDateTime = date('Y-m-d H:i:s');
    $con=connectToDB(); //connect to the DB
    $StatusID='1';
    $result = mysql_query("call insertDynamicFormData('".$FormValueData."','".$UserID."','".$FormDataID."','".$StatusID."','".$CreatedDateTime."','".$ModifyDateTime."')")or die(mysql_error());
    $formsData = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows['FormValueData'] = unserialize($row['FormValueData']);
        $rows['UserID'] = $row['UserID'];
        $rows['FormDataID'] = $row['FormDataID'];
        $formsData[] = $rows;
        $success = true;
    }
    if(!empty($_POST['imagesIndex'])) {
        foreach ($explode as $key => $value) {
            //echo $value; die();
            $fileName = $_FILES[$value]['name'];
            $targetDir = $_SERVER['DOCUMENT_ROOT']."/stealthcare/uploads/";
            $targetFile = $targetDir . $fileName;
            if(move_uploaded_file($_FILES[$value]['tmp_name'], $targetFile)) {
                $success = true;
            } else {
                $success = false;
            }
        }
    }
    if($success) {
        $data['ResponseData'] = $formsData;
        $data['Message'] = "Form data inserted successfully.";
        $data['ResponseCode'] = "200";
        $data['Status'] = "Success";
        $data['StatusCode'] = "1";
    } else {
        $data['ResponseData'] = "";
        $data['Message'] = "Error";
        $data['ResponseCode'] = "200";
        $data['Status'] = "Failed";
        $data['StatusCode'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

function in_array_r($needle, $haystack, $strict = false) {
    foreach ($haystack as $item) {
        if (($strict ? $item === $needle : $item == $needle) || (is_array($item) && in_array_r($needle, $item, $strict))) {
            return true;
        }
    }
    return false;
}

/******************************************************************************************************************/
/* 
*   ID=15
*   A function used as a response to ID=15
*   It is used to createStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function createStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{

    $role = $post['role'];
    $Title = $post['title'];
    $FirstName = $post['FirstName'];
    $Surname = $post['Surname'];
    $MiddleName = $post['MiddleName'];
    $DateOfBirth = $post['DateOfBirth'];
    $Gender = $post['gender'];
    $Ethnicity = $post['Ethnicity'];
    $HouseNumber=$post['HouseNumber'];
    $Address1=$post['Address1'];
    $Address2=$post['Address2'];
	$City=$post['City'];
	$Country=$post['Country'];
    $PostCode=strtoupper($post['postcode1'].' '.$post['postcode2']);
    $Mobile=$post['Mobile'];
    $ProfilePhoto=!empty ($post['ProfilePhoto'])?$post['ProfilePhoto']:'';   
    $NOKName=$post['NOKName'];
    $NOKMobile=$post['NOKMobile'];
    $NOKEmail=$post['NOKEmail'];
    $UserName=$post['UserName'];
	$Password=$post['Password'];
    $CreatedDateTime = date('Y-m-d H:i:s');
    $ModifyDateTime = date('Y-m-d H:i:s');
    session_start();
    $OrgID=$_SESSION['OrgID'];
    $con=connectToDB(); //connect to the DB
	$Licenses=mysql_query("SELECT * FROM `SCP_Licenses` WHERE UserID IS NULL AND StatusID='1' ORDER BY LicenseID ASC LIMIT 1")or die(mysql_error());
	$Licenses = mysql_fetch_array($Licenses, MYSQL_ASSOC);
	$LicenseID = $Licenses['LicenseID'];
    if($role=='3'){
	  $RightsID='2';
	  $AccessLevelID='2';
	  $UserTypeID=$role;
	}elseif($role=='4'){
	  $RightsID='3';
	  $AccessLevelID='3';
	  $UserTypeID=$role;	
	}elseif($role=='5'){
	  $RightsID='4';
	  $AccessLevelID='4';
	  $UserTypeID=$role;	
	}
	$UserID = $UserTypeID.''.$post['UserName'];
	if(!empty($ProfilePhoto)){
	$ProfilePhotoData = explode('//', $ProfilePhoto);
            if ($ProfilePhotoData[0] != 'http:') {
                
				
				$photoData=$ProfilePhoto;
				$fileName='user'.$UserID;
				$imageData = explode(';', $photoData);
				$imageData = explode(':', $imageData[0]);
				if($imageData[0] == 'data') {
					if($imageData[1] == 'image/png') {
						$data = str_replace('data:image/png;base64,', '', $photoData);
						$data = str_replace(' ', '+', $data);
						$data = base64_decode($data);
						$file = $_SERVER['DOCUMENT_ROOT'].'/stealthcare/uploads/'.$fileName . '.png';
						$Photo = img.$fileName . '.png';
					} elseif($imageData[1] == 'image/jpg') {
						$data = str_replace('data:image/jpg;base64,', '', $photoData);
						$data = str_replace(' ', '+', $data);
						$data = base64_decode($data);
						$file = $_SERVER['DOCUMENT_ROOT'].'/stealthcare/uploads/'.$fileName . '.jpg';
						$Photo = img.$fileName . '.jpg';
					} elseif($imageData[1] == 'image/jpeg') {
						$data = str_replace('data:image/jpeg;base64,', '', $photoData);
						$data = str_replace(' ', '+', $data);
						$data = base64_decode($data);
						$file = $_SERVER['DOCUMENT_ROOT'].'/stealthcare/uploads/'.$fileName . '.jpeg';
						$Photo = img.$fileName . '.jpeg';
					} else {
						$successdata = array('status_code' => "1", 'status' => "error", 'message' => 'Image format is wrong', 'response_code' => "200");
						$this->response($this->json($successdata), 200); 
						die();
					}
					$success = file_put_contents($file, $data);
					$data = base64_decode($data); 
					$source_img = @imagecreatefromstring($data);
					$rotated_img = @imagerotate($source_img, 90, 0);
					$imageSave = @imagejpeg($rotated_img, $file, 10);
					@imagedestroy($source_img);
					$ProfilePhoto=$Photo;
				}
				
				
            }
	
	}
	
	
	$StatusID=!empty($post['statusid'])?$post['statusid']:'1';
	$result = mysql_query("call createStaff('".$OrgID."','".$Title."','".$FirstName."','".$Surname."','".$MiddleName."','".$DateOfBirth."','".$Gender."','".$Ethnicity."','".$HouseNumber."','".$Address1."','".$Address2."','".$City."','".$Country."','".$PostCode."','".$Mobile."','".$ProfilePhoto."','".$NOKName."','".$NOKMobile."','".$NOKEmail."','".$UserName."','".$Password."','".$RightsID."','".$AccessLevelID."','".$UserTypeID."','".$CreatedDateTime."','".$ModifyDateTime."','".$StatusID."','".$LicenseID."')")or die(mysql_error());
   
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Created successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Creation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

/******************************************************************************************************************/
/* 
*   ID=21
*   A function used as a response to ID=21
*   It is used to insertDynamicFormData
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function getRosterClientDataByDate($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $Date = date('Y-m-d', strtotime($post['date']));
    $OrgID = $post['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call getRosterClientDataByDate('".$Date."','".$OrgID."');");
    //CHECK FOR ERROR    
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    //echo '<pre>'; print_r($rows); die();
    if($rows) {
        $data['response_data'] = $rows;
        $data['message'] = "Get data successfully";
        $data['responseCode'] = "200";
        $data['status'] = "Success";
        $data['status_code'] = "1";
    } else {
        $data['response_data'] = '';
        $data['message'] = "Request error";
        $data['response_code'] = "200";
        $data['status'] = "Fail";
        $data['status_code'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

function getRosterCareWorkerDataByDate($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $Date = $post['date'];
    $OrgID = $post['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call getRosterCareWorkerDataByDate('".$Date."','".$OrgID."');");
    //CHECK FOR ERROR    
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    //echo '<pre>'; print_r($rows); die();
    if($rows) {
        $data['response_data'] = $rows;
        $data['message'] = "Get data successfully";
        $data['responseCode'] = "200";
        $data['status'] = "Success";
        $data['status_code'] = "1";
    } else {
        $data['response_data'] = '';
        $data['message'] = "Request error";
        $data['response_code'] = "200";
        $data['status'] = "Fail";
        $data['status_code'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}


/******************************************************************************************************************/
/* 
*   ID=17
*   A function used as a response to ID=17
*   It is used to loadStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion){
    session_start();
    $OrgID=$_SESSION['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	/*$sql="SELECT st.*
	FROM SCP_Staff as st
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."'";*/
	$sql="call loadStaff('".$OrgID."');";
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All staff get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Staff Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
} 

/******************************************************************************************************************/
/* 
*   ID=18
*   A function used as a response to ID=18
*   It is used to loadStaffAlpha
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadStaffAlpha($post,$deviceType,$appVersion,$OSVersion,$browserVersion){
    session_start();
    $OrgID=$_SESSION['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	$char=$post['name'];
    $sql="SELECT st.*
	FROM SCP_Staff as st
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' and st.Name LIKE '".$char."%'";
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All staff get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Request error";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=19
*   A function used as a response to ID=19
*   It is used to searchUniversalParam
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function searchUniversalParam($post,$deviceType,$appVersion,$OSVersion,$browserVersion){
    $param = $post['param'];
	session_start();
	$OrgID=$_SESSION['OrgID'];
	$con=connectToDB(); //connect to the DB
	mysql_query('SET NAMES UTF8');
	
	if($param=='Name'){
	$sql="SELECT st.*
	FROM SCP_Staff as st
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' ORDER BY st.Name";
	}elseif($param=='Surname'){
	$sql="SELECT st.*
	FROM SCP_Staff as st
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' ORDER BY st.Surname";
	
	}elseif($param=='DateOfBirth'){
		$sql="SELECT st.*
	FROM SCP_Staff as st
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' ORDER BY st.DateOfBirth";
	}elseif($param=='address'){
		$sql="SELECT st.*
	FROM SCP_Staff as st
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' ORDER BY st.Address1";
	}
	
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All staff get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Request error";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=20
*   A function used as a response to ID=20
*   It is used to searchUniversalParam
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function searchStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion){
   session_start();
    $OrgID=$_SESSION['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	$searchTxt=$post['searchTxt'];
    $sql="SELECT st.*
	FROM SCP_Staff as st
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' and st.Name LIKE '".$searchTxt."%'";
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All staff get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Request error";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

function checkRequest() {
    echo 'Wrong Method';
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// MAIN //////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

switch($ID) {
    case 0: checkRequest();
         break;
    case 1: loginWithUsername($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break; 
	case 2: createEnquiry($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break;
    case 3: loadAllCountry($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break;
    case 10: loadAllOrgniserForms($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break; 
    case 11: getFormWithdataByFormDataIDAndUserID($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break;  
    case 15: createStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break;    
    case 16: insertDynamicFormData($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break;
	case 17: loadStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	     break;      
    case 18: loadStaffAlpha($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break; 
    case 19: searchUniversalParam($post,$deviceType,$appVersion,$OSVersion,$browserVersion);   
         break;  
    case 20: searchStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break;   	       	 
    case 21: getRosterClientDataByDate($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
         break;  
    case 22: getRosterCareWorkerDataByDate($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	     break;     	                  	       	  	             
    default: myError(); 
}

?>
