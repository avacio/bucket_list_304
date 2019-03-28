<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
  <meta charset="UTF-8">
  <title>BucketList</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font-->
  <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900' >

  <!-- Stylesheets -->
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  <link rel="stylesheet" type="text/css" media="all" href="css/template.css" >
  <link rel="stylesheet" type="text/css" media="all" href="css/magnific-popup.css" >
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
			    	<li><a href="#"><img src="images/header/1.jpg"/></a></li>
			    </ul>
			</div>
			<div class="container custom-controls">
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<div class="slider-helper">
							<ul class="clean-list">
								<li class="text-yellow text-center">
									<h1 class="font-3x font-40">Want to go on an adventure?</h1>
									<p class="darken font-100 welcome-mess">Let's try something new.</p>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>


 <section class="box">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="text-white text-center fancy-heading">
							<h1 class="font-700">Featured Items</h1>
              <hr class="text-white size-30 center-me">
						</div>
					</div>
				</div> 
     </div></section></div>
	

        <?php
    require('parse-sql.php'); 
$success = True;
$db_conn = OCILogon("ora_k7c1b", "a20470150", 
                    "dbhost.ugrad.cs.ubc.ca:1522/ug");

function printTable($resultFromSQL, $namesOfColumnsArray)
{
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

// Connect Oracle...
if ($db_conn) {
    echo "<script>console.log( 'Connected to Oracle.')</script>";
    $columnNames = array("Name", "Price ($)", "Description", "Link", "Location", "Points");
}
?>
    
          <div class="text-yellow text-center fancy-heading">
							<h3 class="font-600">Be a trendsetter.</h3>
                <p>These items are not in any bucketlists.</p>
						</div>
        <?php
if ($db_conn) {

$result = executePlainSQL("SELECT bli.name, bli.price, bli.description, bli.link, bli.location, bli.points_value
from bucket_list_item bli
where NOT EXISTS 
(select *
from user_bucket_list_items ubli
where bli.bl_item_id = ubli.bl_item_id)
");
    
    printTable($result, $columnNames);}
 ?>   
    <br><br>
              <div class="text-yellow text-center fancy-heading">
							<h3 class="font-600">Tried and tested.</h3>
                <p>These items are the most popular.</p>
						</div>

        <?php
    if ($db_conn) {
$result = executePlainSQL("select bli.name, bli.price, bli.description, bli.link, bli.location, bli.points_value
from bucket_list_item bli
where bli.bl_item_id IN 
(select bl_item_id
from bucket_list_contains
group by bl_item_id
having count(*) = 
(select max(items) 
from itemCount))
");
    printTable($result, $columnNames);
    }
    ?>
    
    <section class="box">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="text-white text-center fancy-heading">
							<h1 class="font-700">Featured Users</h1>
              <hr class="text-white size-30 center-me">
						</div>
					</div>
				</div> 
     </div></section>
     <div class="text-yellow text-center fancy-heading">
							<h3 class="font-600">The hungriest.</h3>
                <p>Users that have listed all food items.</p>
						</div>
         <?php
    if ($db_conn) {
$result = executePlainSQL("SELECT c.consumer_username
FROM consumer c
WHERE NOT EXISTS (
	(SELECT blf.food_item_id
	 FROM bucket_list_food blf)
	EXCEPT
	(SELECT blc.bl_item_id
	 FROM bucket_list_contains blc, user_has_bucket_list uhbl,
	 WHERE blc.list_id = uhbl.list_id AND uhbl.consumer_username = c.consumer_username
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