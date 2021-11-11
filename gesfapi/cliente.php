<?php

header("Content-Type: application/json");

$id = $_POST["id"];
$nome = $_POST["nome"];
$cep = $_POST["cep"];
$logradouro = $_POST["logradouro"];
$numero = $_POST["numero"];
$bairro = $_POST["bairro"];
$cidade = $_POST["cidade"];
$estado = $_POST["estado"];

$funcao = $_POST["funcao"];

$dados = array($nome, $cep, $logradouro, $numero, $bairro, $cidade, $estado);


switch ($funcao) {
    case "list":
        listar();
        break;
    case "delete":
        apagar((int) $id);
        break;
    case "update":
        update((int) $id, $dados);
        break;
    default:
        echo ("Função não definida");
}

function listar()
{
    include "db.php";
    $stmt = $db->prepare("SELECT * FROM public.cliente");
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
    close_db();
}

function apagar(int $id)
{
    include "db.php";
    $stmt = $db->prepare("DELETE FROM public.cliente WHERE id = ?");
    $result = $stmt->execute($id);
    $response = array('id' => $id, 'success' => $result);

    echo json_encode($response);
}

function update(int $id, array $dados)
{
    include "db.php";
    if ($id == null || $id == -1) {
        $stmt = $db->prepare("INSERT INTO public.cliente (nome, cep, logradouro, numero, bairro, cidade, estado) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $result = $stmt->execute($dados);
    } else {
        $stmt = $db->prepare("UPDATE public.cliente SET nome = ?, cep = ?, logradouro = ?, numero = ?, bairro = ?, cidade = ?, estado = ? WHERE id = ?");
        $result = $stmt->execute($dados);
    }
    $response = array('success' => $result);
    echo json_encode($response);
}
