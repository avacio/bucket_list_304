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
              <form id="filterform" method="post" action = "food.php" class="row no-padding">
<!--                <input type="hidden" name="sub" value="book" />-->
				
                  <div class = "col-md-3 col-sm-4">
									<label for="food-item">Price Max</label>
     								<i class="fa fa-usd"></i>
      								<input type="number" value="100000" name="priceMax" id="priceMax" min="0" required/>
<!--                                    max="500"-->
      							</div>
                  
								<div class = "col-md-3 col-sm-4">
									<label for="food-item">Price Min</label>
     								<i class="fa fa-usd"></i>
      								<input type="number" value="0" name="priceMin" id="priceMin" min="0" max="priceMax" required/>
<!--                                    max="500"-->
      							</div>
      							
      							<div class = "col-md-3 col-sm-4">
      								  <label for="food-item">Dietary Restrictions</label>
								      <select id="restrictions" name="restrictions">
                                          <option value="none">None</option>
								        <option value="vegan">Vegan</option>
								        <option value="veggie">Vegetarian</option>
                                           <option value="glutenfree">Gluten-Free</option>
                                          <!-- 
                                          <option value="nutfree">Peanut-Free</option>
                                          <option value="kosher">Kosher</option>
                                        -->
								      </select> 
      							</div>

      							<div class = "col-md-3 col-sm-4">
      							  <label for="food-item">Sort by</label>
							      <select id="sortby" name="sortby">
                                       <option value="popularity">Popularity</option>
                                     <option value="recentlyAdded">Recently Added</option>
							        <option value="priceAsc">Price: Low -> High</option>
                                      <option value="priceDesc">Price: High -> Low</option>
							        <option value="pointsAsc">Points: Low -> High</option>
                                        <option value="pointsDesc">Points: High -> Low</option>
							      </select>      								
      							</div>

								<div class = "col-md-12 col-sm-4" style="text-align:center;">
									<br>
									<button type="submit" name="search" class="button-md orange hover-dark-orange soft-corners">Search</button>
								</div>
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
                            
                            
						</div>
					</div>
				</div>

<?php include("footer.html");?>



</body>
</html>