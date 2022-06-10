<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$results_per_page = 5; //one page how many product
// //determines the page number the user is currently visiting. In case if it is not present, by default it is set page number to 1.
$pageno = (int)$_POST['pageno']; 


$page_first_result = ($pageno - 1) * $results_per_page; ////Page1 - A to J (1-10)    Page 2 - K to T (11-20)


$sqlloadsubjects = "SELECT * FROM tbl_subjects";
$result = $conn->query($sqlloadsubjects);
$number_of_result = $result->num_rows;

$number_of_page = ceil($number_of_result / $results_per_page); //determine the total number of pages available  

    //retrieve the selected results from database   

$sqlloadsubjects = $sqlloadsubjects . " LIMIT $page_first_result , $results_per_page";
$result = $conn->query($sqlloadsubjects);

if ($result->num_rows > 0) {
    //do something
    $subjects["subjects"] = array();
    while ($row = $result->fetch_assoc()) { //Fetching all the rows as arrays

        $subjectslist = array();
        $subjectslist['subject_id'] = $row['subject_id'];
        $subjectslist['subject_name'] = $row['subject_name'];
        $subjectslist['subject_description'] = $row['subject_description'];
        $subjectslist['tutor_id'] = $row['tutor_id'];
        $subjectslist['subject_price'] = $row['subject_price'];
        $subjectslist['subject_sessions'] = $row['subject_sessions'];
        $subjectslist['subject_rating'] = $row['subject_rating'];
        array_push($subjects["subjects"],$subjectslist); 
    }
    $response = array('status' => 'success', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page", 'data' => $subjects);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page",'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>