<?php
	$code = file_get_contents("php://stdin");
	$method_name = $argv[1];

	require_once('C:/one45/bin/phpCode.php');
	$code = new phpCode($code);

	echo join('SEPARATOR_OF_EXTRACT_METHOD', $code->extractMethod($method_name));
?>
