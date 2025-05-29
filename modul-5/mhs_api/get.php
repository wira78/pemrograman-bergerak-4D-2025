<?php
header("Access-Control-Allow-Origin: *");
include 'connection.php';

$query = mysqli_query($conn, "SELECT * FROM mahasiswa ORDER BY idmhs DESC");

$data = [];
while ($row = mysqli_fetch_assoc($query)) {
    $data[] = $row;
}

echo json_encode([
    'success' => true,
    'message' => 'Data retrieved successfully',
    'data' => $data
]);
?>
