# bucket_list_304

LIVE LINK:
[http://www.ugrad.cs.ubc.ca/~k7c1b/bucketlist]

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

The following command is to execute the init SQL when you are in the project directory:
`start bucketlist`

## DEV NOTES
TODO:
- index.php
    - "recommended" section, for logged in users? or just put in the user page?
- admin.php
- user.php
- request.php (not yet created)
- click to view more details about particular item? need to make a php page for this?

ICEBOX:
- add picture links to bucketlist items
- price range: enforce min < max
- food: look into multiple select dietary restrictions, input type="checkbox" but would need to change database schema
- same for activity: days of week scheduled

    
OTHER NOTES: 
- 404.html may not be necessary