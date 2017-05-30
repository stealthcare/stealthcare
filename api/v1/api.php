<?php

date_default_timezone_set("Asia/Kolkata");
require_once("Rest.inc.php");
require_once("../config.php");

class API extends REST {

    public $data = "";

    const DB_SERVER = DB_SERVER;
    const DB_USER = DB_USER;
    const DB_PASSWORD = DB_PASSWORD;
    const DB = DB;
    const img = img;
    const base_url = base_url;
    const URL = URL;

    private $db = NULL;

    public function __construct() {
        parent::__construct();    // Init parent contructor
        $this->dbConnect();     // Initiate Database connection   
    }

    /*
     *  Database connection 
     */

    private function dbConnect() {
        $this->db = mysql_connect(self::DB_SERVER, self::DB_USER, self::DB_PASSWORD);
        if ($this->db)
            mysql_select_db(self::DB, $this->db);

        if (!$this->db) {
            $dbError = array();
            $dbError['status_code'] = "0";
            $dbError['errorCode'] = "8";
            $this->response($this->json($dbError), 400);
        }
    }

    /*
     * Public method for access api.
     * This method dynmically call the method based on the query string
     *
     */

    public function processApi() {
        $func = strtolower(trim(str_replace("/", "", $_REQUEST['request'])));
        if ((int) method_exists($this, $func) > 0)
            $this->$func();
        else
            $this->response('', 404);    // If the method not exist with in this class, response would be "Page not found".
    }

    // ******************************* GET PLAN API *******************************
    private function editAdminload() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $success = false;

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $EmailID = $post['EmailID'];
            $UserName = $post['UserName'];
            $ProfilePhoto = $post['ProfilePhoto'];
            $DashboardLogo = $post['DashboardLogo'];
            $UserID = $_POST['UserID'];
            $ProfilePhotoData = explode('//', $ProfilePhoto);
            if ($ProfilePhotoData[0] != 'http:') {
                $ProfilePhoto = $this->createImage($ProfilePhoto, 'user'.$UserID);
            }
            $DashboardLogoData = explode('//', $DashboardLogo);
            if ($DashboardLogoData[0] != 'http:') {
                $DashboardLogo = $this->createImage($DashboardLogo, 'logo'.$UserID);
            }

            mysql_query("UPDATE `SCP_UserLogin` SET `EmailID`='$EmailID', `UserName`='$UserName', `ProfilePhoto`='$ProfilePhoto', `DashboardLogo`='$DashboardLogo' WHERE `UserID` = '$UserID'", $this->db);

            $sql = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE UserID='$UserID'", $this->db);

            $arr = mysql_fetch_array($sql, MYSQL_ASSOC);
            session_start();
            $_SESSION['UserName'] = $arr['UserName'];
            $_SESSION['EmailID'] = $arr['EmailID'];
            $_SESSION['ProfilePhoto'] = $arr['ProfilePhoto'];
            $_SESSION['DashboardLogo'] = $arr['DashboardLogo'];

