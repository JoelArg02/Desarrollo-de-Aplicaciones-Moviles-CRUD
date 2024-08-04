<?php
include 'config.php';

$nombre_producto = isset($_POST['nombre']) ? $connect->real_escape_string($_POST['nombre']) : '';
$precio_producto = isset($_POST['precio']) ? $connect->real_escape_string($_POST['precio']) : '';

if (empty($nombre_producto) || empty($precio_producto)) {
    echo json_encode(['mensaje' => 'Error', 'error' => 'Los campos nombre_producto y precio_producto no pueden estar vacíos']);
    $connect->close();
    exit();
}

$sql = "INSERT INTO tb_productos (nombre, precio) VALUES ('$nombre_producto', '$precio_producto')";

if ($connect->query($sql) === TRUE) {
    echo json_encode(['mensaje' => 'Exito']);
} else {
    echo json_encode(['mensaje' => 'Error', 'error' => $connect->error]);
}

$connect->close();
?>
