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
                    <li><a href="#"><img src="images/header/1.jpg" /></a></li>
                </ul>
            </div>
            <div class="container custom-controls">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="slider-helper">
                            <ul class="clean-list">
                                <li class="text-white text-center">
                                    <h1 class="font-3x font-40">Want to go on an adventure?</h1>
                                    <p class="darken font-100 welcome-mess">Let's try something new.</p>
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
                    <form id="filterform" method="post" action="food.php" class="row no-padding">
                        <!--                <input type="hidden" name="sub" value="book" />-->

                        <div class="col-md-3 col-sm-4">
                            <label for="food-item">Price Max</label>
                            <i class="fa fa-usd"></i>
                            <input type="number" value="100000" name="priceMax" id="priceMax" min="0" required />
                            <!--                                    max="500"-->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <label for="food-item">Price Min</label>
                            <i class="fa fa-usd"></i>
                            <input type="number" value="0" name="priceMin" id="priceMin" min="0" max="priceMax" required />
                            <!--                                    max="500"-->
                        </div>

                        <div class="col-md-3 col-sm-4">
                            <label for="food-item">Dietary Restrictions</label>
                            <select id="restrictions" name="restrictions">
                                <option value="none">None</option>
                                <option value="vegan">Vegan</option>
                                <option value="veggie">Vegetarian</option>
                                <option value="glutenFree">Gluten-Free</option>
                                <!-- 
                                          <option value="nutFree">Peanut-Free</option>
                                          <option value="kosher">Kosher</option>
                                        -->
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
                            </select>
                        </div>

                        <div class="col-md-12 col-sm-4" style="text-align:center;">
                            <br>
                            <button type="submit" name="search" class="button-md orange hover-dark-orange soft-corners">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        ///////////////////////////
    

<p>If you wish to reset the table, press the reset button. 
   If this is the first time that you're running this page,
   you MUST use reset.</p>

<form method="POST" action="food.php"> 
   <p><input type="submit" value="Reset" name="reset"></p>
</form>

<p>Insert values into tab1 below:</p>
<p><font size="2"> Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Favourite Colour</font></p>
<form method="POST" action="oracle-test1.php">
<!-- refreshes page when submitted -->

   <p><input type="text" name="insNo" size="6"><input type="text" name="insName" 
size="15"><input type="text" name="insColour" 
size="6">
<!-- Define three variables to pass values. -->    
<input type="submit" value="insert" name="insertsubmit"></p>
</form>

<!-- Create a form to pass the values.  
     See below for how to get the values. --> 

<p> Update the name by inserting the old and new values below: </p>
<p><font size="2"> Old Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
New Name</font></p>
<form method="POST" action="oracle-test1.php">
<!-- refreshes page when submitted -->

   <p><input type="text" name="oldName" size="6"><input type="text" name="newName" 
size="18">
<!-- Define two variables to pass values. -->
      
<input type="submit" value="update" name="updatesubmit"></p>


<!-- Other update field. -->
<p> Update the favourite colour of a customer, given their ID#: </p>
<p><font size="2"> Customer ID#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
New Favourite Colour</font></p>
<form method="POST" action="oracle-test1.php">
<!-- refreshes page when submitted -->

   <p><input type="text" name="id" size="6"><input type="text" name="newColour" 
size="18">
<!-- Define two variables to pass values. -->
      
<input type="submit" value="update" name="updatesubmit1"></p>
</form>

<p> Delete all tuples that have the following favourite colour: </p>
<p><font size="2"> Colour To Be Erased From the World</font></p>
<form method="POST" action="oracle-test1.php">
<!-- refreshes page when submitted -->
   <p><input type="text" name="deleteColour" size="24">
      
<input type="submit" value="delete" name="deleteSubmit"></p>
<!--
<input type="submit" value="run hardcoded queries" name="dostuff"></p>
</form>
-->


<html>
<style>
    table {
        width: 20%;
        border: 1px solid black;
    }

    th {
        font-family: Arial, Helvetica, sans-serif;
        font-size: .7em;
        background: #666;
        color: #FFF;
        padding: 2px 6px;
        border-collapse: separate;
        border: 1px solid #000;
    }

    td {
        font-family: Arial, Helvetica, sans-serif;
        font-size: .7em;
        border: 1px solid #DDD;
        color: black;
    }
</style>
</html>



