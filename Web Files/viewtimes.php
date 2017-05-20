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

$sql = "SELECT * FROM labQueue WHERE SessionID='$inputsid'";
$result = $conn->query($sql);

$data = Array("ID" => "Times");
$num = 0;

while($row = $result->fetch_assoc()) {
	header("Content-Type: application/json");
	$time = $row['Time'];
	$data[$num] = $time;
	$num++;
}

echo json_encode($data);

$conn->close();
?>