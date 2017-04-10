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
    <title>Smarter Care Plan</title>
    <!-- Bootstrap -->
    <!-- Bootstrap CSS -->    
    <link href="<?php echo URL; ?>css/bootstrap.min.css" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="<?php echo URL; ?>css/bootstrap-theme.css" rel="stylesheet">
    <!--external css-->
    <!-- font icon -->
    <link href="<?php echo URL; ?>css/elegant-icons-style.css" rel="stylesheet" />
    <link href="<?php echo URL; ?>css/font-awesome.min.css" rel="stylesheet" />    
    <!-- full calendar css-->
    <link href="<?php echo URL; ?>assets/fullcalendar/fullcalendar/bootstrap-fullcalendar.css" rel="stylesheet" />
    <link href="<?php echo URL; ?>assets/fullcalendar/fullcalendar/fullcalendar.css" rel="stylesheet" />
    <!-- easy pie chart-->
    <link href="<?php echo URL; ?>assets/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen"/>
    <!-- owl carousel -->
    <link rel="stylesheet" href="<?php echo URL; ?>css/owl.carousel.css" type="text/css">
    <link href="<?php echo URL; ?>css/jquery-jvectormap-1.2.2.css" rel="stylesheet">
    <!-- Custom styles -->
    <link rel="stylesheet" href="<?php echo URL; ?>css/fullcalendar.css">
    <!--link href="<?php echo URL; ?>css/widgets.css" rel="stylesheet"-->
    <link href="<?php echo URL; ?>css/style.css" rel="stylesheet">
    <link href="<?php echo URL; ?>css/new_style.css" rel="stylesheet">
	  <!--For sidebar-->
	  <link href="<?php echo URL; ?>css/new_style2.css" rel="stylesheet">
    <link href="<?php echo URL; ?>css/style-responsive.css" rel="stylesheet" />
    <link href="<?php echo URL; ?>css/xcharts.min.css" rel=" stylesheet"> 
    <link href="<?php echo URL; ?>css/jquery-ui-1.10.4.min.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="<?php echo URL; ?>css/bootstrap.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="<?php echo URL; ?>css/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="<?php echo URL; ?>css/animate.min.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    
    <link href="<?php echo URL; ?>css/custom.css" rel="stylesheet">
    
    <link href="<?php echo URL; ?>css/toaster.css" rel="stylesheet">

    <link rel="stylesheet" href="<?php echo URL; ?>assets/datatable/datatables.bootstrap.css">
    <style>
      a {
      color: orange;
      }
      #preloader  {
           position: absolute;
           top: 0;
           left: 0;
           right: 0;
           bottom: 0;
           background-color: #fefefe;
           z-index: 9999;
          height: 100%;
       }

      #status  {
           width: 200px;
           height: 200px;
           position: absolute;
           left: 50%;
           top: 50%;
           background-image: url(images/loder.gif);
           background-repeat: no-repeat;
           background-position: center;
           margin: -100px 0 0 -100px;
       }
    </style>
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

  <!-- custom js start -->
  <script type="text/javascript" src="<?php echo URL; ?>js/jquery-ui-1.9.2.custom.min.js"></script>
  <!-- bootstrap -->
  <script src="<?php echo URL; ?>js/bootstrap.min.js"></script>
  <!-- nice scroll -->
  <script src="<?php echo URL; ?>js/jquery.scrollTo.min.js"></script>
  <script src="<?php echo URL; ?>js/jquery.nicescroll.js" type="text/javascript"></script>
  <!-- charts scripts -->
  <script src="<?php echo URL; ?>assets/jquery-knob/js/jquery.knob.js"></script>
  <script src="<?php echo URL; ?>js/jquery.sparkline.js" type="text/javascript"></script>
  <script src="<?php echo URL; ?>assets/jquery-easy-pie-chart/jquery.easy-pie-chart.js"></script>
  <script src="<?php echo URL; ?>js/owl.carousel.js" ></script>
  <!-- jQuery full calendar -->
  <script src="<?php echo URL; ?>js/fullcalendar.min.js"></script> <!-- Full Google Calendar - Calendar -->
  <script src="<?php echo URL; ?>assets/fullcalendar/fullcalendar/fullcalendar.js"></script>
  <!--script for this page only-->
  <script src="<?php echo URL; ?>js/calendar-custom.js"></script>
  <script src="<?php echo URL; ?>js/jquery.rateit.min.js"></script>
  <!-- custom select -->
  <script src="<?php echo URL; ?>js/jquery.customSelect.min.js" ></script>
  <script src="<?php echo URL; ?>assets/chart-master/Chart.js"></script>

  <!--custome script for all page-->
  <script src="<?php echo URL; ?>js/scripts.js"></script>
  <!-- custom script for this page-->
  <script src="<?php echo URL; ?>js/sparkline-chart.js"></script>
  <script src="<?php echo URL; ?>js/easy-pie-chart.js"></script>
  <script src="<?php echo URL; ?>js/jquery-jvectormap-1.2.2.min.js"></script>
  <script src="<?php echo URL; ?>js/jquery-jvectormap-world-mill-en.js"></script>
  <script src="<?php echo URL; ?>js/xcharts.min.js"></script>
  <script src="<?php echo URL; ?>js/jquery.autosize.min.js"></script>
  <script src="<?php echo URL; ?>js/jquery.placeholder.min.js"></script>
  <script src="<?php echo URL; ?>js/gdp-data.js"></script>  
  <script src="<?php echo URL; ?>js/morris.min.js"></script>
  <script src="<?php echo URL; ?>js/sparklines.js"></script>  
  <script src="<?php echo URL; ?>js/charts.js"></script>
  <script src="<?php echo URL; ?>js/jquery.slimscroll.min.js"></script>

  <script>

      //knob
      $(function() {
        $(".knob").knob({
          'draw' : function () { 
            $(this.i).val(this.cv + '%')
          }
        })
      });

      // makes sure the whole site is loaded
      $(window).load(function() {
              // will first fade out the loading animation
        $("#status").fadeOut();
              // will fade out the whole DIV that covers the website.
        $("#preloader").delay(1000).fadeOut("slow");
      })


      $(function(){
          $('.datatable').dataTable();
      });

      //carousel
      $(document).ready(function() {
          $("#owl-slider").owlCarousel({
              navigation : true,
              slideSpeed : 300,
              paginationSpeed : 400,
              singleItem : true

          });
      });

      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });
    
    /* ---------- Map ---------- */
    $(function(){
      $('#map').vectorMap({
        map: 'world_mill_en',
        series: {
          regions: [{
            values: gdpData,
            scale: ['#000', '#000'],
            normalizeFunction: 'polynomial'
          }]
        },
      backgroundColor: '#eef3f7',
        onLabelShow: function(e, el, code){
          el.html(el.html()+' (GDP - '+gdpData[code]+')');
        }
      });
    });

  </script>
  <!---- custom js end --->

  <!-- Libs -->
</html>