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
                    <li><a href="#"><img src="images/header/2.jpg" /></a></li>
                </ul>
            </div>
            <div class="container custom-controls">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="slider-helper">
                            <ul class="clean-list">
                                <li class="text-white text-center">
                                    <h1 class="font-3x font-40">Stay hungry, stay foolish.</h1>
                                    <p class="darken font-100 welcome-mess">Food is not rational. Food is culture, habit, craving and identity. -- Jonathan Safran Foer</p>
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
                    <form id="filterform" method="get" action="food.php" class="row no-padding">
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

                        <div class="col-md-3 col-sm-4">
                            <label for="location">Location</label>
                            <i class="fa fa-location-arrow"></i>
                            <input type="text" value="Any" name="location" id="location" />
                        </div>

                        <div class="col-md-2 col-sm-4">
                            <label for="food-item">Dietary Restrictions</label>
                            <select id="restrictions" name="restrictions">
                                <option value="none">None</option>
                                <option value="vegan">Vegan</option>
                                <option value="veggie">Vegetarian</option>
                                <option value="glutenFree">Gluten-Free</option>
                                <option value="nutFree">Nut-Free</option>
                                <option value="dairyfree">Dairy-Free</option>
                                <option value="kosher">Kosher</option>
                            </select>
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <label for="food-item">Sort by</label>
                            <select id="sortBy" name="sortBy">
                                <option value="popularity">Popularity</option>
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
                            <form method="POST" action="food.php">
                                <button type="submit" name="search" class="button-md orange hover-dark-orange soft-corners">Filter</button>
                            </form>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <br><br>
                            </li>
                            </form>
        
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


$priceMax = $_GET['priceMax'];
$priceMin = $_GET['priceMin'];
$location = $_GET['location'];
$restrictions = $_GET['restrictions'];
$sortBy = $_GET['sortBy'];

if (strcmp($location, 'Any') == 0) {
	$location = '%';
} else { $location = "%${location}%"; }

echo "<script>console.log( 'priceMax: ' + '${priceMax}'
+ ', priceMin: ' + '${priceMin}' + ', location: ' + '${location}'
+ ', restrictions: ' + '${restrictions}'
+ ', sortBy: ' + '${sortBy}')</script>";
        
if (strcmp($restrictions, 'none') == 0) {
	$restrictions = '%';
} else if (strcmp($restrictions, 'veggie') == 0) {
	$restrictions = 0;
} else if (strcmp($restrictions, 'vegan') == 0) {
	$restrictions = 1;
} else if (strcmp($restrictions, 'glutenFree') == 0) {
	$restrictions = 2;
} else if (strcmp($restrictions, 'dairyFree') == 0) {
	$restrictions = 3;
} else if (strcmp($restrictions, 'nutFree') == 0) {
	$restrictions = 4;
}
                
if (strcmp($sortBy, 'priceAsc') == 0) {
	$sortBy = "b.price ASC";
} else if (strcmp($sortBy, 'priceDesc') == 0) {
	$sortBy = "b.price DESC";
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
    $columnNames = array("Name", "Price ($)", "Link", "Location", "Restrictions", "Points");
    
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
        $result = executePlainSQL("select b.name, b.price, b.link, b.location, fr.restriction, b.points_value
FROM bucket_list_food f, food_restrictions fr, bucket_list_item b LEFT OUTER JOIN itemCount i
ON b.bl_item_id = i.bl_item_id
WHERE b.bl_item_id = f.food_item_id
AND fr.restriction_id = f.restrictions
AND f.restrictions LIKE '${restrictions}'
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
order by i.items DESC NULLS LAST
");
    } else if (strcmp($sortBy, 'recentlyAdded') == 0) {
$result = executePlainSQL("select b.name, b.price, b.link, b.location, fr.restriction, b.points_value
FROM bucket_list_item b, bucket_list_food f, food_restrictions fr, items i
WHERE b.bl_item_id = f.food_item_id
AND fr.restriction_id = f.restrictions
AND f.restrictions LIKE '${restrictions}'
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND b.bl_item_id = i.bl_item_id
order by i.modifiedlast DESC
        ");
    } else {
     $result = executePlainSQL("select b.name, b.price, b.link, b.location, fr.restriction, b.points_value
FROM bucket_list_item b, bucket_list_food f, food_restrictions fr
WHERE b.bl_item_id = f.food_item_id
AND fr.restriction_id = f.restrictions
AND f.restrictions LIKE '${restrictions}'
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
ORDER BY ${sortBy}
        ");
    }} else
        {
        echo "<script>console.log('Show all.')</script>";
        $result = executePlainSQL("select b.name, b.price, b.link, b.location, fr.restriction, b.points_value
FROM bucket_list_item b, bucket_list_food f, food_restrictions fr
Where b.bl_item_id = f.food_item_id
AND fr.restriction_id = f.restrictions
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
