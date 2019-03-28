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


    <script type="text/javascript" charset="utf8" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.1.2/css/buttons.dataTables.min.css" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.print.min.js"></script>

</head>


<body>

    <?php $userID = $_GET['user_username']; 
    echo "<script>console.log( 'userID: ' + '${userID}')</script>";
//        $searchName = "%${searchName}%";
    ?>

    <?php
    require('parse-sql.php'); 
$success = True;
$db_conn = OCILogon("ora_k7c1b", "a20470150", 
                    "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
//    $result = executePlainSQL("select g.points - c.points
//from goals g, consumerpoints c
//");
//    while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
//        $pointsToGo .= "" . $row[0] . "";
//    }
    ?>

    <!-- Top Header / Header Bar -->
    <div id="home" class="boxed-view">
        <?php include("header.html");?>
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
                                <li class="text-yellow text-center">
                                    <h1 class="font-3x font-40">
                                        <!--                                        <?php echo "@" . $userID . "<br>";?>-->
                                        @test
                                    </h1>
                                    <p class="darken font-300 welcome-mess">
                                        <!--                                        Let's try something new.--> <!--  Points Left To Reach Your Goal:
                                        <?php echo "" . $pointsToGo . "<br>";?>--> 
                                        ADMIN
                                    </p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>



    <div class="viewlist" align='center'>
        <p>
            <!--
    <button type ="button" onclick="toggleView('reserve')">Reservations</button>
    <button type ="button" onclick="toggleView('cust')">Customers</button>
    <button type ="button" onclick="toggleView('room')">Rooms</button>
	<button type ="button" onclick="toggleView('hotel')">Hotel Information</button>
-->
            <a href="#changePW" class="btn button-sm orange hover-dark-orange soft-corners">Change Password</a>
            <button class="btn button-sm orange hover-dark-orange soft-corners" onClick="window.location='index.php'">Log Out</button>
        </p>
    </div>

    <?php 
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
    
    $userID = "test"; // TODO USER STUB
}
?>
<!--
    <br>
    <div class="text-yellow text-center fancy-heading">
        <h3 class="font-600">Recommended for You</h3>
        <p>Top 5 items based on your history</p>
    </div>
-->
    <?php
if ($db_conn) {

$result = executePlainSQL("select * from (select bli.name, bli.price, bli.description, bli.link, bli.location, bli.points_value from bucket_list_item bli 
where rownum <= 5
AND bli.bl_item_id NOT IN ((SELECT * FROM allFood af) UNION (SELECT * FROM allEvents ae) UNION (SELECT * FROM allActivities aa))
ORDER BY dbms_random.value)
");
    
//    printTable($result, $columnNames);
}
 ?>
<!--
    <br><br>

    <div class="text-yellow text-center fancy-heading">
        <h3 class="font-600">Birds of a Feather.</h3>
        <p>Things your friends are into, but you're not (yet).</p>
    </div>
-->
    <?php
if ($db_conn) {

$result = executePlainSQL("select bli.name, bli.price, bli.description, bli.link, bli.location, bli.points_value
from bucket_list_item bli
where bli.bl_item_id IN
(select * 
from japanFriends jf
where NOT EXISTS (
select *
from japan j
where jf.bl_item_id = j.bl_item_id))

");
    
//    printTable($result, $columnNames);
} ?>
<!--
    <br><br>
    <div class="text-yellow text-center fancy-heading">
        <h3 class="font-600">Mix it Up.</h3>
        <p>These items are not in any of your lists.</p>
    </div>
-->

    <?php
    if ($db_conn) {
$result = executePlainSQL("select bl.name, bl.price, bl.description, bl.link, bl.location, bl.points_value
from bucket_list_item bl
where bl.bl_item_id NOT IN 
	(select c.bl_item_id 
	from bucket_list_contains c
	where c.list_id IN 
		(select u.list_id
		from user_has_bucket_list u
		where u.consumer_username = 'hauntingsjapan'))
");
//    printTable($result, $columnNames);

	OCILogoff($db_conn);
} else {
	echo "cannot connect";
	$e = OCI_Error(); // For OCILogon errors pass no handle
	echo htmlentities($e['message']);
}
?>

    <script>
        //  $(function(){
        //    $('#employ1').dataTable({
        //		order: []
        //	});
        //	$('#employ2').dataTable({
        //		order: []
        //	});
        //	$('#employ3').dataTable({
        //		order: [],
        //		"columnDefs":[
        //		{
        //			"targets": [4],
        //			"visible": false,
        //			"searchable": false
        //		}
        //		]
        //	});
        //	$('#employ4').dataTable({
        //		order: []	
        //	});
        //	
        //	$('#employ5').dataTable({
        //		order: []	
        //	});
        //  })

        function toggleView(id) {
            //		$('.alltable').hide();
            $('#' + id).show();
        }
        $('.alltable').hide();
        $('#reserve').show();
        $('#resultbestcust').hide();


        $('#importantcust').click(function() {
            $('#resultbestcust').toggle();
        })

    </script>

    <br><br>
    <div class="text-yellow text-center fancy-heading" id="changePW">
        <h3 class="font-600">Change Password</h3>
        <!--                <p>These items are not in any of your lists.</p>-->
        <form method="POST" action="user.php#changePW">
            <label for="userpw">Old Password</label>

            <p><input type="text" name="oldPW" size="8">
                <label for="userpw">New Password</label>
                <input type="text" name="newPW" size="8">
                <input type="submit" value="Update" name="updateChangePW" btn button-sm orange hover-dark-orange soft-corners></p>
        </form>
    </div>

    <?php
    if ($db_conn) {

	if (array_key_exists('updateChangePW', $_POST)) {
		$result = executePlainSQL("Select consumer_password FROM consumer
WHERE consumer_username = '${userID}'
");
        while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
        $origPW .= "$row[0]";
    }
        $enteredOld = $_POST['oldPW'];
        $enteredNew = $_POST['newPW'];
        
        if (strcmp($enteredOld, $origPW) == 0) {

            if (strcmp($enteredNew, '') == 0) {                         echo "<br> Invalid new password.";
 } else {
            executePlainSQL("Update consumer set consumer_password = '${enteredNew}'
WHERE consumer_username = '${userID}'
");
                        echo "<br> Password changed.";
                    echo "<script>console.log( 'Password changed to: ' + '${enteredNew}')</script>";

            }
} else { 
         echo "<br> Wrong password entered.";
        }
		OCICommit($db_conn);

	}
    	OCILogoff($db_conn);
    }
    ?>
    <?php include("footer.html");?>

</body>

</html>
