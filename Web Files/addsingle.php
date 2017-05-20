<?php
$servername = "mysql1.clusterdb.net";
$username = "chris-d6g-u-115497";
$password = "chris-password";
$dbname = "chris-d6g-u-115497";  

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$inputsid = $_GET["sid"];
$inputname = $_GET["name"];

$sql = "INSERT INTO labQueue (SessionID,StudentName,Time,Date) VALUES ('".$inputsid."','".$inputname."', CURRENT_TIME(), CURRENT_DATE());";

$result = $conn->query($sql);

header("Content-Type: application/json");
$data = Array("Message" => "Success");
echo json_encode($data);

$conn->close();
?>