            $success = true;
            $msg = "Update Profile Successfully";
        } else {
            $UserID = $_POST['UserID'];
            $sql = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE UserID='$UserID'", $this->db);

            $arr = mysql_fetch_array($sql, MYSQL_ASSOC);
            $success = true;
            $msg = "Update Profile Successfully";
        }

        if ($success) {            
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => $msg, 'response_code' => "200", 'response_data' => $arr,);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    private function createImage($photoData, $fileName) {
        $imageData = explode(';', $photoData);
        $imageData = explode(':', $imageData[0]);
        if($imageData[0] == 'data') {
            if($imageData[1] == 'image/png') {
                $data = str_replace('data:image/png;base64,', '', $photoData);
                $data = str_replace(' ', '+', $data);
                $data = base64_decode($data);
                $file = $_SERVER['DOCUMENT_ROOT'].'/stealthcare/uploads/'.$fileName . '.png';
                $Photo = self::img.$fileName . '.png';
            } elseif($imageData[1] == 'image/jpg') {
                $data = str_replace('data:image/jpg;base64,', '', $photoData);
                $data = str_replace(' ', '+', $data);
                $data = base64_decode($data);
                $file = $_SERVER['DOCUMENT_ROOT'].'/stealthcare/uploads/'.$fileName . '.jpg';
                $Photo = self::img.$fileName . '.jpg';
            } elseif($imageData[1] == 'image/jpeg') {
                $data = str_replace('data:image/jpeg;base64,', '', $photoData);
                $data = str_replace(' ', '+', $data);
                $data = base64_decode($data);
                $file = $_SERVER['DOCUMENT_ROOT'].'/stealthcare/uploads/'.$fileName . '.jpeg';
                $Photo = self::img.$fileName . '.jpeg';
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
            return $Photo;
        }
    }

    // ******************************* GET PLAN API *******************************
    private function updateAdminPassword() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $success = false;

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $oldpassword = $post['oldpassword'];
            $password = md5($post['password']);
            $UserID = $_POST['UserID'];

            $sql = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE UserID='$UserID'", $this->db);
            $arr = mysql_fetch_array($sql, MYSQL_ASSOC);
            if (md5($oldpassword) != $arr['Password']) {            
                $successdata = array('status_code' => "1", 'status' => "error", 'message' => 'Old password is wrong.', 'response_code' => "200", 'response_data' => $arr,);
                $this->response($this->json($successdata), 200);            
            }
            mysql_query("UPDATE `SCP_UserLogin` SET `Password`='$password' WHERE `UserID` = '$UserID'", $this->db);            
            $success = true;
            $msg = "Update Password Successfully";
        } 

        if ($success) {            
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => $msg, 'response_code' => "200", 'response_data' => $arr,);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* LOGIN API *******************************
    private function Login() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        
        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $username = $post['username'];
            $password = $post['password'];
        } else {
            $username = $_POST['username'];
            $password = $_POST['password'];
        }

        $success = true;

        // VALIDATION CHECK
        if (empty($username)) {
            $success = false;
            $error = array('status_code' => "0", 'message' => "Please enter username", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }

        // LOGIN VALIDATION CHECK ENDS
        if ($success) {
            // LOGIN
            $sql = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE UserName='$username' AND Password='" . md5($password) . "'", $this->db);
            //$arr = array();
            if (mysql_num_rows($sql) > 0) {
                while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                    $row['UserID'] = $rlt['UserID'];
                    $row['UserName'] = $rlt['UserName'];
                    $row['EmailID'] = $rlt['EmailID'];
                    $row['StatusID'] = $rlt['StatusID'];
                    $row['ProfilePhoto'] = $rlt['ProfilePhoto'];
                    $row['DashboardLogo'] = $rlt['DashboardLogo'];
                    $arr = $row;
                }
                $UserID = $arr['UserID'];

                if($arr['StatusID'] != '1') {
                    $successdata = array('status_code' => "1", 'status' => "error", 'message' => "Your account is disabled. Please contact your administrator", 'response_code' => "200", 'response_data' => $arr);
                    $this->response($this->json($successdata), 200);
                } 
                
                if ($UserID != 1) {
                    $Licenses = mysql_query("SELECT * FROM `SCP_Licenses` WHERE UserID='$UserID' AND StatusID='1'", $this->db);
                    $Licenses = mysql_fetch_array($Licenses, MYSQL_ASSOC);
                    if (empty($Licenses)) {
                        $success = false;
                        $error = array('status_code' => "0", 'status' => "error", 'message' => "Your license is disabled. Please contact your administrator", 'response_code' => "200", 'response_data' => $arr);
                        $this->response($this->json($error), 200);
                    }
                }
                
                $UserID = $arr['UserID'];
                $sql1 = mysql_query("SELECT * FROM `SCP_UserAccess` WHERE UserID='$UserID'", $this->db);

                if (!isset($_SESSION)) {
                    session_start();
                }
                $_SESSION['UserID'] = $arr['UserID'];
                $_SESSION['EmailID'] = $arr['EmailID'];
                $_SESSION['UserName'] = $arr['UserName'];   
                $_SESSION['ProfilePhoto'] = $arr['ProfilePhoto'];  
                $_SESSION['DashboardLogo'] = $arr['DashboardLogo'];                   
                $rlt1 = mysql_fetch_array($sql1, MYSQL_ASSOC);
                $UserTypeID = $rlt1['UserTypeID'];
                if($UserTypeID == 2) {
                    $careOrgSql = mysql_query("SELECT * FROM `SCP_CareOrg` WHERE UserID='$UserID'", $this->db);
                    $careOrgSql = mysql_fetch_array($careOrgSql, MYSQL_ASSOC);
                    $_SESSION['OrgID'] = $careOrgSql['OrgID'];
                    $_SESSION['AdminName'] = $careOrgSql['AdminName'];
                    $_SESSION['CareOrgProfilePhoto'] = $arr['ProfilePhoto'];  
                    $_SESSION['CareOrgDashboardLogo'] = $arr['DashboardLogo'];    
                } else {
                    $_SESSION['OrgID'] = '';
                    $_SESSION['AdminName'] = '';
                    $_SESSION['CareOrgProfilePhoto'] = '';  
                    $_SESSION['CareOrgDashboardLogo'] = '';
                }

                $UserTypeSql = mysql_query("SELECT * FROM `SCP_UserType` WHERE UserTypeID='$UserTypeID'", $this->db);
                $UserType = mysql_fetch_array($UserTypeSql, MYSQL_ASSOC);
                $_SESSION['UserAccess'] = $UserType['UserTypeName'];

                $successdata = array('status_code' => $UserTypeID, 'status' => "success", 'message' => "Login Successful", 'response_code' => "200", 'response_data' => $arr);
                $this->response($this->json($successdata), 200);
                
            } else {
                //if no user found
                $error = array('status_code' => "0", 'status' => "error", 'message' => "Wrong username and password!!!", 'response_code' => "200", 'response_data' => $arr);
                $this->response($this->json($error), 200);
            }
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    /*private function getFirstBlankLicenseID() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $sql = mysql_query("SELECT * FROM `SCP_Licenses` WHERE UserID IS NULL ORDER BY LicenseID ASC LIMIT 1", $this->db);

        $arr = mysql_fetch_array($sql, MYSQL_ASSOC);
        
        $successdata = array('status_code' => "3", 'status' => "success", 'message' => '', 'response_code' => "200", 'response_data' => $arr);
        $this->response($this->json($successdata), 200);         
    }*/
    
    // ******************************* CREATE ORGANIZER API *******************************
    private function createOrgsignUp() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        
        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $PlanID = $_POST['PlanID'];
            $email = $post['email'];
            $username = $post['username'];
            $password = md5($post['password']);
            @$Name = $post['name'];
            @$Address = $post['address'];
            @$PostCode = strtoupper($post['postcode1'].' '.$post['postcode2']);
            @$ContactNo = $post['phone'];
            @$ContactNo2 = $post['mobile'];
            @$FaxNo = $post['FaxNo'];
            @$WebSite = $post['WebSite'];
            @$OtherDetails = $post['OtherDetails'];
            @$Address2 = $post['address2'];
            @$CQCRegNo = $post['CQCRegNo'];
            @$CQCLocNo = $post['CQCLocNo'];
            @$AdminName = $post['AdminName'];
            @$City = $post['City'];
        } else {
            $username = $_POST['username'];
            $password = md5($_POST['password']);
            $Name = $_POST['name'];
            $Address = $_POST['address'];
            $ContactNo = $_POST['phone'];
            $ContactNo2 = $_POST['mobile'];
            $FaxNo = $_POST['FaxNo'];
            $WebSite = $_POST['WebSite'];
            $OtherDetails = $_POST['OtherDetails'];
        }
        $CreatedDateTime = date('Y-m-d H:i:s');
        $ModifyDateTime = date('Y-m-d H:i:s');

        $success = true;
        //print_r($_POST);
        // VALIDATION CHECK
        if (empty($username)) {
            $success = false;
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Please enter username", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
        // LOGIN VALIDATION CHECK ENDS
        if ($success) {
            // LOGIN
            $sql_insert = mysql_query("INSERT INTO `SCP_UserLogin` (`EmailID`, `UserName`, `Password`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$email', '$username', '$password', '1', '$CreatedDateTime', '$ModifyDateTime')", $this->db);

            $last_insert_id = mysql_insert_id();

            $sql_insert = mysql_query("INSERT INTO `SCP_CareOrg` (`Name`, `PlanID`, `Address`, `PostCode`, `ContactNo`, `ContactNo2`, `FaxNo`, `WebSite`, `UserID`, `OtherDetails`, `Address2`, `CQCRegNo`, `CQCLocNo`, `AdminName`, `City`, `CreatedDateTime`, `ModifyDateTime`, `StatusID`) VALUES ('$Name', '$PlanID', '$Address', '$PostCode', '$ContactNo', '$ContactNo2', '$FaxNo', '$WebSite', '$last_insert_id', '$OtherDetails', '$Address2', '$CQCRegNo', '$CQCLocNo', '$AdminName', '$City', '$CreatedDateTime', '$ModifyDateTime', '1')", $this->db);

            $OrgID = mysql_insert_id();

            $sql_insert = mysql_query("INSERT INTO `SCP_UserAccess` (`RightsID`, `AccessLevelID`, `UserID`, `UserTypeID`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('2', '2', '$last_insert_id', '2', '1', '$CreatedDateTime', '$ModifyDateTime')", $this->db);
            
            $arr[] = $last_insert_id;

            $Licenses = mysql_query("SELECT * FROM `SCP_Licenses` WHERE UserID IS NULL AND StatusID='1' ORDER BY LicenseID ASC LIMIT 1", $this->db);
            $Licenses = mysql_fetch_array($Licenses, MYSQL_ASSOC);
            $LicenseID = $Licenses['LicenseID'];
            mysql_query("UPDATE `SCP_Licenses` SET `OrgID`='$OrgID', `UserID`='$last_insert_id', `ModifyDateTime`='$ModifyDateTime' WHERE `LicenseID` = '$LicenseID'", $this->db);
            //if no user found
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Care Organizer Created Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* Care Organizer API *******************************
    private function CareOrga() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        
        $success = true;

        if ($success) {
            // LOGIN
            $sql = mysql_query("SELECT * FROM SCP_UserLogin LEFT JOIN SCP_UserAccess ON SCP_UserAccess.UserID=SCP_UserLogin.UserID WHERE SCP_UserAccess.UserTypeID='2'", $this->db);            

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row['UserID'] = $rlt['UserID'];
                $row['UserName'] = $rlt['UserName'];
                $row['EmailID'] = $rlt['EmailID'];
                $row['StatusID'] = $rlt['StatusID'];
                $UserID = $rlt['UserID'];
                $CareOrg = mysql_query("SELECT * FROM `SCP_CareOrg` WHERE UserID='$UserID'", $this->db);
                $CareOrg = mysql_fetch_array($CareOrg, MYSQL_ASSOC);
                $row['OrgID'] = $CareOrg['OrgID'];
                if($CareOrg['StatusID'] == 1) {
                    $row['Status'] = 'Active';
                } else {
                    $row['Status'] = 'Deactive';
                }
                $arr[] = $row;
            }
            //print_r($arr);
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => "Care Organizers Get Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* Change Status License API *******************************
    private function changeStatusCareOrg() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $UserID = $post['UserID'];
            $StatusID = $post['StatusID'];
        } else {
            $UserID = $_POST['UserID'];
            $StatusID = $_POST['StatusID'];
        }

        mysql_query("UPDATE `SCP_UserLogin` SET `StatusID`='$StatusID' WHERE `UserID` = '$UserID'", $this->db);
        mysql_query("UPDATE `SCP_CareOrg` SET `StatusID`='$StatusID' WHERE `UserID` = '$UserID'", $this->db);
        mysql_query("UPDATE `SCP_UserAccess` SET `StatusID`='$StatusID' WHERE `UserID` = '$UserID'", $this->db);

        $success = true;

        if ($success) {
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Changed Organization Status Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* GET PLAN API *******************************
    private function getUpdateCareOrgByID() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $success = false;

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $UserID = $_POST['UserID'];
            $PlanID = $_POST['PlanID'];
            $email = $post['EmailID'];
            $username = $post['UserName'];
            $Name = $post['Name'];
            $Address = $post['Address'];
            $PostCode = strtoupper($post['postcode1'].' '.$post['postcode2']);
            $ContactNo = $post['ContactNo'];
            $ContactNo2 = $post['ContactNo2'];
            $FaxNo = $post['FaxNo'];
            $WebSite = $post['WebSite'];
            $OtherDetails = $post['OtherDetails'];
            $CQCRegNo = $post['CQCRegNo'];
            $CQCLocNo = $post['CQCLocNo'];
            $Address2 = $post['Address2'];
            $City = $post['City'];
            $AdminName = $post['AdminName'];
            $StatusID = $_POST['StatusID'];
            $ModifyDateTime = date('Y-m-d H:i:s');

            mysql_query("UPDATE `SCP_UserLogin` SET `EmailID`='$email', `UserName`='$username', `ModifyDateTime`='$ModifyDateTime', WHERE `UserID` = '$UserID'", $this->db);

            mysql_query("UPDATE `SCP_CareOrg` SET `Name`='$Name', `PlanID`='$PlanID', `Address`='$Address', `PostCode`='$PostCode', `ContactNo`='$ContactNo', `ContactNo2`='$ContactNo2', `FaxNo`='$FaxNo', `WebSite`='$WebSite', `OtherDetails`='$OtherDetails', `CQCRegNo`='$CQCRegNo', `CQCLocNo`='$CQCLocNo', `Address2`='$Address2', `City`='$City', `AdminName`='$AdminName', `ModifyDateTime`='$ModifyDateTime', `StatusID`='$StatusID' WHERE `UserID` = '$UserID'", $this->db);

            $sql = mysql_query("SELECT * FROM SCP_UserLogin LEFT JOIN SCP_CareOrg ON SCP_CareOrg.UserID=SCP_UserLogin.UserID WHERE SCP_UserLogin.UserID='$UserID'", $this->db); 

            $arr = mysql_fetch_array($sql, MYSQL_ASSOC);
            $postcode = explode(' ', $arr['PostCode']);
            @$arr['postcode1'] = $postcode[0];
            @$arr['postcode2'] = $postcode[1];
            $success = true;
            $msg = "Update Care Organizer Successfully";
        } else {
            $UserID = $_POST['UserID'];
            $sql = mysql_query("SELECT * FROM SCP_UserLogin LEFT JOIN SCP_CareOrg ON SCP_CareOrg.UserID=SCP_UserLogin.UserID WHERE SCP_UserLogin.UserID='$UserID'", $this->db);

            $arr = mysql_fetch_array($sql, MYSQL_ASSOC);
            $postcode = explode(' ', $arr['PostCode']);
            @$arr['postcode1'] = $postcode[0];
            @$arr['postcode2'] = $postcode[1]; 
            $success = true;
            $msg = "Get Care Organizers Successfully";
        }

        if ($success) {

            $sql = mysql_query("SELECT * FROM `SCP_Status`", $this->db);

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row['StatusID'] = $rlt['StatusID'];
                $row['StatusName'] = $rlt['StatusName'];
                $status[] = $row;
            }

            $sql1 = mysql_query("SELECT * FROM `SCP_LicensesPlan` WHERE StatusID='1'", $this->db);

            while ($rlt1 = mysql_fetch_array($sql1, MYSQL_ASSOC)) {
                $row1['PlanID'] = $rlt1['PlanID'];
                $row1['PlanName'] = $rlt1['PlanName'];
                $LicensesPlan[] = $row1;
            }
            
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => $msg, 'response_code' => "200", 'response_data' => $arr, 'status_data' => $status, 'licensesplan_data' => $LicensesPlan);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* SESSION API *******************************
    private function checkCareOrgEmailOrUsername() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        if (!isset($_SESSION)) {
            session_start();
        }
        $status = false;
        if(@$_POST['username']) {
            $UserName = $_POST['username'];
            $CareOrg = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE UserName='$UserName'", $this->db);
            $CareOrg = mysql_fetch_array($CareOrg, MYSQL_ASSOC);
            if($CareOrg) {
                $status = true;
                if($CareOrg['UserID'] == $_POST['UserID']) {
                    $status = false;
                }
            }
        } else {
            $EmailID = $_POST['email'];
            $CareOrg = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE EmailID='$EmailID'", $this->db);
            $CareOrg = mysql_fetch_array($CareOrg, MYSQL_ASSOC);
            if($CareOrg) {
                $status = true;
                if($CareOrg['UserID'] == $_POST['UserID']) {
                    $status = false;
                }
            }
        }
        
        if($status) {
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => "Care Organizers Get Successfully", 'response_code' => "200");
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200");
            $this->response($this->json($error), 200);
        }
    }
	
	private function checkStaffEmailOrUsername(){
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        if (!isset($_SESSION)) {
            session_start();
        }
        $status = false;
        if(@$_POST['username']) {
            $UserName = $_POST['username'];
            $CareOrg = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE UserName='$UserName'", $this->db);
            $CareOrg = mysql_fetch_array($CareOrg, MYSQL_ASSOC);
            if($CareOrg) {
                $status = true;
                if($CareOrg['UserID'] == $_POST['UserID']) {
                    $status = false;
                }
            }
        } else {
            $EmailID = $_POST['email'];
            $CareOrg = mysql_query("SELECT * FROM `SCP_UserLogin` WHERE EmailID='$EmailID'", $this->db);
            $CareOrg = mysql_fetch_array($CareOrg, MYSQL_ASSOC);
            if($CareOrg) {
                $status = true;
                if($CareOrg['UserID'] == $_POST['UserID']) {
                    $status = false;
                }
            }
        }
        
        if($status) {
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => "Care Organizers Get Successfully", 'response_code' => "200");
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200");
            $this->response($this->json($error), 200);
        }
    }
	

    // ******************************* Plans API *******************************
    private function LicensePlans() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        
        $success = true;

        if ($success) {
            // LOGIN
            $sql = mysql_query("SELECT * FROM `SCP_LicensesPlan`", $this->db);

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row['PlanID'] = $rlt['PlanID'];
                $row['PlanName'] = $rlt['PlanName'];
                $row['MaxQty'] = $rlt['MaxQty'];
                $row['Price'] = $rlt['Price'];
                $row['StatusID'] = $rlt['StatusID'];
                if($rlt['StatusID'] == 1) {
                    $row['Status'] = 'Active';
                } else {
                    $row['Status'] = 'Deactive';
                }
                $arr[] = $row;
            }
            
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => "Plans Get Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* GET PLAN API *******************************
    private function getUpdatePlanByID() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $success = false;

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $PlanName = $post['PlanName'];
            $MinQty = $post['MinQty'];
            $MaxQty = $post['MaxQty'];
            $Price = $post['Price'];
            $StatusID = $_POST['StatusID'];
            $PlanID = $_POST['PlanID'];

            $sql = mysql_query("SELECT * FROM `SCP_LicensesPlan` WHERE PlanName='$PlanName' AND MinQty='$MinQty' AND MaxQty='$MaxQty'AND Price='$Price'", $this->db);

            $rlt = mysql_fetch_array($sql, MYSQL_ASSOC);
            if(!empty($rlt)) {
                if($rlt['PlanID'] != $PlanID) {
                    $successdata = array('status_code' => "0", 'status' => "error", 'message' => "This plan already exists", 'response_code' => "200", 'response_data' => $arr);
                    $this->response($this->json($successdata), 200);
                } 
            }

            mysql_query("UPDATE `SCP_LicensesPlan` SET `PlanName`='$PlanName', `MinQty`='$MinQty', `MaxQty`='$MaxQty', `Price`='$Price', `StatusID`='$StatusID' WHERE `PlanID` = '$PlanID'", $this->db);

            $sql = mysql_query("SELECT * FROM `SCP_LicensesPlan` WHERE PlanID='$PlanID'", $this->db);

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row['PlanID'] = $rlt['PlanID'];
                $row['PlanName'] = $rlt['PlanName'];
                $row['MinQty'] = $rlt['MinQty'];
                $row['MaxQty'] = $rlt['MaxQty'];
                $row['Price'] = $rlt['Price'];
                $row['StatusID'] = $rlt['StatusID'];
                $arr = $row;
            }
            $success = true;
            $msg = "Update Plan Successfully";
        } else {
            $PlanID = $_POST['PlanID'];
            $sql = mysql_query("SELECT * FROM `SCP_LicensesPlan` WHERE PlanID='$PlanID'", $this->db);

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row['PlanID'] = $rlt['PlanID'];
                $row['PlanName'] = $rlt['PlanName'];
                $row['MinQty'] = $rlt['MinQty'];
                $row['MaxQty'] = $rlt['MaxQty'];
                $row['Price'] = $rlt['Price'];
                $row['StatusID'] = $rlt['StatusID'];
                $arr = $row;
            }
            $success = true;
            $msg = "Plan Get Successfully";
        }

        if ($success) {

            $sql = mysql_query("SELECT * FROM `SCP_Status`", $this->db);

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row['StatusID'] = $rlt['StatusID'];
                $row['StatusName'] = $rlt['StatusName'];
                $status[] = $row;
            }
            
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => $msg, 'response_code' => "200", 'response_data' => $arr, 'status_data' => $status);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* CREATE PLAN API *******************************
    private function createPlan() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        //print_r($_POST); die();
        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $PlanName = $post['PlanName'];
            $MinQty = $post['MinQty'];
            $MaxQty = $post['MaxQty'];
            $Price = $post['Price'];
        } else {
            $PlanName = $_POST['PlanName'];
            $MinQty = $_POST['MinQty'];
            $MaxQty = $post['MaxQty'];
            $Price = $post['Price'];
        }

        $CreatedDateTime = date('Y-m-d H:i:s');
        $ModifyDateTime = date('Y-m-d H:i:s');

        $success = true;
        //print_r($_POST);
        
        // LOGIN VALIDATION CHECK ENDS
        if ($success) {
            $sql = mysql_query("SELECT * FROM `SCP_LicensesPlan` WHERE PlanName='$PlanName' AND MinQty='$MinQty' AND MaxQty='$MaxQty'AND Price='$Price'", $this->db);

            $rlt = mysql_fetch_array($sql, MYSQL_ASSOC);
            if(!empty($rlt)) {
                $successdata = array('status_code' => "0", 'status' => "error", 'message' => "This plan already exists", 'response_code' => "200", 'response_data' => $arr);
                $this->response($this->json($successdata), 200);
            } else {
                $sql_insert = mysql_query("INSERT INTO `SCP_LicensesPlan` (`PlanName`, `MinQty`, `MaxQty`, `Price`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$PlanName', '$MinQty', '$MaxQty', '$Price', '1', '$CreatedDateTime', '$ModifyDateTime')", $this->db);

                $last_insert_id = mysql_insert_id();
                
                $arr[] = $last_insert_id;
                //if no user found
                $error = array('status_code' => "1", 'status' => "success", 'message' => "Create Plan Successful", 'response_code' => "200", 'response_data' => $arr);
                $this->response($this->json($error), 200);
            }
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* DELETE PLAN API *******************************
    private function deletePlan() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $PlanID = $post['PlanID'];
        } else {
            $PlanID = $_POST['PlanID'];
        }

        $sql = mysql_query("DELETE FROM `SCP_LicensesPlan` WHERE PlanID='$PlanID'", $this->db);

        if($sql) {
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Delete Plan Successful", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* DELETE PLAN API *******************************
    private function changeStatusPlan() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $PlanID = $post['PlanID'];
            $StatusID = $post['StatusID'];
        } else {
            $PlanID = $_POST['PlanID'];
            $StatusID = $_POST['StatusID'];
        }

        $sql = mysql_query("UPDATE `SCP_LicensesPlan` SET `StatusID`='$StatusID' WHERE `PlanID` = '$PlanID'", $this->db);

        if($sql) {
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Change Plan Status Successful", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* CREATE PLAN API *******************************
    private function createLicense() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        //print_r($_POST); die();
        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $noOfLicense = $post['noOfLicense'];
        } else {
            $noOfLicense = $_POST['noOfLicense'];
        }
        $CreatedDateTime = date('Y-m-d H:i:s');
        $ModifyDateTime = date('Y-m-d H:i:s');
        if($noOfLicense != '0') {
            for ($i=1; $i <= $noOfLicense; $i++) {  
                $currentTimeStamp = strtotime(date('Y-m-d H:i:s'));    
                $LicenseKey = strtoupper(md5(microtime().$currentTimeStamp.$i.rand()));
                $sql_insert = mysql_query("INSERT INTO `SCP_Licenses` (`LicenseKey`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$LicenseKey', '1', '$CreatedDateTime', '$ModifyDateTime')", $this->db);
                $arr[] = '';
            }   
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Licenses Created Successful", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* Change Status License API *******************************
    private function changeStatusLicense() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $LicenseID = $post['LicenseID'];
            $StatusID = $post['StatusID'];
        } else {
            $LicenseID = $_POST['LicenseID'];
            $StatusID = $_POST['StatusID'];
        }

        $sql = mysql_query("UPDATE `SCP_Licenses` SET `StatusID`='$StatusID' WHERE `LicenseID` = '$LicenseID'", $this->db);

        if($sql) {
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Changed License Status Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* GET License API *******************************
    private function getUpdateLicenseByID() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $success = false;

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $StatusID = $_POST['StatusID'];
            $LicenseID = $_POST['LicenseID'];
            mysql_query("UPDATE `SCP_Licenses` SET `StatusID`='$StatusID' WHERE `LicenseID` = '$LicenseID'", $this->db);

            $sql = mysql_query("SELECT * FROM `SCP_Licenses` WHERE LicenseID='$LicenseID'", $this->db);

            $arr = mysql_fetch_array($sql, MYSQL_ASSOC);       
            $success = true;
            $msg = "Update License Successfully";
        } else {
            $LicenseID = $_POST['LicenseID'];
            $sql = mysql_query("SELECT * FROM `SCP_Licenses` WHERE LicenseID='$LicenseID'", $this->db);

            $arr = mysql_fetch_array($sql, MYSQL_ASSOC);                
            $success = true;
            $msg = "License Get Successfully";
        }

        if ($success) {

            $sql = mysql_query("SELECT * FROM `SCP_Status`", $this->db);

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row['StatusID'] = $rlt['StatusID'];
                $row['StatusName'] = $rlt['StatusName'];
                $status[] = $row;
            }
            
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => $msg, 'response_code' => "200", 'response_data' => $arr, 'status_data' => $status);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* DELETE PLAN API *******************************
    private function deleteLicense() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }

        $arr = array();
        if(@$_POST['reqparams']) {
            $post = $_POST['reqparams'];
            $LicenseID = $post['LicenseID'];
        } else {
            $LicenseID = $_POST['LicenseID'];
        }

        $sql = mysql_query("DELETE FROM `SCP_Licenses` WHERE LicenseID='$LicenseID'", $this->db);

        if($sql) {
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Delete License Successful", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* Plans API *******************************
    private function Licenses() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        
        $success = true;

        if ($success) {
            $sql = mysql_query("SELECT SCP_Licenses.*, SCP_UserLogin.UserName, SCP_CareOrg.Name FROM SCP_Licenses LEFT JOIN SCP_UserLogin ON SCP_UserLogin.UserID=SCP_Licenses.UserID LEFT JOIN SCP_CareOrg ON SCP_CareOrg.OrgID=SCP_Licenses.OrgID", $this->db);

            while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
                $row = $rlt;
                if($rlt['StatusID'] == 1) {
                    $row['Status'] = 'Active';
                } else {
                    $row['Status'] = 'Deactive';
                }
                $arr[] = $row;
            }
            
            $successdata = array('status_code' => "1", 'status' => "success", 'message' => "Licenses Get Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($successdata), 200);            
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "Server Error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    private function loadSelectBoxData() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $sql = mysql_query("SELECT * FROM `SCP_Status`", $this->db);

        while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
            $row['StatusID'] = $rlt['StatusID'];
            $row['StatusName'] = $rlt['StatusName'];
            $status[] = $row;
        }

        $sql1 = mysql_query("SELECT * FROM `SCP_LicensesPlan` WHERE StatusID='1'", $this->db);

        while ($rlt1 = mysql_fetch_array($sql1, MYSQL_ASSOC)) {
            $row1['PlanID'] = $rlt1['PlanID'];
            $row1['PlanName'] = $rlt1['PlanName'];
            $LicensesPlan[] = $row1;
        }
        
        $successdata = array('status_code' => "3", 'status' => "success", 'message' => '', 'response_code' => "200", 'status_data' => $status, 'licensesplan_data' => $LicensesPlan);
        $this->response($this->json($successdata), 200);         
    }

    // ******************************* SESSION API *******************************
    private function updateSessionByOrgID() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        if (!isset($_SESSION)) {
            session_start();
        }
        $OrgID = $_POST['OrgID'];
        $sql = mysql_query("SELECT * FROM SCP_UserLogin LEFT JOIN SCP_CareOrg ON SCP_CareOrg.UserID=SCP_UserLogin.UserID WHERE SCP_CareOrg.OrgID='$OrgID'", $this->db);            

        $row = mysql_fetch_array($sql, MYSQL_ASSOC);
        $_SESSION["OrgID"] = $row["OrgID"];
        $_SESSION["AdminName"] = $row["AdminName"];
        $_SESSION["CareOrgProfilePhoto"] = $row["ProfilePhoto"];
        $_SESSION["CareOrgDashboardLogo"] = $row["DashboardLogo"];
        $this->response($this->json($_SESSION), 200);
    }

    // ******************************* SESSION API *******************************
    private function Session() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        if (!isset($_SESSION)) {
            session_start();
        }
        $session = $_SESSION;
        $response["UserID"] = $session['UserID'];
        $response["EmailID"] = $session['EmailID'];
        $response["UserName"] = $session['UserName'];
        $response["UserAccess"] = $session['UserAccess'];
        $response["ProfilePhoto"] = $session['ProfilePhoto'];
        $response["DashboardLogo"] = $session['DashboardLogo'];
        $response["OrgID"] = $session['OrgID'];
        $response["AdminName"] = $session['AdminName'];
        $response["CareOrgProfilePhoto"] = $session['CareOrgProfilePhoto'];
        $response["CareOrgDashboardLogo"] = $session['CareOrgDashboardLogo'];
        $this->response($this->json($response), 200);
    }

    // ******************************* LOGOUT API *******************************
    private function Logout() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $this->destroySession();
        $successdata = array('status_code' => "1", 'status' => "success", 'message' => "Logged out successfully", 'response_code' => "200");
        $this->response($this->json($successdata), 200);
    }

    public function destroySession(){
        if (!isset($_SESSION)) {
        session_start();
        }
        if(isSet($_SESSION['UserID']))
        {
            unset($_SESSION['UserID']);
            unset($_SESSION['UserName']);
            unset($_SESSION['EmailID']);
            unset($_SESSION['UserAccess']);
            unset($_SESSION['ProfilePhoto']);
            unset($_SESSION['DashboardLogo']);
            unset($_SESSION['OrgID']);
            unset($_SESSION['AdminName']);
            unset($_SESSION['CareOrgProfilePhoto']);
            unset($_SESSION['CareOrgDashboardLogo']);
            $info='info';
            if(isSet($_COOKIE[$info]))
            {
                setcookie ($info, '', time() - $cookie_time);
            }
            $msg="Logged Out Successfully...";
        }
        else
        {
            $msg = "Not logged in...";
        }
        return $msg;
    }
    
    // ******************************* SEND MAIL FUNCTION *******************************
    function sendEmail($subject,$to,$html){
        $from = "anil.banwar@izisstechnology.com";
        
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=iso-8859-1" . "\r\n";
        $headers .= "From:" .  $from;
        
        //$NewMessage = '<p>'.$name.' '.$surname.' reported '.$videoname.' for '.$report.' content<p>';
        $url = "http://bigbobsmeats.ca/mail_service/mail.php";
        $data = array(
            'html' => $html,
            'toemail' => $to,
            'fromemail' => $from,
            'subject' => $subject
        );
        
        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_HEADER, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        
        $sendmail = curl_exec($curl);	
        $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);	
        curl_close($curl);           
    }

    // ******************************* CREATE FORM API *******************************
    private function loadAllForms() {
        if ($this->get_request_method() != "GET") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $sql = mysql_query("SELECT * FROM `SCP_FormBuilder` WHERE UserTypeID='4'", $this->db);
        $assessor = array();
        while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
            $assessor[] = $rlt;
        } 

        $sql = mysql_query("SELECT * FROM `SCP_FormBuilder` WHERE UserTypeID='5'", $this->db);
        $careworker = array();
        while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
            $careworker[] = $rlt;
        }            
        $successdata = array('status_code' => "1", 'status' => "success", 'message' => '', 'response_code' => "200", 'response_data' => '', 'assessor' => $assessor, 'careworker' => $careworker);
        $this->response($this->json($successdata), 200);         
    }

    private function saveForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $title = '';
        //print_r(json_decode($_POST['FormDataJson'])); die();
        $arrayData = json_decode($_POST['FormDataJson']);
        foreach ($arrayData as $key => $value) {
            if($value->component == 'header') {
                $title = $value->label;
            }
        }
        $arr = array();
        $FormDataID = strtoupper('FORM'.strtotime(date('d-m-Y H:i:s'))); 
        $FormName = $title; 
        $FormDataJson = $_POST['FormDataJson']; 
        $FormDataJsonValue = $_POST['FormDataJsonValue'];
        $UserTypeID = $_POST['UserTypeID'];
        $CreatedDateTime = date('Y-m-d H:i:s');
        $ModifyDateTime = date('Y-m-d H:i:s');
        if(!empty($title)) { 
            $sql_insert = mysql_query("INSERT INTO `SCP_FormBuilder` (`FormDataID`, `FormName`, `FormDataJson`, `FormDataJsonValue`, `UserID`, `UserTypeID`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$FormDataID', '$FormName', '$FormDataJson', '$FormDataJsonValue', '1', '$UserTypeID', '1', '$CreatedDateTime', '$ModifyDateTime')", $this->db);
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Form Created Successfully", 'response_code' => "200", 'response_data' => '');
        } else {
            $error = array('status_code' => "0", 'status' => "success", 'message' => "Form heading is not blank.", 'response_code' => "200", 'response_data' => '');
        }
        $this->response($this->json($error), 200);
    }

    private function duplicateForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $FormID = $_POST['FormID']; 
        $sql = mysql_query("SELECT * FROM `SCP_FormBuilder` WHERE `FormID` = '$FormID'", $this->db);
        $row = mysql_fetch_array($sql, MYSQL_ASSOC);
        //print_r($row); die();
        $FormDataID = strtoupper('FORM'.strtotime(date('d-m-Y H:i:s'))); 
        $FormName = $row['FormName']; 
        $FormDataJson = $row['FormDataJson']; 
        $FormDataJsonValue = $row['FormDataJsonValue'];
        $UserTypeID = $row['UserTypeID'];
        $CreatedDateTime = date('Y-m-d H:i:s');
        $ModifyDateTime = date('Y-m-d H:i:s');
        $sql_insert = mysql_query("INSERT INTO `SCP_FormBuilder` (`FormDataID`, `FormName`, `FormDataJson`, `FormDataJsonValue`, `UserID`, `UserTypeID`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$FormDataID', '$FormName', '$FormDataJson', '$FormDataJsonValue', '1', '$UserTypeID', '1', '$CreatedDateTime', '$ModifyDateTime')", $this->db);
        $error = array('status_code' => "1", 'status' => "success", 'message' => "Form Created Successfully", 'response_code' => "200", 'response_data' => '');
        $this->response($this->json($error), 200);
    }

    // ******************************* UPDATE FORM API *******************************
    private function updateForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $title = '';
        //print_r(json_decode($_POST['FormDataJson'])); die();
        $arrayData = json_decode($_POST['FormDataJson']);
        foreach ($arrayData as $key => $value) {
            if($value->component == 'header') {
                $title = $value->label;
            }
        }
        $arr = array();
        $FormName = $title; 
        $FormDataJson = $_POST['FormDataJson'];
        $FormID = $_POST['FormID'];
        $ModifyDateTime = date('Y-m-d H:i:s');
        if(!empty($title)) { 
            $sql = mysql_query("UPDATE `SCP_FormBuilder` SET `FormName`='$FormName', `FormDataJson`='$FormDataJson', `ModifyDateTime`='$ModifyDateTime' WHERE `FormID` = '$FormID'", $this->db);
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Form Updated Successfully", 'response_code' => "200", 'response_data' => '');
        } else {
            $error = array('status_code' => "0", 'status' => "success", 'message' => "Form heading is not blank.", 'response_code' => "200", 'response_data' => '');
        }
        $this->response($this->json($error), 200);
    }

    // ******************************* DELETE Document API *******************************
    private function deleteDocument() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }

        $arr = array();
        $FormID = $_POST['FormID'];

        $sql = mysql_query("DELETE FROM `SCP_FormBuilder` WHERE FormID='$FormID'", $this->db);

        if($sql) {
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Document Deleted Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    // ******************************* GET FORM BY ID API *******************************
    private function getForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        if (!isset($_SESSION)) {
            session_start();
        }
        $FormID = $_POST['FormID'];
        $sql = mysql_query("SELECT * FROM SCP_FormBuilder WHERE FormID='$FormID'", $this->db);
        $row = mysql_fetch_array($sql, MYSQL_ASSOC);
        if($row) {
            $status = "success";
        } else {
            $status = "fail";
        }
        $error = array('status_code' => "1", 'status' => $status, 'message' => "Form Get Successfully", 'response_code' => "200", 'response_data' => $row["FormDataJson"]);
        $this->response($this->json($error), 200);
    }

    // ******************************* CREATE PLAN API *******************************
    private function insertData() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        //print_r($_POST); die();
        $arr = array();
        $Data = $_POST['Data']; 
        $sql_insert = mysql_query("INSERT INTO `SCP_Test` (`Data`) VALUES ('$Data')", $this->db);
        $last_insert_id = mysql_insert_id();
        $sql = mysql_query("SELECT * FROM `SCP_Test` WHERE ID='$last_insert_id'", $this->db);
        $arr = mysql_fetch_array($sql, MYSQL_ASSOC);
        $error = array('status_code' => "1", 'status' => "success", 'message' => "Data Inserted Successfully", 'response_code' => "200", 'response_data' => $arr);
        $this->response($this->json($error), 200);
    }


    ///////////////////////////*****************************************************///////////////////////////////////************************/////////////////////////////////////////Orgnization Panel Code Area***************************************///////////*******************/////////////////////////////////////**************////////////*************************//////////////////////////////
    private function loadAllFormsByOrgID() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $OrgID = $_POST['OrgID']; 
        $sql = mysql_query("SELECT * FROM `SCP_FormBuilder` WHERE UserTypeID='4' ", $this->db);
        $assessorallForms = array();
        while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
            $assessorallForms[] = $rlt;
        } 

        $sql = mysql_query("SELECT * FROM `SCP_OrgFormBuilder` WHERE UserTypeID='4' AND OrgID='$OrgID' ", $this->db);
        $assessorOrgForms = array();
        while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
            $assessorOrgForms[] = $rlt;
        } 
        $filterAllForms = array();
        foreach ($assessorallForms as $key => $value) {
            if(!$this->in_array_r($value['FormDataID'], $assessorOrgForms)) {
                $array['FormID'] = $value['FormID'];
                $array['FormDataID'] = $value['FormDataID'];
                $array['FormName'] = $value['FormName'];
                $array['FormDataJson'] = $value['FormDataJson'];
                $array['FormDataJsonValue'] = $value['FormDataJsonValue'];
                $array['UserID'] = $value['UserID'];
                $array['StatusID'] = $value['StatusID'];
                $array['FromType'] = '2';
                $array['UserTypeID'] = $value['UserTypeID'];
                $array['CreatedDateTime'] = $value['CreatedDateTime'];
                $array['ModifyDateTime'] = $value['ModifyDateTime'];
                $filterAllForms[] = $array;
            }
        }
        $assessor = array_merge($assessorOrgForms,$filterAllForms);
        //echo '<pre>'; print_r($assessor); 

        $sql = mysql_query("SELECT * FROM `SCP_FormBuilder` WHERE UserTypeID='5' ", $this->db);
        $careworkerallForms = array();
        while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
            $careworkerallForms[] = $rlt;
        }     

        $sql = mysql_query("SELECT * FROM `SCP_OrgFormBuilder` WHERE UserTypeID='5' AND OrgID='$OrgID' ", $this->db);
        $careworkerOrgForms = array();
        while ($rlt = mysql_fetch_array($sql, MYSQL_ASSOC)) {
            $careworkerOrgForms[] = $rlt;
        } 
        $carefilterAllForms = array();
        foreach ($careworkerallForms as $key => $value) {
            if(!$this->in_array_r($value['FormDataID'], $careworkerOrgForms)) {
                $array['FormID'] = $value['FormID'];
                $array['FormDataID'] = $value['FormDataID'];
                $array['FormName'] = $value['FormName'];
                $array['FormDataJson'] = $value['FormDataJson'];
                $array['FormDataJsonValue'] = $value['FormDataJsonValue'];
                $array['UserID'] = $value['UserID'];
                $array['StatusID'] = $value['StatusID'];
                $array['FromType'] = '2';
                $array['UserTypeID'] = $value['UserTypeID'];
                $array['CreatedDateTime'] = $value['CreatedDateTime'];
                $array['ModifyDateTime'] = $value['ModifyDateTime'];
                $carefilterAllForms[] = $array;
            }
        }
        $careworker = array_merge($careworkerOrgForms,$carefilterAllForms);  
        //echo '<pre>'; print_r($careworker); die();     
        $successdata = array('status_code' => "1", 'status' => "success", 'message' => '', 'response_code' => "200", 'response_data' => '', 'assessor' => $assessor, 'careworker' => $careworker);
        $this->response($this->json($successdata), 200);         
    }

    private function saveOrgForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $title = '';
        //print_r(json_decode($_POST['FormDataJson'])); die();
        $arrayData = json_decode($_POST['FormDataJson']);
        foreach ($arrayData as $key => $value) {
            if($value->component == 'header') {
                $title = $value->label;
            }
        }
        $arr = array();
        $FormDataID = strtoupper('FORM'.strtotime(date('d-m-Y H:i:s'))); 
        $FormName = $title; 
        $OrgID = $_POST['OrgID']; 
        $FormDataJson = $_POST['FormDataJson']; 
        $FormDataJsonValue = $_POST['FormDataJsonValue'];
        $UserTypeID = $_POST['UserTypeID'];
        $CreatedDateTime = date('Y-m-d H:i:s');
        $ModifyDateTime = date('Y-m-d H:i:s');       
        if(!empty($title)) { 
            $sql_insert = mysql_query("INSERT INTO `SCP_OrgFormBuilder` (`FormDataID`, `FormName`, `FormDataJson`, `FormDataJsonValue`, `UserID`, `OrgID`, `StatusID`, `FromType`, `UserTypeID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$FormDataID', '$FormName', '$FormDataJson', '$FormDataJsonValue', '1', '$OrgID', '1', '0', '$UserTypeID', '$CreatedDateTime', '$ModifyDateTime')", $this->db);
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Form Created Successfully", 'response_code' => "200", 'response_data' => '');
        } else {
            $error = array('status_code' => "0", 'status' => "success", 'message' => "Form heading is not blank.", 'response_code' => "200", 'response_data' => '');
        }
        $this->response($this->json($error), 200);
    }

    private function duplicateOrgForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $FormDataID = $_POST['FormDataID']; 
        $FormType = $_POST['FormType'];
        if($FormType == '2') {
            $sql = mysql_query("SELECT * FROM `SCP_FormBuilder` WHERE `FormDataID` = '$FormDataID'", $this->db);
        } else {
            $sql = mysql_query("SELECT * FROM `SCP_OrgFormBuilder` WHERE `FormDataID` = '$FormDataID'", $this->db);
        }
        $row = mysql_fetch_array($sql, MYSQL_ASSOC);
        $FormDataID = strtoupper('FORM'.strtotime(date('d-m-Y H:i:s'))); 
        $FormName = $row['FormName'];
        $OrgID = $_POST['OrgID']; 
        $FormDataJson = $row['FormDataJson']; 
        $FormDataJsonValue = $row['FormDataJsonValue'];
        $UserTypeID = $row['UserTypeID'];
        $CreatedDateTime = date('Y-m-d H:i:s');
        $ModifyDateTime = date('Y-m-d H:i:s');  
        $sql_insert = mysql_query("INSERT INTO `SCP_OrgFormBuilder` (`FormDataID`, `FormName`, `FormDataJson`, `FormDataJsonValue`, `UserID`, `OrgID`, `StatusID`, `FromType`, `UserTypeID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$FormDataID', '$FormName', '$FormDataJson', '$FormDataJsonValue', '1', '$OrgID', '1', '0', '$UserTypeID', '$CreatedDateTime', '$ModifyDateTime')", $this->db);
        $error = array('status_code' => "1", 'status' => "success", 'message' => "Form Created Successfully", 'response_code' => "200", 'response_data' => '');
        $this->response($this->json($error), 200);
    }

    private function getOrgForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        if (!isset($_SESSION)) {
            session_start();
        }
        $FormDataID = $_POST['FormDataID'];
        $FormType = $_POST['FormType'];
        if($FormType == 2) {
            $sql = mysql_query("SELECT * FROM SCP_FormBuilder WHERE FormDataID='$FormDataID'", $this->db);
        } else {
            $sql = mysql_query("SELECT * FROM SCP_OrgFormBuilder WHERE FormDataID='$FormDataID'", $this->db);
        }
        $row = mysql_fetch_array($sql, MYSQL_ASSOC);
        if($row) {
            $status = "success";
        } else {
            $status = "fail";
        }
        $error = array('status_code' => "1", 'status' => $status, 'message' => "Form Get Successfully", 'response_code' => "200", 'response_data' => $row["FormDataJson"], 'UserTypeID' => $row["UserTypeID"]);
        $this->response($this->json($error), 200);
    }

    private function deleteOrgDocument() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }

        $arr = array();
        $FormDataID = $_POST['FormDataID'];
        $sql = mysql_query("DELETE FROM `SCP_OrgFormBuilder` WHERE FormDataID='$FormDataID'", $this->db);
        if($sql) {
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Document Deleted Successfully", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        } else {
            $error = array('status_code' => "0", 'status' => "error", 'message' => "validation error", 'response_code' => "200", 'response_data' => $arr);
            $this->response($this->json($error), 200);
        }
    }

    private function updateOrgForm() {
        if ($this->get_request_method() != "POST") {
            $error = array('status_code' => "0", 'message' => "wrong method", 'response_code' => "406");
            $this->response($this->json($error), 406);
        }
        $title = '';
        //print_r(json_decode($_POST['FormDataJson'])); die();
        $arrayData = json_decode($_POST['FormDataJson']);
        foreach ($arrayData as $key => $value) {
            if($value->component == 'header') {
                $title = $value->label;
            }
        }
        $arr = array();
        $FormName = $title; 
        $FormDataJson = $_POST['FormDataJson'];
        $FormDataID = $_POST['FormDataID'];
        $OrgID = $_POST['OrgID'];
        $UserTypeID = $_POST['UserTypeID'];
        $CreatedDateTime = date('Y-m-d H:i:s');  
        $ModifyDateTime = date('Y-m-d H:i:s');   
        $FormType = $_POST['FormType'];
        if(!empty($title)) { 
            if($FormType == 2) {
                $sql = mysql_query("INSERT INTO `SCP_OrgFormBuilder` (`FormDataID`, `FormName`, `FormDataJson`, `UserID`, `OrgID`, `StatusID`, `FromType`, `UserTypeID`, `CreatedDateTime`, `ModifyDateTime`) VALUES ('$FormDataID', '$FormName', '$FormDataJson', '1', '$OrgID', '1', '1', '$UserTypeID', '$CreatedDateTime', '$ModifyDateTime')", $this->db);
            } else {
                $sql = mysql_query("UPDATE `SCP_OrgFormBuilder` SET `FormName`='$FormName', `FormDataJson`='$FormDataJson', `ModifyDateTime`='$ModifyDateTime' WHERE `FormDataID` = '$FormDataID'", $this->db);
            }
            $error = array('status_code' => "1", 'status' => "success", 'message' => "Form Updated Successfully", 'response_code' => "200", 'response_data' => '');
        } else {
            $error = array('status_code' => "0", 'status' => "success", 'message' => "Form heading is not blank.", 'response_code' => "200", 'response_data' => '');
        }
        $this->response($this->json($error), 200);
    }

    private function in_array_r($needle, $haystack, $strict = false) {
        foreach ($haystack as $item) {
            if (($strict ? $item === $needle : $item == $needle) || (is_array($item) && $this->in_array_r($needle, $item, $strict))) {
                return true;
            }
        }
        return false;
    }
    
    // ******************************* ENCODE ARRAY INTO JSON *******************************
    private function json($data) {
        if (is_array($data)) {
            return json_encode($data);
        }
    }
}

// Initiiate Library

$api = new API;
$api->processApi();
?>

