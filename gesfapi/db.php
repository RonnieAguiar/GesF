<?php

$db_name = "";
$db_server = "";
$db_port = "";
$db_user = "";
$db_pass = "";

$db = new PDO('pgsql:host={$db_server};port={$db_port};dbname={$db_name}', $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

function close_db()
{

    $stmt = null;
    $db = null;
}
