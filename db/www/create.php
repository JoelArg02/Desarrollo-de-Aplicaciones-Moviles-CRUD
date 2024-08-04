<?php
// Encabezados CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");


//CONEXION
$server_name = "db";
$user_name = "root";
$password = "rootpassword";
$dbname = "mydatabase";

$connect = new mysqli($server_name, $user_name, $password, $dbname);

// Verificar conexión
if ($connect->connect_error) {
    die("Conexión fallida: " . $connect->connect_error);
}

// Obtener datos del POST
$nombre_producto = isset($_POST['nombre']) ? $connect->real_escape_string($_POST['nombre']) : '';
$precio_producto = isset($_POST['precio']) ? $connect->real_escape_string($_POST['precio']) : '';

// Validar datos
if (empty($nombre_producto) || empty($precio_producto)) {
    echo json_encode(['mensaje' => 'Error', 'error' => 'Los campos nombre_producto y precio_producto no pueden estar vacíos']);
    $connect->close();
    exit();
}

// Preparar y ejecutar la consulta SQL
$sql = "INSERT INTO tb_productos (nombre, precio) VALUES ('$nombre_producto', '$precio_producto')";

if ($connect->query($sql) === TRUE) {
    echo json_encode(['mensaje' => 'Exito']);
} else {
    echo json_encode(['mensaje' => 'Error', 'error' => $connect->error]);
}

// Cerrar conexión
$connect->close();
?>
