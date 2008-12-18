<?php
require_once('C:/one45/htdocs/mainline/admin/pages/classes/debugFunctions.php');

$stdin = file_get_contents("php://stdin");
echo formatQuery($stdin);
?>
