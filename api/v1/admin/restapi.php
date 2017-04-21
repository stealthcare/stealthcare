<?php

include 'libXML.php';
include 'lib.php';
include '../../config.php';

/* Store the id number sent by the application */
if(@$_REQUEST['request']) {
    // request in json string '[{"username":"abanwar","password":"123456","id":"1"}]';
    $post = json_decode($_REQUEST['request']);
	//print_r($post);
	if(is_array($post)){
	  $post = $post['0'];
	}
    
    $postArray = array();
    foreach($post as $key => $field){
        $postArray[$key] = $field;
    }
    $post = $postArray;
    $ID = $post['id'];
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
    $RightsID='9';
    $UserTypeID='6';
    $StatusID='1';
    session_start();
    $OrgID=$_SESSION['OrgID'];

    $con=connectToDB(); //connect to the DB

    $result = mysql_query("call createEnquiry('".$OrgID."','".$CustomerTitle."','".$CustomerName."','".$CustomerSurname."','".$CustomerMiddleName."','".$DateOfBirth."','".$NHSNumber."','".$Gender."','".$Ethnicity."','".$Address1."','".$Address2."','".$PostCode."','".$City."','".$Landline."','".$ContactNo."','".$OtherDetails."','".$CareInfo."','".$OutcomesInfo."','".$SupportInfo."','".$MakeEnq."','".$RightsID."','".$AccessLevelID."','".$UserTypeID."','".$CreatedDateTime."','".$ModifyDateTime."','".$StatusID."')")or die(mysql_error());

    /*$result = mysql_query("insert into SCP_UserLogin(StatusID,CreatedDateTime,ModifyDateTime)values('1','".$CreatedDateTime."','".$ModifyDateTime."')")or die(mysql_error());
    $last_id=mysql_insert_id();


    $result = mysql_query("insert into SCP_UserAccess(RightsID,AccessLevelID,UserID,UserTypeID,CreatedDateTime,ModifyDateTime,StatusID)values('".$RightsID."','".$AccessLevelID."','".$last_id."','".$UserTypeID."','".$CreatedDateTime."','".$ModifyDateTime."','1')")or die(mysql_error());

    $result = mysql_query("insert into SCP_Customer(CustomerTitle,CustomerName,CustomerSurname,CustomerMiddleName,DateOfBirth,NHSNumber,Gender,Ethnicity,Address1,Address2,PostCode,City,Landline,ContactNo,OtherDetails,CareInfo,OutcomesInfo,SupportInfo,MakeEnq,UserID,StatusID,CreatedDateTime,ModifyDateTime)values('".$CustomerTitle."','".$CustomerName."','".$CustomerSurname."','".$CustomerMiddleName."','".$DateOfBirth."','".$NHSNumber."','".$Gender."','".$Ethnicity."','".$Address1."','".$Address2."','".$PostCode."','".$City."','".$Landline."','".$ContactNo."','".$OtherDetails."','".$CareInfo."','".$OutcomesInfo."','".$SupportInfo."','".$MakeEnq."','".$last_id."','1','".$CreatedDateTime."','".$ModifyDateTime."')")or die(mysql_error());
    $last_id_cm=mysql_insert_id();

    $result = mysql_query("insert into SCP_Enquiry(CustomerID,StatusID,CreatedDateTime,ModifyDateTime)values('".$last_id_cm."','1','".$CreatedDateTime."','".$ModifyDateTime."')")or die(mysql_error());
    */

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
    $rows = array();
    while($row = mysql_fetch_assoc($result)) {
        $rows[] = $row;
    }
    if($rows) {
        $data['responseData'] = $rows;
        $data['responseMessage'] = "All forms get successfully";
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

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// MAIN //////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

switch($ID) {
    case 1: loginWithUsername($post);
         break; 
	case 2: createEnquiry($post);
         break;
    case 10: loadAllOrgniserForms($post);
         break;     	             
    default: myError(); 
}

?>
