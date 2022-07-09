<?php
$servername = "localhost";
$username   = "moneymon_278884mytutor";
$password   = "Maths520";
$dbname     = "moneymon_278884my_tutor_db";


$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>