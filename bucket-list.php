require 'print-table.php'
require 'parse-sql.php'
require 'init-DB-Schema.php'

<p>If you wish to reset the table, press the reset button. 
   If this is the first time that you're running this page,
   you MUST use reset.</p>

<form method="POST" action="bucket-list.php"> 
   <p><input type="submit" value="Reset" name="reset"></p>
</form>

<p>Insert values into tab1 below:</p>
<p><font size="2"> Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Name</font></p>
<form method="POST" action="bucket-list.php">
<!-- refreshes page when submitted -->

   <p><input type="text" name="insNo" size="6"><input type="text" name="insName" 
size="18">
<!-- Define two variables to pass values. -->    
<input type="submit" value="insert" name="insertsubmit"></p>
</form>

<!-- Create a form to pass the values.  
     See below for how to get the values. --> 

<p> Update the name by inserting the old and new values below: </p>
<p><font size="2"> Old Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
New Name</font></p>
<form method="POST" action="bucket-list.php">
<!-- refreshes page when submitted -->

   <p><input type="text" name="oldName" size="6"><input type="text" name="newName" 
size="18">
<!-- Define two variables to pass values. -->
      
<input type="submit" value="update" name="updatesubmit"></p>
<input type="submit" value="run hardcoded queries" name="dostuff"></p>
</form>


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

/* This tells the system that it's no longer just parsing 
   HTML; it's now parsing PHP. */

// keep track of errors so it redirects the page only if
// there are no errors
$success = True;
$db_conn = OCILogon("ora_m0q1b", "a57920456", 
                    "dbhost.ugrad.cs.ubc.ca:1522/ug");


// Connect Oracle...
if ($db_conn) {

	if (array_key_exists('reset', $_POST)) {
        
        initDBSchema();

	} else
		if (array_key_exists('insertsubmit', $_POST)) {
			// Get values from the user and insert data into 
                // the table.
			$tuple = array (
				":bind1" => $_POST['insNo'],
				":bind2" => $_POST['insName']
			);
			$alltuples = array (
				$tuple
			);
			executeBoundSQL("insert into tab1 values (:bind1, :bind2)", $alltuples);
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
				if (array_key_exists('dostuff', $_POST)) {
					// Insert data into table...
					executePlainSQL("insert into tab1 values (10, 'Frank')");
					// Insert data into table using bound variables
					$list1 = array (
						":bind1" => 6,
						":bind2" => "All"
					);
					$list2 = array (
						":bind1" => 7,
						":bind2" => "John"
					);
					$allrows = array (
						$list1,
						$list2
					);
					executeBoundSQL("insert into tab1 values (:bind1, :bind2)", $allrows); //the function takes a list of lists
		OCICommit($db_conn);
		}

	if ($_POST && $success) {
		header("location: bucket-list.php");
	} else {
		$result = executePlainSQL("select * from tab1");
           $columnNames = array("Customer ID#", "First Name");
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

