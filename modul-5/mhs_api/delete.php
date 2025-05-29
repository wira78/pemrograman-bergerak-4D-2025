<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");


include 'connection.php';

$data = json_decode(file_get_contents("php://input"));

if (isset($data->idmhs)) {
    $idmhs = $data->idmhs;
    $query = mysqli_query($conn, "DELETE FROM mahasiswa WHERE idmhs='$idmhs'");
    
    if ($query) {
        echo json_encode(["success" => true, "message" => "Data deleted"]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to delete"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid request"]);
}
?>
