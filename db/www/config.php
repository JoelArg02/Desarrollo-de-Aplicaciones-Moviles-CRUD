<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, UPDATE, GET, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

$server_name = "db";
$user_name = "root";
$password = "rootpassword";
$dbname = "mydatabase";

$connect = new mysqli($server_name, $user_name, $password, $dbname);

if ($connect->connect_error) {
    die("Conexión fallida: " . $connect->connect_error);
}
?>
