<!--
********************************************************************************
   UKD - UKITA DEVELOPMENT
--------------------------------------------------------------------------------
   Extension : Ukd Pagseguro
   Ext. Code : ukd_pagseguro_209004f2 
   Filename  : ukd_pagseguro\upload\system\library\ukd_pagseguro_app\templates\checkout.php
   Author    : Fred Ukita
   Date      : Tuesday 13th of September 2016 07:52:06 PM 
********************************************************************************
--><!DOCTYPE html>
<html>
	
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" href="css/styles.css" />
		<link rel="stylesheet" href="css/colorbox.css" />
	</head>

	<body>
		
		<?php require_once "orderData.inc.php"; ?>
		<?php require_once "buyerData.inc.php"; ?>
		<?php require_once "paymentMethods.inc.php"; ?>
		
		<script type="text/javascript" src="<?php echo $this->pagSeguroData->getJavascriptURL(); ?>"></script>
		
		<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery.colorbox-min.js"></script>
		<script type="text/javascript" src="js/helpers.js"></script>
		<script type="text/javascript" src="js/checkout.js"></script>
		
	</body>

</html>