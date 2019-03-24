function initDBSchema()
{
    // Create new table...
    echo "<br> creating new table <br>";
    executePlainSQL("create table BUCKET_LIST_ITEM (
                        bl_item_id int,
                        price decimal,
                        description varchar2(140),
                        location varchar2(40),
                        points_value int,
                        PRIMARY KEY (bl_item_id)
                        )
                    ");
    executePlainSQL("create table FOOD (
                        food_item_id int,
                        restrictions varchar2(20),
                        nutrition varchar2(20),
                        PRIMARY KEY (food_item_id),
                        FOREIGN KEY (food_item_id) REFERENCES BUCKET_LIST_ITEM (bl_item_id) ON DELETE CASCADE
                        )
                    ");
    executePlainSQL("create table event (
                        event_item_id int,
                        event_start timestamp,
                        event_end timestamp,
                        PRIMARY KEY (event_item_id),
                        FOREIGN KEY (event_item_id) REFERENCES BUCKET_LIST_ITEM (bl_item_id) ON DELETE CASCADE
                        )
    
                    ");
    executePlainSQL("create table ACTIVITY (
                        activity_item_id int,
                        activity_start timestamp,
                        activity_end timestamp,
                        weekdays_scheduled varchar2(20),
                        PRIMARY KEY (activity_item_id),
                        FOREIGN KEY (activity_item_id) REFERENCES BUCKET_LIST_ITEM (bl_item_id) ON DELETE CASCADE
                        )
                    ");
    executePlainSQL("create table ADMIN (
                        admin_username varchar2(20),
                        password varchar2(20) NOT NULL,
                        PRIMARY KEY (admin_username)
                        )
                    ");
    executePlainSQL("create table CONSUMER (
                        consumer_username varchar2(20),
                        password varchar2(20) NOT NULL,
                        name varchar2(20),
                        points int DEFAULT(0),
                        email_address varchar2(20),
                        phone_number varchar2(15),
                        PRIMARY KEY (consumer_username)
                        )
                    ");
    executePlainSQL("create table IS_FRIEND_OF (
                        consumer_username varchar2(20),
                        friend_username varchar2(20),
                        PRIMARY KEY(consumer_username, friend_username),
                        FOREIGN KEY (consumer_username) REFERENCES CONSUMER (consumer_username),
                        FOREIGN KEY(friend_username) REFERENCES CONSUMER(consumer_username)
                        )
                    ");
    executePlainSQL("create table CREATES_MODIFIES_ITEM (
                        bl_item_id int,
                        admin_username varchar2(20),
                        request_id int,
                        date DATE,
                        PRIMARY KEY (bl_item_id, request_id),
                        FOREIGN KEY (bl_item_id) references BUCKET_LIST_ITEM,
                        FOREIGN KEY (admin_username) REFERENCES ADMIN,
                        FOREIGN KEY (request_id) REFERENCES ITEM_REQUEST_REQUESTS
                        )
                    ");
    executePlainSQL("create table ITEM_REQUEST_REQUESTS (
                        request_id int,
                        bl_item_id int,
                        type varchar2(10),
                        name varchar2(20),
                        description varchar2(140),
                        contact_info varchar2(50),
                        date date,
                        consumer_username varchar2(20),
                        is_evaluated int,
                        PRIMARY KEY (request_id),
                        FOREIGN KEY (bl_item_id) REFERENCES BUCKET_LIST_ITEM,
                        FOREIGN KEY (consumer_username) REFERENCES CONSUMER)
                        )
                    ");
    executePlainSQL("create table GOAL_SETS(
                        consumer_username varchar2(20),
                        achieve_by_date date,
                        points int DEFAULT(0),
                        is_achieved int,
                        PRIMARY KEY (consumer_username, achieve_by_date),
                        FOREIGN KEY (consumer_username) REFERENCES CONSUMER
                        )
                    ");
    executePlainSQL("create table USER_HAS_BUCKET_LIST(
                        list_id int,
                        percent_completed int DEFAULT(0),
                        privacy_level int DEFAULT(0),
                        consumer_username varchar2(20),
                        PRIMARY KEY (list_id),
                        FOREIGN KEY (consumer_username) REFERENCES CONSUMER)
                        )
                    ");
    executePlainSQL("create table BUCKET_LIST_CONTAINS(
                        list_id int,
                        bl_item_id int,
                        PRIMARY KEY (list_id, bl_item_id),
                        FOREIGN KEY (list_id) REFERENCES USER_HAS_BUCKET_LIST,
                        FOREIGN KEY (bl_item_id) REFERENCES BUCKET_LIST_ITEM
                        )
                    ");
    executePlainSQL("create table USER_HAS_BUCKET_LIST(
                        list_id int,
                        percent_completed int DEFAULT(0),
                        privacy_level int DEFAULT(0),
                        consumer_username varchar2(20),
                        PRIMARY KEY (list_id),
                        FOREIGN KEY (consumer_username) REFERENCES CONSUMER)
                        )        
                    ");
    
    OCICommit($db_conn);
}