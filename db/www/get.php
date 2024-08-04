<?php
include 'config.php';

$query = "SELECT * FROM tb_productos";
$resul = $connect->query($query);
$data = [];

if($resul->num_rows > 0){
    $data = $resul->fetch_all(MYSQLI_ASSOC);
}

echo json_encode($data);

$connect->close();
?>
