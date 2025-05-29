<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'db_mahasiswa';

$conn = mysqli_connect($host, $username, $password, $database);

if (mysqli_connect_errno()) {
    header('Content-Type: application/json');
    http_response_code(500);
    die(json_encode([
        'success' => false,
        'message' => 'Connection failed: ' . mysqli_connect_error()
    ]));
}
?>
