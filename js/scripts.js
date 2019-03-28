
var dateToday = new Date();

$(function() {
 $("#start-date").datepicker({
      minDate: dateToday,
//      dateFormat: "y-M-dd",
     dateFormat: "dd-M-y",
  
      onSelect: function(){
          var enddate = $('#end-date');
          var startdate = $(this).datepicker('getDate');
          console.log("Start Date: " + startdate);

          //set Departure's minDate = Arrival Date + 1
          startdate.setDate(startdate.getDate() + 1);
          console.log("Starts's Min: " + startdate);
          enddate.datepicker("option", "minDate", startdate);
        }
    });

 $("#end-date").datepicker({
//      dateFormat: "y-M-dd",
          dateFormat: "dd-M-y",
      minDate: dateToday,
  });
});

// USER LOGIN
$(document).ready(function() {
  $('.popup-with-form').magnificPopup({
    type: 'inline',
    preloader: false,
    focus: '#userid',

    callbacks: {
      beforeOpen: function() {
        if($(window).width() < 700) {
          this.st.focus = false;
        } else {
          this.st.focus = '#userid';
        }
      }
    }
  });
});


$(document).ready(function() {
  $('#userlogin').submit(function(event) {
      event.preventDefault();

      var userID = $('#user_username').val();
      var userPW = document.getElementById('user_password').value;

      console.log('Username: '+ userID);
      console.log(userPW);

// TODO CHECK USER WITH DATABASE
      if (userID == 'hauntingsjapan') {
        if (userPW == 'password'){
          location="user.php";
        } else {
          document.forms["userlogin"].reset();
          alert ("Incorrect password.");
        }
      } else {
          document.forms["userlogin"].reset();
          alert ("User ID does not exist.");
      }
    
  });
});


// ADMIN LOGIN
$(document).ready(function() {
  $('.popup-with-form').magnificPopup({
    type: 'inline',
    preloader: false,
    focus: '#adminid',

    callbacks: {
      beforeOpen: function() {
        if($(window).width() < 700) {
          this.st.focus = false;
        } else {
          this.st.focus = '#adminid';
        }
      }
    }
  });
});


$(document).ready(function() {
  $('#adminlogin').submit(function(event) {
      event.preventDefault();

      var adminID = $('#admin_username').val();
      var adminPW = document.getElementById('admin_password').value;

      console.log('Admin Username: '+ adminID);
      console.log(adminPW);

// TODO CHECK USER WITH DATABASE
      if (adminID == 'test') {
        if (adminPW == 'test'){
          location="admin.php";
        } else {
          document.forms["adminlogin"].reset();
          alert ("Incorrect password.");
        }
      } else {
          document.forms["adminlogin"].reset();
          alert ("Admin ID does not exist.");
      }
    
  });
});