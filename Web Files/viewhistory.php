<style>
<?php include 'stylesheet.css'; ?>
</style>
<?php


$servername = "mysql1.clusterdb.net";
$username = "chris-d6g-u-115497";
$password = "chris-password";
$dbname = "chris-d6g-u-115497"; 

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 



$sql = "SELECT * FROM labQueueHistory";
$result = $conn->query($sql);

echo "<table style='width:100%;border:none'>
<tr>
<th>Name</th>
<th>Session ID</th>
<th>Time Added</th>
<th>Time Completed</th>
<th>Date</th>
</tr>
<tr>
<td>&nbsp;</td>
<td></td>
<td></td>
<td></td>
</tr>";

while($row = mysqli_fetch_array($result))
{
echo "<tr style='text-align:center'>";
echo "<td>" . $row['StudentName'] . "</td>";
echo "<td>" . $row['SessionID'] . "</td>";
echo "<td>" . $row['TimeAdded'] . "</td>";
echo "<td>" . $row['TimeCompleted'] . "</td>";
echo "<td>" . $row['Date'] . "</td>";
echo "</tr>";
}
echo "</table>";


$conn->close();
?>