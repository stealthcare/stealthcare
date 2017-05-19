<?php

include 'libXML.php';
include 'lib.php';
include '../../config.php';

/* Store the id number sent by the application */
if(@$_REQUEST['request']) {
    // request in json string '[{"username":"abanwar","password":"123456","id":"1"}]';
    $post = json_decode($_REQUEST['request']);
	//print_r($post); die();
	if(is_array($post)){
	  $post = $post['0'];
	}
    
    $postArray = array();
    foreach($post as $key => $field){
        $postArray[$key] = $field;
    }
    $post = $postArray;
    $ID = $post['serviceRequestID'];
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
function loginWithUsername($post)
{
    $username = $post['username'];
    $password = $post['password'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');   
    $password = md5($password); 
    $result = mysql_query("call loginWithUsername('".$username."','".$password."');");
    //CHECK FOR ERROR
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['responseMessage'] = "Login successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['responseMessage'] = "Please check your Username and Password";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
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
function createEnquiry($post)
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
    $UserTypeID='3';
    $StatusID='1';
    session_start();
    $OrgID=$_SESSION['OrgID'];

    $con=connectToDB(); //connect to the DB

    $result = mysql_query("call createEnquiry('".$OrgID."','".$CustomerTitle."','".$CustomerName."','".$CustomerSurname."','".$CustomerMiddleName."','".$DateOfBirth."','".$NHSNumber."','".$Gender."','".$Ethnicity."','".$Address1."','".$Address2."','".$PostCode."','".$City."','".$Landline."','".$ContactNo."','".$OtherDetails."','".$CareInfo."','".$OutcomesInfo."','".$SupportInfo."','".$MakeEnq."','".$RightsID."','".$AccessLevelID."','".$UserTypeID."','".$CreatedDateTime."','".$ModifyDateTime."','".$StatusID."')")or die(mysql_error());
    if($result) {
        $data['responseData'] = '';
        $data['responseMessage'] = "Created successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['responseMessage'] = "Error in Creation";
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
function loadAllCountry($post)
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
function loadAllOrgniserForms($post)
{
    $OrgID = $post['OrgID'];
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call loadAllOrgniserForms('".$OrgID."');");
    //CHECK FOR ERROR    
    if (!$result) die('Invalid query: ' . mysql_error());
    $orgForms = array();
    while($row = mysql_fetch_assoc($result)) {
        $orgForms[] = $row;
    }
    mysql_close($con);   //close the connection
    $allForms = loadAllForms();
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
            $array['CreatedDateTime'] = $value['CreatedDateTime'];
            $array['ModifyDateTime'] = $value['ModifyDateTime'];
            $filterAllForms[] = $array;
        }
    }
    //print_r($newArray2); die();
    $rows = array_merge($orgForms,$filterAllForms);
    if($rows) {
        $data['responseData'] = $rows;
        $data['responseMessage'] = "Get all forms successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['responseMessage'] = "Request error";
        $data['responseCode'] = "201";
        $data['status'] = "0";
    }
    print json_encode($data);
}

function loadAllForms()
{
    $con=connectToDB(); //connect to the DB
    mysql_query('SET NAMES UTF8');
    $result = mysql_query("call loadAllForms();");
    if (!$result) die('Invalid query: ' . mysql_error());
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    return $rows;
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
function createStaff($post)
{
//echo '<pre/>';
//print_r($post);die;
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
    $ProfilePhoto=$post['ProfilePhoto'];   
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
	
	$StatusID='1';
	$result = mysql_query("call createStaff('".$OrgID."','".$Title."','".$FirstName."','".$Surname."','".$MiddleName."','".$DateOfBirth."','".$Gender."','".$Ethnicity."','".$HouseNumber."','".$Address1."','".$Address2."','".$City."','".$Country."','".$PostCode."','".$Mobile."','".$ProfilePhoto."','".$NOKName."','".$NOKMobile."','".$NOKEmail."','".$UserName."','".$Password."','".$RightsID."','".$AccessLevelID."','".$UserTypeID."','".$CreatedDateTime."','".$ModifyDateTime."','".$StatusID."','".$LicenseID."')")or die(mysql_error());
   
    if($result) {
        $data['responseData'] = '';
        $data['responseMessage'] = "Created successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = '';
        $data['responseMessage'] = "Error in Creation";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

/******************************************************************************************************************/
/* 
*   ID=16
*   A function used as a response to ID=16
*   It is used to insertDynamicFormData
*   PARAMETERS: -
*   Return Value: User Details se morfi json
*/
function insertDynamicFormData($post)
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
        $data['responseData'] = $formsData;
        $data['responseMessage'] = "Form data inserted successfully";
        $data['responseCode'] = "200";
        $data['status'] = "1";
    } else {
        $data['responseData'] = $post;
        $data['responseMessage'] = "Error in uploading...";
        $data['responseCode'] = "200";
        $data['status'] = "0";
    }
    print json_encode($data);
    mysql_close($con);   //close the connection
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// MAIN //////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

switch($ID) {
    case 1: loginWithUsername($post);
         break; 
	case 2: createEnquiry($post);
         break;
    case 3: loadAllCountry($post);
         break;
    case 10: loadAllOrgniserForms($post);
         break;  
    case 15: createStaff($post);
         break;    
    case 16: insertDynamicFormData($post);
         break;     	             
    default: myError(); 
}

?>
