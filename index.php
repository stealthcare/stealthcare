<!DOCTYPE html>
<html lang="en" ng-app="myApp">
  <?php 
    session_start();
    include 'api/config.php'; 
  ?>
  <head>
    <?php //echo '<pre>'; print_r($_SESSION); echo '</pre>'; ?>
    <base href="/stealthcare/" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="shortcut icon" href="<?php echo URL; ?>images/favicon.png">
    <link href="<?php echo URL; ?>css/bootstrap.min.css" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="<?php echo URL; ?>css/bootstrap-theme.css" rel="stylesheet">
    <link href="<?php echo URL; ?>css/font-awesome.min.css" rel="stylesheet" />
    <!-- owl carousel -->
    <link href="<?php echo URL; ?>css/style.css" rel="stylesheet">
    <link href="<?php echo URL; ?>css/new_style.css" rel="stylesheet">
	  <!--For sidebar-->
	  <link href="<?php echo URL; ?>css/new_style2.css" rel="stylesheet">
    <link href="<?php echo URL; ?>css/style-responsive.css" rel="stylesheet" />
    <link href="<?php echo URL; ?>css/jquery-ui-1.10.4.min.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="<?php echo URL; ?>css/bootstrap.min.css" rel="stylesheet">
    <link href="<?php echo URL; ?>css/animate.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="<?php echo URL; ?>css/custom.css" rel="stylesheet">
    <link href="<?php echo URL; ?>css/toaster.css" rel="stylesheet">
	  <link rel="stylesheet" href="<?php echo URL; ?>css/datepicker.css">
    <!-- Form Builder Style -->
    <link href="<?php echo URL; ?>assets/form-builder/site.css" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo URL; ?>assets/form-builder/angular-form-builder.css">
  </head>

  <body ng-cloak="">
    <div id="preloader">
      <div id="status">&nbsp;</div>
    </div>
    
    <div class="containers">

      <div data-ng-view="" id="ng-view" class="slide-animation"></div>

    </div>
  </body>
  <toaster-container toaster-options="{'time-out': 3000}"></toaster-container>
  <!-- javascripts -->
  
  <script src="<?php echo URL; ?>js/jquery-1.9.1.min.js"></script>
  <script src="<?php echo URL; ?>js/angular.min.js"></script>
  <script src="<?php echo URL; ?>js/angular-route.min.js"></script>
  <script src="<?php echo URL; ?>js/angular-animate.min.js" ></script>
  <script src="<?php echo URL; ?>js/toaster.js"></script>
  <script src="<?php echo URL; ?>app/app.js"></script>
  <script src="<?php echo URL; ?>app/data.js"></script>
  <script src="<?php echo URL; ?>app/directives.js"></script>
  <script src="<?php echo URL; ?>app/authCtrl.js"></script>
  <script src="<?php echo URL; ?>app/orgCtrl.js"></script>
  <script src="<?php echo URL; ?>assets/datatable/angular-datatables.min.js"></script>
  <script src="<?php echo URL; ?>assets/datatable/jquery.dataTables.min.js"></script>
  <script src="<?php echo URL; ?>assets/datatable/dirPagination.js"></script>
  <script src="<?php echo URL; ?>js/bootstrap.js"></script>
  <!-- nice scroll -->
  <script src="<?php echo URL; ?>js/jquery.scrollTo.min.js"></script>
  <script src="<?php echo URL; ?>js/jquery.nicescroll.js" type="text/javascript"></script>
  <script src="<?php echo URL; ?>js/scripts.js"></script>
  <script src="<?php echo URL; ?>js/bootstrap-datepicker.js"></script>
  <!-- Libs -->
  <script>
      // makes sure the whole site is loaded
      $(window).load(function() {
              // will first fade out the loading animation
        $("#status").fadeOut();
              // will fade out the whole DIV that covers the website.
        $("#preloader").delay(100).fadeOut("slow");
      });

  </script>
  <script src="<?php echo URL; ?>assets/form-builder/angular-form-builder.js"></script>
  <script src="<?php echo URL; ?>assets/form-builder/angular-form-builder-components.js"></script>
  <script type="text/javascript" src="<?php echo URL; ?>js/angular-validator.min.js"></script>
  <script type="text/javascript" src="<?php echo URL; ?>js/angular-validator-rules.min.js"></script>
</html>