<?php

require('parse-sql.php'); 
$success = True;
$db_conn = OCILogon("ora_k7c1b", "a20470150", 
                    "dbhost.ugrad.cs.ubc.ca:1522/ug");

function printResult($result) { //prints results from a select statement
	echo "<br>Got data from table tab1:<br>";
	echo "<table>";
	echo "<tr><th>ID</th><th>Name</th></tr>";

	while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
		echo "<tr><td>" . $row["NID"] . "</td><td>" . $row["NAME"] . "</td><td>" . $row["FAVCOLOUR"] . "</td></tr>"; //or just use "echo $row[0]" 
	}
	echo "</table>";
}

function printTable($resultFromSQL, $namesOfColumnsArray)
{
    echo "<br>Here is the output, nicely formatted:<br>";
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

	if (array_key_exists('reset', $_POST)) {
        $result = executePlainSQL("select * from bucket_list_item");
		/*printResult($result);*/
           /* next two lines from Raghav replace previous line */
           $columnNames = array("Customer ID#", "First Name", "Favourite Colour");
           printTable($result, $columnNames);

	} else
		if (array_key_exists('insertsubmit', $_POST)) {
			// Get values from the user and insert data into 
                // the table.
			$tuple = array (
				":bind1" => $_POST['insNo'],
				":bind2" => $_POST['insName'],
				":bind3" => $_POST['insColour']
			);
			$alltuples = array (
				$tuple
			);
			executeBoundSQL("insert into tab1 values (:bind1, :bind2, :bind3)", $alltuples);
			OCICommit($db_conn);

		} else
			if (array_key_exists('updatesubmit', $_POST)) {
				// Update tuple using data from user
				$tuple = array (
					":bind1" => $_POST['oldName'],
					":bind2" => $_POST['newName']
				);
				$alltuples = array (
					$tuple
				);
				executeBoundSQL("update tab1 set name=:bind2 where name=:bind1", $alltuples);
				OCICommit($db_conn);

			} else
				if (array_key_exists('updatesubmit1', $_POST)) {
				// Update tuple using data from user
				$tuple = array (
					":bind1" => $_POST['id'],
					":bind2" => $_POST['newColour']
				);
				$alltuples = array (
					$tuple
				);
				executeBoundSQL("update tab1 set favColour=:bind2 where nid=:bind1", $alltuples);
				OCICommit($db_conn);

			} else
				if (array_key_exists('deleteSubmit', $_POST)) {
				// Update tuple using data from user
				$tuple = array (
					":bind1" => $_POST['deleteColour'],
				);
				$alltuples = array (
					$tuple
				);
				executeBoundSQL("delete from tab1 where favColour=:bind1", $alltuples);
				OCICommit($db_conn);

			} else
				if (array_key_exists('dostuff', $_POST)) {
					// Insert data into table...
					// executePlainSQL("insert into tab1 values (10, 'Frank', 'Orange')");
					// Insert data into table using bound variables
					$list1 = array (
						":bind1" => 6,
						":bind2" => "All",
						":bind3" => "Red"
					);
					$list2 = array (
						":bind1" => 7,
						":bind2" => "John",
						":bind3" => "Chartruse"
					);
					$allrows = array (
						$list1,
						$list2
					);
					executeBoundSQL("insert into tab1 values (:bind1, :bind2, :bind3)", $allrows); //the function takes a list of lists
		// Update data...
		//executePlainSQL("update tab1 set nid=10 where nid=2");
		// Delete data...
		//executePlainSQL("delete from tab1 where nid=1");
		OCICommit($db_conn);
		}

	if ($_POST && $success) {
		//POST-REDIRECT-GET -- See http://en.wikipedia.org/wiki/Post/Redirect/Get
		header("location: oracle-test1.php");
	} else {
		// Select data...
		$result = executePlainSQL("select * from tab1");
		/*printResult($result);*/
           /* next two lines from Raghav replace previous line */
           $columnNames = array("Customer ID#", "First Name", "Favourite Colour");
           printTable($result, $columnNames);
	}

	//Commit to save changes...
	OCILogoff($db_conn);
} else {
	echo "cannot connect";
	$e = OCI_Error(); // For OCILogon errors pass no handle
	echo htmlentities($e['message']);
}
?>


/////////////////////
            <?php include("footer.html");?>


</body>

</html>
