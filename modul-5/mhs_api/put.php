<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, PUT, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
  http_response_code(200);
  exit;
}

$idmhs = $_POST['idmhs'] ?? null;
$nama = $_POST['nama'] ?? null;
$nim = $_POST['nim'] ?? null;
$alamat = $_POST['alamat'] ?? null; // gunakan alamat sesuai data dari fetch

if (!$idmhs || !$nama || !$nim || !$alamat) {
    echo json_encode([
        "success" => false,
        "message" => "All fields are required"
    ]);
    exit;
}

$update_query = "UPDATE mahasiswa SET nama='$nama', nim='$nim', alamat='$alamat' WHERE idmhs='$idmhs'";
$update_method = mysqli_query($conn, $update_query);

if ($update_method) {
    echo json_encode([
        "success" => true,
        "message" => "Data updated successfully"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Failed to update data: " . mysqli_error($conn)
    ]);
}
?>
