<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$base64image = $_POST['image'];
$address = $_POST['address'];




$sqlinsert = "INSERT INTO tbl_users (user_email,user_name,user_password,user_phone,user_address) VALUES('$email','$name','$password','$phone','$address')";

if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
   
   $filename = mysqli_insert_id($conn);
   $decoded_string = base64_decode($base64image);
   $path = '../assets/profile/' . $filename. '.png';
   $is_written = file_put_contents($path, $decoded_string);

    sendJsonResponse($response);
    
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}


?>