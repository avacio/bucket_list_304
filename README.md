# bucket_list_304

LIVE LINK:
[http://www.ugrad.cs.ubc.ca/~k7c1b/bucketlist]

## Background
Wake up. Drink coffee. Go to the library. Eat a bowl of cup noodles. Sleep. Repeat.
In 2019, it is all too easy to fall into a routine — it’s necessary even, in order to survive the daily grind. We fall into the same old comfortable habits, although there are always things that each of us want to try before dying.

With *Bucket List*, we aim to present unique experiences from all over the world! It may recommend everything from curious food items (e.g. cheese bubble tea), to events that you never knew existed, but now know you needed (e.g. rave hiking). The goal of the project is to help users try new things, as it is when we are out of our comfort zones, that we truly learn the most.

Are you ready for an adventure?

## Setup
### In php local servers
To test the site locally, PHP local servers are a good option.
You can run the following to test in your browser:
`php -S localhost:8000`

### In the cs.ubc servers

When moving the project to the UGRAD servers you may have to change the permissions. You can do this my running the following in your terminal:
`find [INSERT FOLDER NAME] -type f -exec chmod 755 {} \;`

The following command is for using backspace as delete in SQL:
`!stty erase ^H`

The following command is to execute the init SQL when you are in the project's sql directory:
`start bucketlist`

## Login
### User
>User: hauntingsjapan  
>Password: password

### Admin
>User: test  
>Password: test

Both are hard-coded right now so these will remain the logins to the pages, even if their passwords are changed in the database.
(Hard-coded in scripts.js)


## DEV NOTES

IF CONTINUING AFTER DEADLINE:
- request change to existing item
- click to view more details about particular item? need to make a php page for this?
- actually add items to bucketlists
- list control
- user.php, admin.php
    - hardcoded login details (not connected to database yet)
- admin.php
    - control item requests
- social aspect
    - friends, and competing

ICEBOX (extension ideas):
- add picture links to bucketlist items
- price range: enforce min < max
- food: look into multiple select dietary restrictions, input type="checkbox" but would need to change database schema
- same for activity: days of week scheduled

OTHER NOTES: 
- 404.html may not be necessary