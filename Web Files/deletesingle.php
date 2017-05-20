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


$sql = "INSERT INTO labQueueHistory (SessionID, StudentName,TimeAdded,TimeCompleted,Date)
          SELECT SessionID, StudentName, Time, CURRENT_TIME(), Date
          FROM labQueue
          WHERE SessionID = '$inputsid' AND StudentName = '$inputname'";


$result = $conn->query($sql);

$sql2 = "DELETE FROM labQueue WHERE SessionID = '$inputsid' AND StudentName = '$inputname'";
$result2 = $conn->query($sql2);

header("Content-Type: application/json");
$data = Array("Message" => "Success");
echo json_encode($data);

$conn->close();
?>