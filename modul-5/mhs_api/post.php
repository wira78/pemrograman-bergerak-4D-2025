<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, PUT, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
include 'connection.php';

if (isset($_POST['nama'], $_POST['nim'], $_POST['alamat']) &&
    !empty(trim($_POST['nama'])) &&
    !empty(trim($_POST['nim'])) &&
    !empty(trim($_POST['alamat']))) {

    $nama = $_POST['nama'];
    $nim = $_POST['nim'];
    $alamat = $_POST['alamat'];

    $query = mysqli_query($conn, "INSERT INTO mahasiswa (nama, nim, alamat) VALUES ('$nama', '$nim', '$alamat')");

    if ($query) {
        echo json_encode(["success" => true, "message" => "Data added successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to insert data"]);
    }

} else {
    echo json_encode(["success" => false, "message" => "All fields are required"]);
}
?>
