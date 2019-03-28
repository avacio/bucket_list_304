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

    <?php $searchName = $_GET['searchName']; 
    echo "<script>console.log( 'searchName: ' + '${searchName}')</script>";
//        $searchName = "%${searchName}%";
    ?>
    
    <!-- Top Header / Header Bar -->
    <div id="home" class="boxed-view">
        <?php include("header.html");?>

        <!-- main content -->
        <section class="slider-box">
            <div class="slider-mask"></div>
            <div class="simple-slider">
                <ul class="clean-list">
                    <li><a href="#"><img src="images/header/5.jpg" /></a></li>
                </ul>
            </div>
            <div class="container custom-controls">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="slider-helper">
                            <ul class="clean-list">
                                <li class="text-white text-center">
                                    <h1 class="font-3x font-40">Search results<?php echo ": " . $searchName . "<br>";?></h1>
<!--                                    <p class="darken font-100 welcome-mess">Food is not rational. Food is culture, habit, craving and identity. -- Jonathan Safran Foer</p>-->
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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

        // iterates through the results returned from SQL query and
        // creates the contents of the table
        for ($i = 0; $i < sizeof($namesOfColumnsArray); $i++) {
            $string .= "<td>" . $row["$i"] . "</td>";
        }
        echo $string;
        echo "</tr>";
    }
    echo "</table>";
}

// Connect Oracle...
if ($db_conn) {
    echo "<script>console.log( 'Connected to Oracle.')</script>";
    $columnNames = array("Name", "Price ($)", "Description", "Link", "Location", "Points");
    $searchName = "%${searchName}%";

// sorts matches by popularity
$result = executePlainSQL("select b.name, b.price, b.description, b.link, b.location, b.points_value 
FROM bucket_list_item b LEFT OUTER JOIN itemCount i
ON b.bl_item_id = i.bl_item_id
WHERE b.name LIKE '${searchName}'
OR b.location LIKE '${searchName}'
OR b.description LIKE '${searchName}'
OR b.link LIKE '${searchName}'
order by i.items DESC NULLS LAST
");
    
    printTable($result, $columnNames);

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
