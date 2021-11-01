<?php

header("Content-Type: application/json");
include "../gesfapi/db.php";

$id = $_POST["id"];
$nome = $_POST["nome"];
$cep = $_POST["cep"];
$logradouro = $_POST["logradouro"];
$numero = $_POST["numero"];
$bairro = $_POST["bairro"];
$cidade = $_POST["cidade"];
$estado = $_POST["estado"];

$funcao = $_POST["funcao"];

switch ($funcao) {
    case "list":
        listar($id);
        break;
    case "delete":
        apagar($id);
        break;
    case "update":
        update($id);
        break;
}

function listar($id)
{
    require "db.php";

    if ($id == null || $id == "") {
        $stmt = $db->prepare("SELECT * from Cliente");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result);
    } else {
        $stmt = $db->prepare("SELECT * from Cliente WHERE id = ?");
        $stmt->execute([(int)$id]);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['result' => $result]);
    }
}

function apagar($id)
{
    require "db.php";
    $stmt = $db->prepare("DELETE from Cliente WHERE id = ?");
    $result = $stmt->execute([$id]);

    echo json_encode(
        ['id' => $id, 'success' => $result]
    );
}

function update($id)
{
    require "db.php";
    if ($id == null || $id == "") {
        $stmt = $db->prepare("INSERT INTO Cliente (nome, cep, logradouro, numero, bairro, cidade, estado) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $result = $stmt->execute([$nome, $cep, $logradouro, $numero, $bairro, $cidade, $estado]);
    } else{
        $stmt = $db->prepare("UPDATE Cliente SET nome = ?, cep = ?, logradouro = ?, numero = ?, bairro = ?, cidade = ?, estado = ? WHERE id = ?");
        $result = $stmt->execute([$nome, $cep, $logradouro, $numero, $bairro, $cidade, $estado, (int)$id]);        
    }
    echo json_encode(['success'=>$result]);
}
