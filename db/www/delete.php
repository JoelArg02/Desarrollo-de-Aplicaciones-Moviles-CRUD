<?php
include 'config.php';

parse_str(file_get_contents("php://input"), $_DELETE);
$id_producto = isset($_DELETE['id']) ? $connect->real_escape_string($_DELETE['id']) : '';


if (empty($id_producto)) {
    echo json_encode(['mensaje' => 'Error', 'error' => 'El campo id_producto no puede estar vacío']);
    $connect->close();
    exit();
}

$sql = "DELETE FROM tb_productos WHERE id = '$id_producto'";

if ($connect->query($sql) === TRUE) {
    echo json_encode(['mensaje' => 'Exito']);
} else {
    echo json_encode(['mensaje' => 'Error', 'error' => $connect->error]);
}

$connect->close();
