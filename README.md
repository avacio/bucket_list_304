# bucket_list_304

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
    - the home page, needs to be updated with "featured", "recommended" section
- admin.php
- user.php
- event.php, activity.php, food.php
    - food: look into multiple select dietary restrictions, not sure if possible with PHP
    - price range: enforce min < max
    - add location to search (input type field or select option?)
    - SORT BY POPULARITY AND RECENTLY ADDED
        - write SQL in the php (stubs right now)
- explore.php (not yet created)
    - search through all bl types? or list them or display most popular
- request.php (not yet created)
- header.html
    - "surprise me" query, "search" query only by name
    
OTHER NOTES: 
- 404.html may not be necessary