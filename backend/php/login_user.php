<?php


if (!isset($_POST)) 
{ echo "failed";
}
include_once("dbconnect.php");

//if(isset($_POST['email']) ||isset($_POST['password'])){
$email = $_POST['email'];
$password = $_POST['password'];

$sqllogin = "SELECT * FROM tbl_users WHERE user_email = '$email' AND user_password = '$password' ";  //php in database

//the data must be properly formatted and all strings 
$result = $conn->query($sqllogin);    //mysqli_query function= The function can be used to execute the following query types;InsertSelectUpdatedelete


 if ($result ->num_rows > 0) {
    
while ($row = $result->fetch_assoc()) { //   //Fetching all the rows as arrays

$user['id'] = $row['user_id'];      //id is to model user ,row is frm database
$user['name'] = $row['user_name'];
$user['email'] = $row['user_email'];
$user['phone'] = $row['user_phone'];
$user['address'] = $row['user_address'];
$user['datereg'] = $row['user_datereg'];

}
$sqlgetqty = "SELECT * FROM tbl_carts WHERE user_email = '$email' AND cart_status IS NULL";
    $result = $conn->query($sqlgetqty);
    $number_of_result = $result->num_rows;
    $carttotal = 0;
    while($row = $result->fetch_assoc()) {
        $carttotal = $row['cart_qty'] + $carttotal;
    }
    $mycart = array();
    $customer['cart'] =$carttotal;

$response =array('status' => 'success','data' => $user);//put data in user class
sendJsonResponse($response);

}else{
    $response =array('status' => 'failed','data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

//}
?>