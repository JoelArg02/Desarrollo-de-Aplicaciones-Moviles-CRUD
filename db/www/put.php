<?php
include 'config.php';

parse_str(file_get_contents("php://input"), $_PUT);
$id_producto = isset($_PUT['id']) ? $connect->real_escape_string($_PUT['id']) : '';
$nombre_producto = isset($_PUT['nombre']) ? $connect->real_escape_string($_PUT['nombre']) : '';
$precio_producto = isset($_PUT['precio']) ? $connect->real_escape_string($_PUT['precio']) : '';

if (empty($id_producto) || empty($nombre_producto) || empty($precio_producto)) {
    echo json_encode(['mensaje' => 'Error', 'error' => 'Los campos id_producto, nombre_producto y precio_producto no pueden estar vacíos']);
    $connect->close();
    exit();
}

$sql = "UPDATE tb_productos SET nombre = '$nombre_producto', precio = '$precio_producto' WHERE id = '$id_producto'";

if ($connect->query($sql) === TRUE) {
    echo json_encode(['mensaje' => 'Exito']);
} else {
    echo json_encode(['mensaje' => 'Error', 'error' => $connect->error]);
}

$connect->close();
?>
