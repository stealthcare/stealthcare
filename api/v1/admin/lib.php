<?php
/*
*   Author: Soteris Demetriou
*   All rights reserved
*
*   lib.php : A library file including
*             helpful functions for CS.
*/

//////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// LIBRARY FUNCTIONS /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

/******************************************************************************************************************/

/*
* connectToDB() establishes a connection with a database
* PARAMETERS: $dbUsername->A user's name with access rights to the DB
*             $dbPassword->The password of the user
*             &dbDBname->The name of the Database
* RETURN VALUE: An integer which is the unique ID of the established connection.
*/
function connectToDB()
{
  global $dbUsername,$dbPassword,$dbDBname,$hostName ;

  $con = mysql_connect($hostName,$dbUsername,$dbPassword);
  if (!$con) die('Could not connect: ' . mysql_error());

  mysql_select_db($dbDBname , $con);
  return $con;
}

/******************************************************************************************************************/

/*
*  Displays a standardized error message
*/
function myError()
{
    $deviceType = $_SERVER['HTTP_DEVICETYPE'];
    $appVersion = $_SERVER['HTTP_APPVERSION'];
    $OSVersion = $_SERVER['HTTP_OSVERSION'];
    $browserVersion = $_SERVER['HTTP_BROWSERVERSION'];
    $data['ResponseData'] = "";
    $data['Message'] = "404 Not Found";
    $data['ResponseCode'] = "404";
    $data['Status'] = "Failed";
    $data['StatusCode'] = "0";
    $data['Request'] = 'deviceType:-'.$deviceType.'-appVersion:-'.$appVersion.'-OSVersion:-'.$OSVersion.'-browserVersion:-'.$browserVersion;
    $data['RequestJson'] = $_REQUEST['request'];
    print json_encode($data);
}

/******************************************************************************************************************/

/* 
*   ID=unknown
*   A function used as a response to an unknown ID
*   It displays a not found message
*   PARAMETERS: string->The name of the attribute not found, value->the value of the attribute not found
*/
function noSuch($string,$value)
{
   echo "No response found for " . $string ."=" . $value;
}

/******************************************************************************************************************/


?>
