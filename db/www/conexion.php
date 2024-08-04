<?php
//CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

//CONEXION
$server_name = "db";
$user_name = "root";
$password = "rootpassword";
$dbname = "mydatabase";

$connect = new mysqli($server_name, $user_name, $password, $dbname);

//VERIFICAR LA CONEXION
if($connect->connect_error){
    die("Conexion fallida: " . $connect->connect_error);
}

//ejecutar consulta
$query = "SELECT * FROM tb_productos";
$resul = $connect->query($query);
$data = [];

if($resul->num_rows > 0){
    $data = $resul->fetch_all(MYSQLI_ASSOC);
}

//CODIFICAR DATOS EN JSON
echo json_encode($data);

//Cerrar conexion
$connect->close();

?>
