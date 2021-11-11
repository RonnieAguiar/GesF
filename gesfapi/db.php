<?php

try {
    $db = new PDO('pgsql:host=gesfapi.postgresql.dbaas.com.br dbname=gesfapi user=gesfapi password=F@ntin1!');
    $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException  $e) {
    print $e->getMessage();
}

function close_db()
{
    $stmt = null;
    $db = null;
}
