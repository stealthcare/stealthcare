<?php

include 'libXML.php';
include 'lib.php';
include '../../config.php';


header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, GET, POST");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");



/* Store the id number sent by the application */
if(@$_POST['request']) {
    $post = json_decode($_POST['request']);
    ///print_r($post); die();
	/*if(is_array($post)){
	  $post = $post['0'];
	}*/
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
    $username = is_require($post, 'UserName'); 
    $password = is_require($post, 'Password'); 
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
    $UserID = is_require($post, 'UserID');
    $CustomerID = is_require($post, 'CustomerID');
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
        $nrow[] = $row;
    }
    mysql_close($con);   //close the connection
    //print_r($nrow); die();
    //while($row = mysql_fetch_assoc($result)) {
    foreach($nrow as $row) {
        $array1['FormID'] = $row['FormID'];
        $array1['FormDataID'] = $row['FormDataID'];
        $array1['FormName'] = $row['FormName'];
        /******************** userformData start *******************/
        $FormDataID = $row['FormDataID'];
        $rowData = callFormValue($CustomerID,$FormDataID);
        $filterFormWithData = $row['FormDataJson'];
        $FormStatus = '0';
        if(!empty($rowData)) {
            $arrFormValueData = unserialize($rowData['FormValueData']);
            $jsonData = json_decode($row['FormDataJson']);
            $filterAllForms = array();
            foreach ($jsonData as $key => $value) {
                $array['component'] = $value->component;
                $array['editable'] = $value->editable;
                $array['index'] = $value->index;
                $array['label'] = $value->label;
                if($value->component == 'signature' || $value->component == 'file') {
                    $baseUrlUpload = base_url."uploads";
                    $array['value'] = $baseUrlUpload.'/'.$arrFormValueData->$key;
                } else {
                    $array['value'] = $arrFormValueData->$key;
                }
                $array['description'] = $value->description;
                $array['placeholder'] = $value->placeholder;
                $array['options'] = $value->options;
                $array['required'] = $value->required;
                $filterAllForms[] = $array;
            }
            $filterFormWithData = json_encode($filterAllForms);
            $FormStatus = '1';
        }
        $array1['FormDataJson'] = $filterFormWithData;
        $array1['FormStatus'] = $FormStatus;
        $array1['FormCompletedDate'] = '';
        /******************** userformData end *******************/ 
        $array1['UserID'] = $row['UserID'];
        $array1['StatusID'] = $row['StatusID'];
        $array1['FormType'] = $row['FromType'];
        $array1['UserTypeID'] = $row['UserTypeID'];
        $orgForms[] = $array1;
    }
    //$allForms = loadAllForms($UserTypeID);
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call loadAllForms('".$UserTypeID."');");
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $allForms[] = $row;
    }
    mysql_close($con);   //close the connection
    //print_r($allForms); 
    $filterAllForms = array();
    foreach ($allForms as $key => $value) {
        if(!in_array_r($value['FormDataID'], $orgForms)) {
            $array['FormID'] = $value['FormID'];
            $array['FormDataID'] = $value['FormDataID'];
            $array['FormName'] = $value['FormName'];/******************** userformData start *******************/
            $FormDataID = $value['FormDataID'];
            $rowData = callFormValue($CustomerID,$FormDataID);
            $filterFormWithData = $value['FormDataJson'];
            $FormStatus = '0';
            if(!empty($rowData)) {
                $arrFormValueData = unserialize($rowData['FormValueData']);
                $jsonData = json_decode($value['FormDataJson']);
                $filterAllForms = array();
                foreach ($jsonData as $key => $value2) {
                    $array2['component'] = $value2->component;
                    $array2['editable'] = $value2->editable;
                    $array2['index'] = $value2->index;
                    $array2['label'] = $value2->label;
                    if($value2->component == 'signature' || $value2->component == 'file') {
                        $baseUrlUpload = base_url."uploads";
                        $array2['value'] = $baseUrlUpload.'/'.$arrFormValueData->$key;
                    } else {
                        $array2['value'] = $arrFormValueData->$key;
                    }
                    $array2['description'] = $value2->description;
                    $array2['placeholder'] = $value2->placeholder;
                    $array2['options'] = $value2->options;
                    $array2['required'] = $value2->required;
                    $filterAllForms[] = $array2;
                }
                $filterFormWithData = json_encode($filterAllForms);
                $FormStatus = '1';
            }
            $array['FormDataJson'] = $filterFormWithData;
            $array['FormStatus'] = $FormStatus;
            $array['FormCompletedDate'] = '';
            /******************** userformData end *******************/ 
            $array['UserID'] = $value['UserID'];
            $array['StatusID'] = $value['StatusID'];
            $array['FormType'] = 2;
            $array['UserTypeID'] = $value['UserTypeID'];
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

function callFormValue($CustomerID,$FormDataID) {    
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $sql1 = "SELECT * FROM SCP_OrgFormBuilderDataAction WHERE CustomerID='$CustomerID' AND FormDataID='$FormDataID'";
    $resultset1 = mysql_query($sql1);
    return $rowData = mysql_fetch_array($resultset1); 
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
    $CustomerID = is_require($post, 'CustomerID');
    $UserID = is_require($post, 'UserID');
    $FormDataID = is_require($post, 'FormDataID');
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
    $sql1 = "SELECT * FROM SCP_OrgFormBuilderDataAction WHERE CustomerID='$CustomerID' AND FormDataID='$FormDataID'";
    $resultset1 = mysql_query($sql1);
    $rowData = mysql_fetch_assoc($resultset1); 
    /******************** userformData end *******************/ 
    //print_r($arrFormValueData); die();
    $result = mysql_query("call getFormWithdataByFormDataIDAndUserID('".$OrgID."','".$UserTypeID."','".$FormDataID."');");
    //CHECK FOR ERROR       
    if (!$result) die('Invalid query: ' . mysql_error());
    $row = mysql_fetch_assoc($result);
    mysql_close($con);   //close the connection

    if(!empty($rowData)) {
        $arrFormValueData = unserialize($rowData['FormValueData']);
        $jsonData = json_decode($row['FormDataJson']);
        $filterAllForms = array();
        foreach ($jsonData as $key => $value) {
            $array['component'] = $value->component;
            $array['editable'] = $value->editable;
            $array['index'] = $value->index;
            $array['label'] = $value->label;
            $array['value'] = $arrFormValueData->$key;
            $array['description'] = $value->description;
            $array['placeholder'] = $value->placeholder;
            $array['options'] = $value->options;
            $array['required'] = $value->required;
            $filterAllForms[] = $array;
        }
        $row['FormDataJson'] = json_encode($filterAllForms);
    }
    $filterFormWithData = $row;
    //print_r($filterFormWithData); die();    
    if($filterFormWithData) {
        $data['ResponseData'] = $filterFormWithData;
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
    $explode = explode(',', @$_POST['imagesIndex']);
    //print_r($explode); die();
    $UserID = is_require($post, 'UserID');
    $CustomerID = is_require($post, 'CustomerID');
    $FormDataID = is_require($post, 'FormDataID');
    $StatusID='1';
    $success = false;
    $CreatedDateTime = date('Y-m-d H:i:s');
    $ModifyDateTime = date('Y-m-d H:i:s');
    $con=connectToDB(); //connect to the DB
    $StatusID='1';
    $result = mysql_query("call insertDynamicFormData('".$FormValueData."','".$UserID."','".$CustomerID."','".$FormDataID."','".$StatusID."','".$CreatedDateTime."','".$ModifyDateTime."')")or die(mysql_error());
    $row = mysql_fetch_assoc($result);
    if(!empty($row)) {
        $row['FormValueData'] = unserialize($row['FormValueData']);
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
        $data['ResponseData'] = $row;
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

    $QualificationID = '0';
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
    $Password=md5($post['Password']);
    $CreatedDateTime = date('Y-m-d H:i:s');
    $ModifyDateTime = date('Y-m-d H:i:s');
    $EmailID=$post['EmailID'];
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
	
	if(!empty($LicenseID)){
    $result = mysql_query("call createStaff('".$QualificationID."','".$EmailID."','".$OrgID."','".$Title."','".$FirstName."','".$Surname."','".$MiddleName."','".$DateOfBirth."','".$Gender."','".$Ethnicity."','".$HouseNumber."','".$Address1."','".$Address2."','".$City."','".$Country."','".$PostCode."','".$Mobile."','".$ProfilePhoto."','".$NOKName."','".$NOKMobile."','".$NOKEmail."','".$UserName."','".$Password."','".$RightsID."','".$AccessLevelID."','".$UserTypeID."','".$CreatedDateTime."','".$ModifyDateTime."','".$StatusID."','".$LicenseID."')")or die(mysql_error());
	}else{
	$result = '';
	}
   
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
    $Date = date('Y-m-d');
    $OrgID = $post['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call getRosterClientDataByDate('".$Date."','".$OrgID."');");
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $row1['id'] = $row['CustomerID'];
        $row1['text'] = $row['CustomerName'];
        $rows[] = $row1;
    }
    print json_encode($rows);
    mysql_close($con);   //close the connection
}

function getRosterCareWorkerDataByDate($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $Date = date('Y-m-d');
    $OrgID = $post['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call getRosterCareWorkerDataByDate('".$Date."','".$OrgID."');"); 
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $row1['id'] = $row['StaffID'];
        $row1['text'] = $row['Name'].' '.$row['MiddleName'].' '.$row['Surname'];
        $rows[] = $row1;
    }
    print json_encode($rows);
    mysql_close($con);   //close the connection
}

function loadAllVisits($post,$deviceType,$appVersion,$OSVersion,$browserVersion){
    $con=connectToDB(); //connect to the DB
    $sDate = date('Y-m-d', strtotime($post['sdate']));
    $eDate = date('Y-m-d', strtotime($post['edate']));
    mysql_query('SET NAMES UTF8');    
    $sql="SELECT * FROM SCP_Visits WHERE VisitStartDate >= '$sDate' AND VisitStartDate <= '$eDate'";
    $result = mysql_query($sql);    
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $row1['visitname'] = $row['VisitTitle'];
        $row1['task'] = $row['TaskIDs'];
        $row1['outcomesachived'] = 'yes';
        $row1['status'] = 'complete';
        $row1['client'] = 'Martin';
        $row1['careworker'] = 'John';
        $row1['color'] = '#80BCA2';
        $row1['ClientId'] = $row['CustomerID'];
        $row1['VisitID'] = $row['VisitID'];
        $row1['CareWorkerID'] = $row['CareWorkerID'];
        $row1['startDate'] = date('Y-m-d H:i:s', strtotime($row['VisitStartDate'].' '.$row['VisitStartTime']));
        $row1['endDate'] = date('Y-m-d H:i:s', strtotime($row['VisitEndDate'].' '.$row['VisitEndTime']));
        $rows[] = $row1;
    }
    print json_encode($rows);
    mysql_close($con);   //close the connection
} 

function loadVisitByID($post,$deviceType,$appVersion,$OSVersion,$browserVersion){
    $con=connectToDB(); //connect to the DB
    $VisitID = $post['VisitID'];
    mysql_query('SET NAMES UTF8');    
    $sql="SELECT * FROM SCP_Visits WHERE VisitID='$VisitID'";
    $result = mysql_query($sql);    
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $row1['visitname'] = $row['VisitTitle'];
        $row1['task'] = $row['TaskIDs'];
        $row1['outcomesachived'] = 'yes';
        $row1['status'] = 'complete';
        $row1['client'] = 'Martin';
        $row1['careworker'] = 'John';
        $row1['color'] = '#80BCA2';
        $row1['ClientId'] = $row['CustomerID'];
        $row1['VisitID'] = $row['VisitID'];
        $row1['CareWorkerID'] = $row['CareWorkerID'];
        $row1['startDate'] = date('Y-m-d H:i:s', strtotime($row['VisitStartDate'].' '.$row['VisitStartTime']));
        $row1['endDate'] = date('Y-m-d H:i:s', strtotime($row['VisitEndDate'].' '.$row['VisitEndTime']));
        $rows[] = $row1;
    }
    print json_encode($rows);
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
    $ArchiveUser=$post['ArchiveUser'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');

    //$sql="call loadStaff('".$OrgID."','".$ArchiveUser."');";
    
    
    $sql="SELECT st.*
    FROM SCP_Staff as st
    INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' and st.ArchiveUser='".$ArchiveUser."'";
    $result = mysql_query($sql);
    
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
	    @$row['full_name']=$row['Title']." ".$row['Name']." ".$row['Surname'];
	    @$row['full_address']=$row['HouseNumber']." ".$row['Address1']." ".$row['Address2'];
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
    $ArchiveUser=$post['ArchiveUser'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $char=$post['name'];
    $sql="SELECT st.*
    FROM SCP_Staff as st
    INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' and st.ArchiveUser='".$ArchiveUser."' and st.Name LIKE '".$char."%'";
    $result = mysql_query($sql);
    
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
	    @$row['full_name']=$row['Title']." ".$row['Name']." ".$row['Surname'];
	    @$row['full_address']=$row['HouseNumber']." ".$row['Address1']." ".$row['Address2'];
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
	$searchTxt=$post['searchTxt'];
	$ArchiveUser=$post['ArchiveUser'];
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
	INNER JOIN SCP_UserLogin as ulogin ON st.UserID=ulogin.UserID where st.OrgID='".$OrgID."' and  st.DateOfBirth='".$searchTxt."' and st.ArchiveUser='".$ArchiveUser."'";
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
	    @$row['full_name']=$row['Title']." ".$row['Name']." ".$row['Surname'];    
	    @$row['full_address']=$row['HouseNumber']." ".$row['Address1']." ".$row['Address2'];
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
        $data['message'] = "No Staff Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=23
*   A function used as a response to ID=23
*   It is used to editStaffload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function editStaffload($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');

     
			
	 $sql="SELECT st.*,ulogin.UserName,ulogin.EmailID,ulogin.Password,uaccess.UserTypeID
FROM SCP_Staff as st 
INNER JOIN SCP_UserLogin as ulogin ON ulogin.UserID=st.UserID 
INNER JOIN SCP_UserAccess as uaccess ON uaccess.UserAccessID=st.UserAccessID 
where st.StaffID='".$post['StaffID']."'";		
			
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
	    $StatusID=$row['StatusID'];
		$postcode = explode(' ', $row['PostCode']);
		@$row['postcode1'] = $postcode[0];
		@$row['postcode2'] = $postcode[1]; 
		@$row['serviceRequestID']='24';
        $rows[] = $row;	
		$arr=$row;	
    }	
	
    if($rows) {
        $data['responseData'] = $rows;
		$data['responseData2'] = $arr;
        $data['message'] = "Staff get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
		$data['StatusID']=$StatusID;
    } else {
        $data['responseData'] = '';
		$data['responseData2'] = '';
        $data['message'] = "No Staff Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
		$data['StatusID']="";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=24
*   A function used as a response to ID=24
*   It is used to updateStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function updateStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion){
    $role = $post['UserTypeID'];
    $QualificationID = "0";
    $Title = $post['Title'];
    $Name = $post['Name'];
    $Surname = $post['Surname'];
    $MiddleName = $post['MiddleName'];
    $DateOfBirth = $post['DateOfBirth'];
    $Gender = $post['Gender'];
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
    $ModifyDateTime = date('Y-m-d H:i:s');
    $EmailID=$post['EmailID'];
	$ArchiveUser=$post['ArchiveUser'];
    $con=connectToDB(); //connect to the DB
    $UserID = $post['UserName'];
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
    $StaffID = $post['StaffID'];
	$UserID  = $post['UserID'];
	
	if($ArchiveUser=='0'){
	  $StatusID = $post['StatusID'];
	}elseif($ArchiveUser=='1'){
	  $StatusID = '2';
	}
	
	
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
	
	
	
		
	$sql2="UPDATE `SCP_Staff` SET `StatusID`='".$StatusID."',`QualificationID` = '".$QualificationID."',`Title` = '".$Title."',`Name` = '".$Name."',`Surname` = '".$Surname."',`MiddleName` = '".$MiddleName."',`DateOfBirth` = '".$DateOfBirth."',`Gender` = '".$Gender."',`Ethnicity` = '".$Ethnicity."',`HouseNumber` = '".$HouseNumber."',`Address1` = '".$Address1."',`Address2` = '".$Address2."',`City` = '".$City."',`Country` = '".$Country."',`PostCode` = '".$PostCode."',`Mobile` = '".$Mobile."',`NOKName` = '".$NOKName."',`NOKMobile` = '".$NOKMobile."',`NOKEmail` = '".$NOKEmail."',`ModifyDateTime` = '".$ModifyDateTime."',`ArchiveUser` = '".$ArchiveUser."' WHERE `StaffID` = '".$StaffID."'";	 
    $result = mysql_query($sql2) or die(mysql_error());
	
	$sql3="UPDATE `SCP_UserLogin` SET `StatusID`='".$StatusID."' WHERE `UserID` = '".$UserID."'";	 
    $result = mysql_query($sql3) or die(mysql_error());
	
	
	$sql4="UPDATE `SCP_UserAccess` SET `RightsID`='".$RightsID."',`AccessLevelID`='".$AccessLevelID."',`UserTypeID`='".$UserTypeID."',`ModifyDateTime`='".$ModifyDateTime."',`StatusID`='".$StatusID."' WHERE `UserID` = '".$UserID."'";	
	$result = mysql_query($sql4) or die(mysql_error());
	
	
	if(!empty($ProfilePhoto)){
	  $sql="UPDATE `SCP_UserLogin` SET `ProfilePhoto`='".$ProfilePhoto."' WHERE `UserID` = '".$UserID."'";	 
      $result = mysql_query($sql) or die(mysql_error());
	  $sql="UPDATE `SCP_Staff` SET `ProfilePhoto`='".$ProfilePhoto."' WHERE `StaffID` = '".$StaffID."'";	 
      $result = mysql_query($sql) or die(mysql_error()); 
	}
	
	$result=true;
	
  
    if($result) {
        $data['responseData'] = "";
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Updation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=25
*   A function used as a response to ID=25
*   It is used to loadAllQualification
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllQualification($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call loadAllQualification();");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
	
	//@$sel_set=mysql_fetch_assoc($result);
	//@$sel_set=@$sel_set['QualificationID'];
	
    while($row = mysql_fetch_assoc($result)) {
	    @$sel_set=$row['QualificationID'];
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['responseMessage'] = "All Qualification get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
		$data['selectedQual'] = $sel_set;
    } else {
        $data['responseData'] = '';
        $data['responseMessage'] = "Request error";
        $data['responseCode'] = "201";
        $data['status'] = "0";
		$data['selectedQual'] ="";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=26
*   A function used as a response to ID=26
*   It is used to loadAllEquipments
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllEquipments($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
    $result = mysql_query("SELECT * FROM SCP_Equipments WHERE OrgID='".$OrgID."'");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
		   if($row['StatusID'] == 1) {
				$row['Status'] = 'Active';
			} else {
				$row['Status'] = 'Deactive';
			}
			$rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Equipments get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Equipments Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=27
*   A function used as a response to ID=27
*   It is used to createEquipment
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function createEquipment($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$Equipment=$post['Equipment'];
	$Description=$post['Description'];
	$StatusID='1';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	
	
     $result = mysql_query("INSERT INTO `SCP_Equipments` (`Equipment`, `Description`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$Equipment', '$Description', '$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Equipments create sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Equipments Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=28
*   A function used as a response to ID=28
*   It is used to editEquipmentsload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function editEquipmentsload($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
	$sql="SELECT * FROM SCP_Equipments where EquipmentID='".$post['EquipmentID']."'";				
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
	    @$row['serviceRequestID']='29';
        $rows[] = $row;		
    }
		
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "Equipment get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Equipment Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=29
*   A function used as a response to ID=29
*   It is used to updateEquipments
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function updateEquipments($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $Equipment=$post['Equipment'];
	$Description=$post['Description'];
	$ModifyDateTime=date('Y-m-d H:i:s');
	$EquipmentID=$post['EquipmentID'];
	$sql2="UPDATE `SCP_Equipments` SET `Equipment` = '".$Equipment."',`Description` = '".$Description."',`ModifyDateTime` = '".$ModifyDateTime."' WHERE `EquipmentID` = '".$EquipmentID."'";	 
    $result = mysql_query($sql2) or die(mysql_error());
	
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
		
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Updation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=30
*   A function used as a response to ID=30
*   It is used to editStaffload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function changeStatusEquipments($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $StatusID=$post['StatusID'];
	$EquipmentID=$post['EquipmentID'];
	
	
	    $errorMsg="Error in updation";
		$result2 = mysql_query("SELECT * FROM SCP_Equipments_Staff WHERE EquipmentID='".$EquipmentID."'")or die(mysql_error());
		$num_rows = mysql_num_rows($result2);
		
		
		if($num_rows>0){
		  $result = '';
		  $errorMsg = 'Sorry, you do not deactivate this Equipment, it is already assigned to some staff.';
		}else{
		  	$sql2="UPDATE `SCP_Equipments` SET `StatusID` = '".$StatusID."' WHERE `EquipmentID` = '".$EquipmentID."'";	 
            $result = mysql_query($sql2) or die(mysql_error());
		}
			
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = $errorMsg;
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

/******************************************************************************************************************/
/* 
*   ID=32
*   A function used as a response to ID=32
*   It is used to loadAllStaffOrg
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllStaffOrg($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
    $result = mysql_query("SELECT * FROM SCP_Staff WHERE OrgID='".$OrgID."' and StatusID='1'");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
			$rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Staff get successfully";
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
*   ID=33
*   A function used as a response to ID=33
*   It is used to loadAllStaffOrg
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllEquipmentsOrg($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
    $result = mysql_query("SELECT * FROM SCP_Equipments WHERE OrgID='".$OrgID."' and StatusID='1'");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
			$rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Equipments get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Equipments Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=39
*   A function used as a response to ID=39
*   It is used to loadQualificationStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadQualificationStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	

	
	$result = mysql_query("SELECT * FROM SCP_Qualification WHERE StatusID='1' and OrgID='0' or OrgID='".$OrgID."'");
	
	
	if(!empty($result)){
	   while($row = mysql_fetch_assoc($result)) {
	        $QualificationID=$row['QualificationID'];	
			
			$result2 = mysql_query("SELECT * FROM SCP_Qualification_Staff WHERE StaffID='".$StaffID."' and QualificationID='".$QualificationID."'");
			$res = mysql_fetch_assoc($result2);
			if(!empty($res['QualificationID'])){
			  $row['sel']="true";
			}else{
			  $row['sel']="false";
			}
			$rows[] = $row;
       }
	}

    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Qualification_Staff get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Qualification_Staff Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=40
*   A function used as a response to ID=40
*   It is used to assignQualifications
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function assignQualificationsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	$QualificationID=$post['QualificationID'];
	$StatusID='1';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	$QualificationIDArr=explode(",",$QualificationID);
	
     $result = mysql_query("DELETE FROM `SCP_Qualification_Staff` WHERE StaffID='".$StaffID."'") or die(mysql_error());
	
	
	for($i=0;$i<count($QualificationIDArr);$i++){
     $ins=$QualificationIDArr[$i];
	 $result = mysql_query("INSERT INTO `SCP_Qualification_Staff` (`StaffID`, `QualificationID`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$StaffID', '$ins', '$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");	

	  
	}
	
     
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Qualification assign sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Insert";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=41
*   A function used as a response to ID=41
*   It is used to loadQualificationStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadEquipmentsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	
	$result = mysql_query("SELECT * FROM SCP_Equipments WHERE StatusID='1' and OrgID='0' or OrgID='".$OrgID."'");
	
	
	if(!empty($result)){
	   while($row = mysql_fetch_assoc($result)) {
	        $EquipmentID=$row['EquipmentID'];	
			
			$result2 = mysql_query("SELECT * FROM SCP_Equipments_Staff WHERE StaffID='".$StaffID."' and EquipmentID='".$EquipmentID."'");
			$res = mysql_fetch_assoc($result2);
			if(!empty($res['EquipmentID'])){
			  $row['sel']="true";
			}else{
			  $row['sel']="false";
			}
			$rows[] = $row;
       }
	}

    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All SCP_Equipments_Staff get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No SCP_Equipments_Staff Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=42
*   A function used as a response to ID=42
*   It is used to assignEquipmentsStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function assignEquipmentsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	$EquipmentID=$post['EquipmentID'];
	$StatusID='1';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	$EquipmentIDArr=explode(",",$EquipmentID);
	
     $result = mysql_query("DELETE FROM `SCP_Equipments_Staff` WHERE StaffID='".$StaffID."'") or die(mysql_error());
	
	
	for($i=0;$i<count($EquipmentIDArr);$i++){
     $ins=$EquipmentIDArr[$i];
	 $result = mysql_query("INSERT INTO `SCP_Equipments_Staff` (`StaffID`, `EquipmentID`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$StaffID', '$ins', '$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");	

	  
	}
	
     
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Equipments assign sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Insert";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=43
*   A function used as a response to ID=43
*   It is used to loadChecksStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadChecksStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	
	$result = mysql_query("SELECT * FROM SCP_Checks WHERE StatusID='1' and OrgID='0' or OrgID='".$OrgID."'");
	
	
	if(!empty($result)){
	   while($row = mysql_fetch_assoc($result)) {
	        $ChecksID=$row['ChecksID'];	
			
			$result2 = mysql_query("SELECT * FROM SCP_Checks_Staff WHERE StaffID='".$StaffID."' and ChecksID='".$ChecksID."'");
			$res = mysql_fetch_assoc($result2);
			if(!empty($res['ChecksID'])){
			  $row['sel']="true";
			}else{
			  $row['sel']="false";
			}
			$rows[] = $row;
       }
	}

    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All SCP_Checks get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No SCP_Checks Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=44
*   A function used as a response to ID=44
*   It is used to assignEquipmentsStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function assignChecksStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	$ChecksID=$post['ChecksID'];
	$StatusID='1';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	$ChecksIDArr=explode(",",$ChecksID);
	
     $result = mysql_query("DELETE FROM `SCP_Checks_Staff` WHERE StaffID='".$StaffID."'") or die(mysql_error());
	
	
	for($i=0;$i<count($ChecksIDArr);$i++){
     $ins=$ChecksIDArr[$i];
	 $result = mysql_query("INSERT INTO `SCP_Checks_Staff` (`StaffID`, `ChecksID`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$StaffID', '$ins', '$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");	

	  
	}
	
     
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Checks assign sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Insert";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=45
*   A function used as a response to ID=45
*   It is used to editSettingload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function editSettingload($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    session_start();
    $OrgID=$_SESSION['OrgID'];		
	
	$sql="SELECT sc.*,ulogin.ProfilePhoto
FROM SCP_CareOrg as sc 
INNER JOIN SCP_UserLogin as ulogin ON ulogin.UserID=sc.UserID 
where sc.OrgID='".$OrgID."'";	
	
	
			
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;	
		$arr=$row;	
    }	
	
    if($rows) {
        $data['responseData'] = $rows;
		$data['responseData2'] = $arr;
        $data['message'] = "Setting get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
		$data['responseData2'] = '';
        $data['message'] = "No Setting Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=46
*   A function used as a response to ID=46
*   It is used to loadAllChecksSetting
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllChecksSetting($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
    $result = mysql_query("SELECT * FROM SCP_Checks WHERE OrgID='".$OrgID."'");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
		   if($row['StatusID'] == 1) {
				$row['Status'] = 'Active';
			} else {
				$row['Status'] = 'Deactive';
			}
			$rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Checks get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Checks Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=47
*   A function used as a response to ID=47
*   It is used to editStaffload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function changeStatusChecks($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $StatusID=$post['StatusID'];
	$ChecksID=$post['ChecksID'];
	
	
	    $errorMsg="Error in updation";
		$result2 = mysql_query("SELECT * FROM SCP_Checks_Staff WHERE ChecksID='".$ChecksID."'")or die(mysql_error());
		$num_rows = mysql_num_rows($result2);
		
		
		if($num_rows>0){
		  $result = '';
		  $errorMsg = 'Sorry, you do not deactivate this Check, it is already assigned to some staff.';
		}else{
		  	$sql2="UPDATE `SCP_Checks` SET `StatusID` = '".$StatusID."' WHERE `ChecksID` = '".$ChecksID."'";	 
            $result = mysql_query($sql2) or die(mysql_error());
		}
			
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = $errorMsg;
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=48
*   A function used as a response to ID=48
*   It is used to createEquipment
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function createChecks($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$Checks=$post['Checks'];
	$Description=$post['Description'];
	$StatusID='1';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	
	
     $result = mysql_query("INSERT INTO `SCP_Checks` (`Checks`, `Description`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$Checks', '$Description', '$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Checks create sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Creation";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=49
*   A function used as a response to ID=49
*   It is used to editEquipmentsload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function editChecksload($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
	$sql="SELECT * FROM SCP_Checks where ChecksID='".$post['ChecksID']."'";				
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
	    @$row['serviceRequestID']='50';
        $rows[] = $row;	
		$arr=$row;		
    }
		
    if($rows) {
        $data['responseData'] = $rows;
		$data['responseData2'] = $arr;
        $data['message'] = "Checks get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
		$data['responseData2'] = '';
        $data['message'] = "No Checks Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=50
*   A function used as a response to ID=50
*   It is used to updateEquipments
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function updateChecks($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $Checks=$post['Checks'];
	$Description=$post['Description'];
	$ModifyDateTime=date('Y-m-d H:i:s');
	$ChecksID=$post['ChecksID'];
	$sql2="UPDATE `SCP_Checks` SET `Checks` = '".$Checks."',`Description` = '".$Description."',`ModifyDateTime` = '".$ModifyDateTime."' WHERE `ChecksID` = '".$ChecksID."'";	 
    $result = mysql_query($sql2) or die(mysql_error());
	
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
		
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Updation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=51
*   A function used as a response to ID=51
*   It is used to loadAllGroupSetting
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllGroupSetting($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
    $result = mysql_query("SELECT * FROM SCP_Groups WHERE OrgID='".$OrgID."'");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
		   if($row['StatusID'] == 1) {
				$row['Status'] = 'Active';
			} else {
				$row['Status'] = 'Deactive';
			}
			$rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Groups get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Groups Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=52
*   A function used as a response to ID=52
*   It is used to createGroup
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function createGroup($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$GroupName=$post['GroupName'];
	$StatusID='1';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	
	
     $result = mysql_query("INSERT INTO `SCP_Groups` (`GroupName`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$GroupName','$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Group create sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Creation";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=53
*   A function used as a response to ID=53
*   It is used to editGroupload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function editGroupload($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
	$sql="SELECT * FROM SCP_Groups where GroupID='".$post['GroupID']."'";				
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
	    @$row['serviceRequestID']='54';
        $rows[] = $row;	
		$arr=$row;		
    }
		
    if($rows) {
        $data['responseData'] = $rows;
		$data['responseData2'] = $arr;
        $data['message'] = "Group get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
		$data['responseData2'] = '';
        $data['message'] = "No Group Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=54
*   A function used as a response to ID=54
*   It is used to updateGroup
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function updateGroup($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $GroupName=$post['GroupName'];
	$ModifyDateTime=date('Y-m-d H:i:s');
	$GroupID=$post['GroupID'];
	$sql2="UPDATE `SCP_Groups` SET `GroupName` = '".$GroupName."',`ModifyDateTime` = '".$ModifyDateTime."' WHERE `GroupID` = '".$GroupID."'";	 
    $result = mysql_query($sql2) or die(mysql_error());
	
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
		
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Updation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=55
*   A function used as a response to ID=55
*   It is used to changeStatusGroup
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function changeStatusGroup($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $StatusID=$post['StatusID'];
	$GroupID=$post['GroupID'];
	
	
	    $errorMsg="Error in updation";
		$result2 = mysql_query("SELECT * FROM SCP_Groups_Staff WHERE GroupID='".$GroupID."'")or die(mysql_error());
		$num_rows = mysql_num_rows($result2);
		

		if($num_rows>0){
		  $result = '';
		  $errorMsg = 'Sorry, you do not deactivate this Check, it is already assigned to some staff.';
		}else{
		  	$sql2="UPDATE `SCP_Groups` SET `StatusID` = '".$StatusID."' WHERE `GroupID` = '".$GroupID."'";	 
            $result = mysql_query($sql2) or die(mysql_error());
		}
			
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = $errorMsg;
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=56
*   A function used as a response to ID=56
*   It is used to loadGroupsStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadGroupsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	
	$result = mysql_query("SELECT * FROM SCP_Groups WHERE StatusID='1' and OrgID='".$OrgID."'");
	
	
	if(!empty($result)){
	   while($row = mysql_fetch_assoc($result)) {
	        $GroupID=$row['GroupID'];	
			
			$result2 = mysql_query("SELECT * FROM SCP_Groups_Staff WHERE StaffID='".$StaffID."' and GroupID='".$GroupID."'");
			$res = mysql_fetch_assoc($result2);
			if(!empty($res['GroupID'])){
			  $row['sel']="true";
			}else{
			  $row['sel']="false";
			}
			$rows[] = $row;
       }
	}

    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Groups get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Groups Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=57
*   A function used as a response to ID=57
*   It is used to assignGroupStaff
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function assignGroupStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$StaffID=$post['StaffID'];
	$GroupID=$post['GroupID'];
	$StatusID='1';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	$GroupIDArr=explode(",",$GroupID);
	
     $result = mysql_query("DELETE FROM `SCP_Groups_Staff` WHERE StaffID='".$StaffID."'") or die(mysql_error());
	
	
	for($i=0;$i<count($GroupIDArr);$i++){
     $ins=$GroupIDArr[$i];
	 $result = mysql_query("INSERT INTO `SCP_Groups_Staff` (`StaffID`, `GroupID`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$StaffID', '$ins', '$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");	

	  
	}
	
     
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Groups assign sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Insert";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=58
*   A function used as a response to ID=58
*   It is used to loadAllQualificationSetting
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function loadAllQualificationSetting($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
  $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	 session_start();
    $OrgID=$_SESSION['OrgID'];
    $result = mysql_query("SELECT * FROM SCP_Qualification WHERE OrgID='".$OrgID."'");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
		   if($row['StatusID'] == 1) {
				$row['Status'] = 'Active';
			} else {
				$row['Status'] = 'Deactive';
			}
			$rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['message'] = "All Qualification get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "No Qualification Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=59
*   A function used as a response to ID=59
*   It is used to createGroup
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function createQualfications($post,$deviceType,$appVersion,$OSVersion,$browserVersion)
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
	session_start();
    $OrgID=$_SESSION['OrgID'];
	$Qualification=$post['Qualification'];
	$StatusID='1';
	$Slug='';
	$CreatedDateTime = date('Y-m-d H:i:s');
	$ModifyDateTime = date('Y-m-d H:i:s');
	
	
	
     $result = mysql_query("INSERT INTO `SCP_Qualification` (`Qualification`, `OrgID`, `StatusID`,`CreatedDateTime`, `ModifyDateTime`) VALUES ('$Qualification','$OrgID', '$StatusID','$CreatedDateTime', '$ModifyDateTime')");
     if (!$result) die('Invalid query: ' . mysql_error());

    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Qualification create sucessfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Creation";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=60
*   A function used as a response to ID=60
*   It is used to changeStatusQualfications
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function changeStatusQualfications($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $StatusID=$post['StatusID'];
	$QualificationID=$post['QualificationID'];
	
	
	    $errorMsg="Error in updation";
		$result2 = mysql_query("SELECT * FROM SCP_Qualification_Staff WHERE QualificationID='".$QualificationID."'")or die(mysql_error());
		$num_rows = mysql_num_rows($result2);
		

		if($num_rows>0){
		  $result = '';
		  $errorMsg = 'Sorry, you do not deactivate this Qualification, it is already assigned to some staff.';
		}else{
		  	$sql2="UPDATE `SCP_Qualification` SET `StatusID` = '".$StatusID."' WHERE `QualificationID` = '".$QualificationID."'";	 
            $result = mysql_query($sql2) or die(mysql_error());
		}
			
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = $errorMsg;
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=61
*   A function used as a response to ID=61
*   It is used to editQualificationload
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function editQualificationload($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
	$sql="SELECT * FROM SCP_Qualification where QualificationID='".$post['QualificationID']."'";				
	$result = mysql_query($sql);
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
	    @$row['serviceRequestID']='62';
        $rows[] = $row;	
		$arr=$row;		
    }
		
    if($rows) {
        $data['responseData'] = $rows;
		$data['responseData2'] = $arr;
        $data['message'] = "Qualification get successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
		$data['responseData2'] = '';
        $data['message'] = "No Qualification Found";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
/******************************************************************************************************************/
/* 
*   ID=54
*   A function used as a response to ID=54
*   It is used to updateGroup
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function updateQualification($post,$deviceType,$appVersion,$OSVersion,$browserVersion){

    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');		
    $Qualification=$post['Qualification'];
	$ModifyDateTime=date('Y-m-d H:i:s');
	$QualificationID=$post['QualificationID'];
	$sql2="UPDATE `SCP_Qualification` SET `Qualification` = '".$Qualification."',`ModifyDateTime` = '".$ModifyDateTime."' WHERE `QualificationID` = '".$QualificationID."'";	 
    $result = mysql_query($sql2) or die(mysql_error());
	
	
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
		
    if($result) {
        $data['responseData'] = '';
        $data['message'] = "Updated successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['message'] = "Error in Updation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}
function is_require($a, $i) {
    if (!isset($a[$i]) || $a[$i] == '') {
        echo $i.' parameter missing or it should not null';
        die();
    } else {
        return $a[$i];
    }
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
	case 23: editStaffload($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	     break; 
	case 24: updateStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	     break;  
    case 25: loadAllQualification($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	    break;
	case 26: loadAllEquipments($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
 	    break;	
	case 27: createEquipment($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
 	    break;
	case 28: editEquipmentsload($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
 	    break;
	case 29: updateEquipments($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
 	    break;
	case 30: changeStatusEquipments($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
 	    break;		
	case 32: loadAllStaffOrg($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
 	    break;	
	case 33: loadAllEquipmentsOrg($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
 	    break;	
    case 37: loadVisitByID($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
        break;  													   	
    case 38: loadAllVisits($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
        break;  
	case 39: loadQualificationStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion);				        break;
	case 40: assignQualificationsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion); 
	    break;
	case 41: loadEquipmentsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion); 
	    break;	
	case 42: assignEquipmentsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion); 
	    break;	
	case 43: loadChecksStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion); 
	    break;	
	case 44: assignChecksStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion); 
	    break;			
	case 45: editSettingload($post,$deviceType,$appVersion,$OSVersion,$browserVersion); 
	    break;	
	case 46: loadAllChecksSetting($post,$deviceType,$appVersion,$OSVersion,$browserVersion); 
	    break;	
	case 47: changeStatusChecks($post,$deviceType,$appVersion,$OSVersion,$browserVersion);									    	break;	
	case 48: createChecks($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	    break;	
	case 49: editChecksload($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;
	case 50: updateChecks($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;
	case 51: loadAllGroupSetting($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;
	case 52: createGroup($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	    break;	
	case 53: editGroupload($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;	
	case 54: updateGroup($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;	
	case 55: changeStatusGroup($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;
	case 56: loadGroupsStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;	
	case 57: assignGroupStaff($post,$deviceType,$appVersion,$OSVersion,$browserVersion);	
		break;	
	case 58: loadAllQualificationSetting($post,$deviceType,$appVersion,$OSVersion,$browserVersion);		
	    break;
	case 59: createQualfications($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	    break;
	case 60: changeStatusQualfications($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
	    break;	
	case 61: editQualificationload($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
        break;	
	case 62: updateQualification($post,$deviceType,$appVersion,$OSVersion,$browserVersion);
		break;																		
    default: myError(); 
}

?>
