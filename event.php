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
                    <li><a href="#"><img src="images/header/3.jpg" /></a></li>
                </ul>
            </div>
            <div class="container custom-controls">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="slider-helper">
                            <ul class="clean-list">
                                <li class="text-white text-center">
                                    <h1 class="font-3x font-40">
                                        Embrace the now.
                                    </h1>
                                   <p class="darken font-100 welcome-mess">
<!--The emotional brain responds to an event more quickly than the thinking brain. -- Daniel Goleman-->
                                       <!--The meeting of two personalities is like the contact of two chemical substances: if there is any reaction, both are transformed. -- Carl Jung-->
                                       Why not try it all, if you only remember it once? -- The Strokes

</p>
                                    
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="row">
            <div class="col-md-12">
                <div class="black filter-form">
                    <form id="filterform" method="get" action="event.php" class="row no-padding">
                        <div class="col-md-2 col-sm-6">
									<label for ="start-date">Start Date</label>
      								<i class="fa fa-calendar infield"></i>
      								<input type="text" name="start-date" id="start-date" class="form-control" placeholder="DD-MMM-YY" required />
								</div>
								<div class="col-md-2 col-sm-6">
									<label for ="end-date">End Date</label>
      								<i class="fa fa-calendar infield"></i>
      								<input type="text" name="end-date" id="end-date" placeholder="DD-MMM-YY"/>
								</div>
                        <div class="col-md-2 col-sm-4">
                            <label for="priceMax">Price Max</label>
                            <i class="fa fa-usd"></i>
                            <input type="number" value="100000" name="priceMax" id="priceMax" min="0" required />
                            <!--                                    max="500"-->
                        </div>

                        <div class="col-md-2 col-sm-4">
                            <label for="priceMin">Price Min</label>
                            <i class="fa fa-usd"></i>
                            <input type="number" value="0" name="priceMin" id="priceMin" min="0" max=$_GET['priceMax']; required />
                            <!--                                    max="500"-->
                        </div>

                        <div class="col-md-2 col-sm-4">
                            <label for="location">Location</label>
                            <i class="fa fa-location-arrow"></i>
                            <input type="text" value="Any" name="location" id="location" />
                        </div>


                        <div class="col-md-2 col-sm-4">
                            <label for="event-item">Sort by</label>
                            <select id="sortBy" name="sortBy">
                                <option value="popularity">Popularity</option>
                                <option value="endingSoon">Ending Soon</option>
                                <option value="recentlyAdded">Recently Added</option>
                                <option value="priceAsc">Price: Low -> High</option>
                                <option value="priceDesc">Price: High -> Low</option>
                                <option value="pointsAsc">Points: Low -> High</option>
                                <option value="pointsDesc">Points: High -> Low</option>
                                <option value="abc">Alphabetical</option>
                            </select>
                        </div>

                        <div class="col-md-12 col-sm-4" style="text-align:center;">
                            <br>
                            <form method="POST" action="event.php">
                                <button type="submit" name="search" class="button-md orange hover-dark-orange soft-corners">Filter</button>
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
//    echo "<br>RESULTS:<br>";
    echo "<table>";
    echo "<tr>";
    // iterate through the array and print the string contents
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

$startDate = $_GET['start-date'];
$endDate = $_GET['end-date'];
$priceMax = $_GET['priceMax'];
$priceMin = $_GET['priceMin'];
$location = $_GET['location'];
$sortBy = $_GET['sortBy'];

if (strcmp($location, 'Any') == 0) {
	$location = '%';
} else { $location = "%${location}%"; }

if (strcmp($endDate, '') == 0) {
    echo "<script>console.log( 'empty endDate')</script>";
	$endDate = '31-Dec-3000';
}

echo "<script>console.log( 'priceMax: ' + '${priceMax}'
+ ', priceMin: ' + '${priceMin}' + ', location: ' + '${location}'
+ ', startDate: ' + '${startDate}'
+ ', endDate: ' + '${endDate}'
+ ', sortBy: ' + '${sortBy}')</script>";
                
if (strcmp($sortBy, 'priceAsc') == 0) {
	$sortBy = "b.price ASC";
} else if (strcmp($sortBy, 'priceDesc') == 0) {
	$sortBy = "b.price DESC";
} else if (strcmp($sortBy, 'endingSoon') == 0) {
	$sortBy = "e.event_end ASC";
} else if (strcmp($sortBy, 'pointsAsc') == 0) {
	$sortBy = "b.points_value ASC";
} else if (strcmp($sortBy, 'pointsDesc') == 0) {
	$sortBy = "b.points_value DESC";
} else if (strcmp($sortBy, 'abc') == 0) {
	$sortBy = "b.name";
}
echo "<script>console.log( 'sortBy changed to: ' + '${sortBy}')</script>";

// Connect Oracle...
if ($db_conn) {
    echo "<script>console.log( 'Connected to Oracle.')</script>";
    $columnNames = array("Name", "Start Date", "End Date", "Price ($)", "Location", "Points");
    
    if (array_key_exists('search', $_GET)) {
    echo "<script>console.log( 'return search.')</script>";

    if (strcmp($sortBy, 'popularity') == 0) {
        //UPDATE ITEMCOUNT?
//        executePlainSQL("drop table itemCount");
//        executePlainSQL("create view itemCount as
//select bl_item_id, COUNT(*) as items
//from bucket_list_contains
//group by bl_item_id");
//        OCICommit($db_conn);
        $result = executePlainSQL("select b.name, e.event_start, e.event_end, b.price, b.location, b.points_value
FROM bucket_list_event e, bucket_list_item b LEFT OUTER JOIN itemCount i
ON b.bl_item_id = i.bl_item_id
WHERE b.bl_item_id = e.event_item_id
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND '${startDate}' <= e.event_start
AND e.event_end <= '${endDate}'
order by i.items DESC NULLS LAST
");
    } else if (strcmp($sortBy, 'recentlyAdded') == 0) {
$result = executePlainSQL("select b.name, e.event_start, e.event_end, b.price, b.location, b.points_value
FROM bucket_list_item b, bucket_list_event e, items i
WHERE b.bl_item_id = e.event_item_id
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND '${startDate}' <= e.event_start
AND e.event_end <= '${endDate}'
AND b.bl_item_id = i.bl_item_id
order by i.modifiedlast DESC
        ");
    } else {
     $result = executePlainSQL("select b.name, e.event_start, e.event_end, b.price, b.location, b.points_value
FROM bucket_list_item b, bucket_list_event e
WHERE b.bl_item_id = e.event_item_id
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND '${startDate}' <= e.event_start
AND e.event_end <= '${endDate}'
ORDER BY ${sortBy}
        ");
    }} else
        {
        echo "<script>console.log('Show all.')</script>";
        $result = executePlainSQL("select b.name, e.event_start, e.event_end, b.price, b.location, b.points_value
FROM bucket_list_item b, bucket_list_event e
Where b.bl_item_id = e.event_item_id
        ");
    }
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
