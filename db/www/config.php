<?php
// Encabezados CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, UPDATE, GET, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Manejo de la solicitud OPTIONS (preflight request)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

// Configuración de conexión a la base de datos
$server_name = "db";
$user_name = "root";
$password = "rootpassword";
$dbname = "mydatabase";

// Crear conexión
$connect = new mysqli($server_name, $user_name, $password, $dbname);

// Verificar conexión
if ($connect->connect_error) {
    die("Conexión fallida: " . $connect->connect_error);
}
?>
