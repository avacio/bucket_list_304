<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
    <meta charset="UTF-8">
    <title>BucketList</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font-->
    <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900'>

    <!-- Stylesheets -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" media="all" href="css/template.css">
    <link rel="stylesheet" type="text/css" media="all" href="css/magnific-popup.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">


    <!-- Javscripts -->
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery.magnific-popup.js"></script>
    <script type="text/javascript" src="js/scripts.js"></script>
</head>

<body>

    <!-- Top Header / Header Bar -->
    <div id="home" class="boxed-view">
        <?php include("header.html");?>

        <!-- main content -->
        <section class="slider-box">
            <div class="slider-mask"></div>
            <div class="simple-slider">
                <ul class="clean-list">
                    <li><a href="#"><img src="images/header/6.jpg" /></a></li>
                </ul>
            </div>
            <div class="container custom-controls">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="slider-helper">
                            <ul class="clean-list">
                                <li class="text-white text-center">
                                    <h1 class="font-3x font-40">Have a BucketList item?</h1>
                                    <p class="darken font-100 welcome-mess">Let us know!</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="row">

            <div class="black filter-form">
                <form id="requestform" method="POST" action="request.php#submit" class="row no-padding">
                    <div class="text-yellow text-center fancy-heading">
                        <h3 class="font-600">REQUEST FORM</h3>
                        <p>New Item</p>
                    </div>

                    <p class="darken font-100 welcome-mass"></p>

                    <div class="row">
                        <label for="username">Username</label>
                        <input type="string" id="username" name="username" style="background-color: #D8D8D8; " required />

                    </div>

                    <div class="row">
                        <label for="start-date">Today's Date</label>
                        <i class="fa fa-calendar infield"></i>
                        <input type="text" name="start-date" id="start-date" class="form-control" placeholder="DD-MMM-YY" style="background-color: #b2b2b2;" required />
                    </div>

                    <div class="row">
                        <label for="blname">Bucket List Item Name</label>

                        <input type="string" id="blname" name="blname" required style="background-color: #737373; color: white" />
                    </div>

                    <div class="row">
                        <label for="type">Type</label>
                        <select id="type" name="type" style="background-color: #5f5f5f; color: white">
                            <option value="Food">Food</option>
                            <option value="Activity">Activity</option>
                            <option value="Event">Event</option>
                        </select>
                    </div>

                    <div class="row">
                        <label for="description">Description</label>
                        <textarea name="description" class="form-control" rows="5" id="description" style="background-color: #4a4a4a; color: white" required></textarea>
                    </div>
                    <br>
                    <div class="col-md-12 col-sm-4" style="text-align:center;" id="submit">

                        <form method="POST" action="request.php#submit">
                            <button type="submit" name="submitRequest" class="button-md orange hover-dark-orange soft-corners">Submit</button>
                        </form>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <br><br>
    <?php

require('parse-sql.php'); 
$success = True;
$db_conn = OCILogon("ora_k7c1b", "a20470150", 
                    "dbhost.ugrad.cs.ubc.ca:1522/ug");


function printTable($resultFromSQL, $namesOfColumnsArray)
{
    echo "<table>";
    echo "<tr>";
    foreach ($namesOfColumnsArray as $name) {
        echo "<th>$name</th>";
    }
    echo "</tr>";

    while ($row = OCI_Fetch_Array($resultFromSQL, OCI_BOTH)) {
        echo "<tr>";
        $string = "";
        for ($i = 0; $i < sizeof($namesOfColumnsArray); $i++) {
            $string .= "<td>" . $row["$i"] . "</td>";
        }
        echo $string;
        echo "</tr>";
    }
    echo "</table>";
}

$username = $_POST['username'];
$theDate = $_POST['start-date'];
$blname = $_POST['blname'];
$type = $_POST['type'];
$description = $_POST['description'];
//$evaluated = "0";
//$requestid = executePlainSQL("select COUNT(*) from item_request_requests");
//$blID = executePlainSQL("select COUNT(*) from bucket_list_item");

echo "<script>console.log( 'username: ' + '${username}'
+ ', theDate: ' + '${theDate}' + ', blname: ' + '${blname}'
+ ', type: ' + '${type}'
+ ', description: ' + '${description}')</script>";
        
if (strcmp($type, 'Food') == 0) {
    $type = 0;
} else if (strcmp($type, 'Event') == 0) {
    $type = 1;
} else if (strcmp($type, 'Activity') == 0) {
    $type = 2;
}

                
// Connect Oracle...
if ($db_conn) {
    echo "<script>console.log( 'Connected to Oracle.')</script>";
    $columnNames = array("Request ID", "Username", "Date", "Item Name", "Type", "Description");
    
    if (array_key_exists('submitRequest', $_POST)) {

$result = executePlainSQL("SELECT COUNT(1) FROM consumer, admin WHERE consumer_username='${username}' OR admin_username='${username}' 
");
$row=OCI_Fetch_Array($result, OCI_BOTH); 
    if($row[0] >= 1) {   
         $result = executePlainSQL("SELECT max(request_id) + 1
FROM item_request_requests
");
        while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
        $newRID .= "" . $row[0] . "";
    }

         executePlainSQL("insert into item_request_requests values (${newRID}, null, ${type}, '${blname}', '${description}', '${theDate}', '${username}', 0)
        ");
        		OCICommit($db_conn);

$result = executePlainSQL("SELECT r.request_id, r.consumer_username, r.requested_date, r.name, t.bl_type, r.description from item_request_requests r, bucket_list_type t
WHERE r.bl_type_id = t.bl_type_id AND
r.request_id = ${newRID}
");
        printTable($result, $columnNames);
        echo "<br> Request submitted.";
 } else { 
        echo "<br> Invalid username.";
    }}

    OCILogoff($db_conn);
} else {
    echo "cannot connect";
    $e = OCI_Error(); // For OCILogon errors pass no handle
    echo htmlentities($e['message']);
}
?>

    <?php include("footer.html");?>


</body>

</html>
