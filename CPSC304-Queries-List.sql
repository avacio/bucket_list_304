-----------------
-- QUERIES
-- Notes:
-- not all queries used are shown due to repetition or insignificance (only most meaningful queries are shown)
-- if this sql file is started within the database, it will likely get errors towards the end, since PHP variable syntax are shown

-------------------------------------------------------
-- Show ‘hauntingsjapan’ friends' bucket list items which aren’t in theirs 
CREATE VIEW japanFriends AS
SELECT blc.bl_item_id
FROM bucket_list_contains blc
WHERE blc.list_id IN
	(SELECT u.list_id
	FROM user_has_bucket_list u
	WHERE u.consumer_username IN
		(SELECT f.friend_username
		FROM is_friend_of f
		WHERE f.consumer_username = ‘hauntingsjapan’));

CREATE VIEW japan AS
SELECT blc.bl_item_id
FROM bucket_list_contains blc
WHERE blc.list_id IN 
	(SELECT u.list_id
	FROM user_has_bucket_list u
	WHERE u.consumer_username = ‘hauntingsjapan’);

SELECT *
FROM bucket_list_item bli
WHERE bli.bl_item_id IN
	(SELECT * 
	FROM japanFriends jf
	WHERE NOT EXISTS (
		SELECT *
		FROM japan j
		WHERE jf.bl_item_id = j.bl_item_id));

-- List the items that aren’t in any users bucket list (least popular)
CREATE VIEW user_bucket_list_items AS
SELECT * 
FROM bucket_list_item b
WHERE b.bl_item_id IN 
	(SELECT c.bl_item_id
	FROM bucket_list_contains c
	WHERE c.list_id IN 
		(SELECT u.list_id
		FROM user_has_bucket_list u));

SELECT * 
FROM bucket_list_item bli
WHERE NOT EXISTS 
	(SELECT *
	FROM user_bucket_list_items ubli
	WHERE bli.bl_item_id = ubli.bl_item_id);

-- Get bucket_list_item details that aren’t in user “widjaja”s list
SELECT * 
FROM bucket_list_item bl
WHERE bl.bl_item_id NOT IN 
	(SELECT c.bl_item_id 
	FROM bucket_list_contains c
	WHERE c.list_id IN 
		(SELECT u.list_id
		FROM user_has_bucket_list u
		WHERE u.consumer_username = ‘widjaja’));

-- Sort bucket list items by popularity
CREATE VIEW itemCount AS
SELECT bl_item_id, COUNT(*) AS items
FROM bucket_list_contains
GROUP BY bl_item_id;

SELECT bli.bl_item_id, bli.link, bli.name, bli.price, bli.description, bli.location, bli.points_value
FROM bucket_list_item bli LEFT OUTER JOIN itemCount i
ON bli.bl_item_id = i.bl_item_id
ORDER BY i.items DESC NULLS LAST;

-- Find the bucket list item that is the most popular
CREATE VIEW itemCount AS
SELECT bl_item_id, COUNT(*) AS items
FROM bucket_list_contains
GROUP BY bl_item_id;

SELECT *
FROM bucket_list_item bli
WHERE bli.bl_item_id IN 
	(SELECT bl_item_id
	FROM bucket_list_contains
	GROUP BY bl_item_id
	HAVING count(*) = 
		(SELECT max(items) 
		FROM itemCount));

-- Calculate how much more points are needed for the ‘cyberboy’s goal to be reached
CREATE VIEW goals AS
SELECT g.points 
FROM goal_sets g
WHERE g.consumer_username = ‘hauntingsjapan’

CREATE VIEW consumerpoints AS
SELECT c.points 
FROM consumer c
WHERE c.consumer_username = ‘hauntingsjapan’;

SELECT g.points - c.points AS pointsToGoal
FROM goals g, consumerpoints c

-- Generate a random item
SELECT * FROM (SELECT name, price, description, link, location, points_value FROM bucket_list_item ORDER BY dbms_random.value)
WHERE rownum <= 1;

-- Sort on entries by most recently added
CREATE VIEW items AS 
	SELECT irr.bl_item_id, MAX(ire.evaluated_date) AS modifiedlast
	FROM item_request_requests irr, item_request_evaluates ire
	WHERE ire.is_approved = 1 AND ire.request_id = irr.request_id
	GROUP BY irr.bl_item_id;

SELECT bli.link, bli.name, bli.description, bli.location, bli.points_value
FROM bucket_list_item bli, items i
WHERE bli.bl_item_id = i.bl_item_id
ORDER BY i.modifiedlast DESC;

-- Return top 5 items based on user “hauntingsjapan” historical interests
-- ** hardcoded views in database just for the user “hauntingsjapan” (if expanding project, may need to refactor to make more php-friendly)
DROP VIEW allFood;
DROP VIEW allEvents;
DROP VIEW allActivities;

CREATE VIEW allFood AS
SELECT blf.food_item_id
FROM bucket_list_food blf, user_has_bucket_list uhbl, bucket_list_contains blc, consumer c, goal_sets gs
WHERE gs.is_achieved = 1 AND gs.consumer_username = 'hauntingsJapan' AND blf.food_item_id = blc.bl_item_id AND uhbl.list_id = blc.list_id AND c.consumer_username = 'hauntingsJapan';

CREATE VIEW allEvents AS
SELECT ble.event_item_id
FROM bucket_list_event ble, user_has_bucket_list uhbl, bucket_list_contains blc, consumer c, goal_sets gs
WHERE gs.is_achieved = 1 AND gs.consumer_username = 'hauntingsJapan' AND ble.event_item_id = blc.bl_item_id AND uhbl.list_id = blc.list_id AND c.consumer_username = 'hauntingsJapan';

CREATE VIEW allActivities AS
SELECT bla.activity_item_id
FROM bucket_list_activity bla, user_has_bucket_list uhbl, bucket_list_contains blc, consumer c, goal_sets gs
WHERE gs.is_achieved = 1 AND gs.consumer_username = 'hauntingsJapan' AND bla.activity_item_id = blc.bl_item_id AND uhbl.list_id = blc.list_id AND c.consumer_username = 'hauntingsJapan';

SELECT * FROM (select bli.name, bli.price, bli.description, bli.link, bli.location, bli.points_value FROM bucket_list_item bli 
WHERE rownum <= 5
AND bli.bl_item_id NOT IN ((SELECT * FROM allFood af) UNION (SELECT * FROM allEvents ae) UNION (SELECT * FROM allActivities aa))
ORDER BY dbms_random.value);

-- Get password of user “hauntingsjapan”
SELECT consumer_password FROM consumer
WHERE consumer_username = ‘hauntingsjapan’;

-- UPDATE password of user “hauntingsjapan”
UPDATE consumer SET consumer_password = ‘test’
WHERE consumer_username = ‘hauntingsjapan’;

-- Find the usernames of consumers that have all the bucket list food items
SELECT c.consumer_username
FROM consumer c
WHERE NOT EXISTS 
	(SELECT * FROM 
	Bucket_list_food f
	WHERE NOT EXISTS 
		(SELECT u.consumer_username
		FROM bucket_list_contains bl, user_has_bucket_list u
		WHERE bl.bl_item_id = f.food_item_id AND u.consumer_username = c.consumer_username AND u.list_id = bl.list_id));

-- List all food items
-- queries for events and activities are similar so will not be listed
SELECT b.name, b.price, b.link, b.location, fr.restriction, b.points_value
FROM bucket_list_item b, bucket_list_food f, food_restrictions fr
WHERE b.bl_item_id = f.food_item_id
AND fr.restriction_id = f.restrictions

-- Get new requestID to use
SELECT max(request_id) + 1
FROM item_request_requests;

----------------------------------------------------------------------------
-- The following will show syntax from the php files, but variables should be self-explanatory

-- Get request info by request_id
SELECT r.request_id, r.consumer_username, r.requested_date, r.name, t.bl_type, r.description FROM item_request_requests r, bucket_list_type t
WHERE r.bl_type_id = t.bl_type_id AND
r.request_id = ${newRID};

-- Insert a request based on GUI input with empty username field
insert into item_request_requests values (${newRID}, null, ${type}, '${blname}', '${description}', '${theDate}', null, 0);

-- Check if username exists (return 1 if exists)
SELECT COUNT(1) FROM consumer, admin WHERE consumer_username='${username}' OR admin_username='${username}';

-- Insert a request based on GUI input with valid username
insert into item_request_requests values (${newRID}, null, ${type}, '${blname}', '${description}', '${theDate}', '${username}', 0);

-- Check if bl_item_id exists (return 1 if exists)
SELECT COUNT(1) FROM bucket_list_item WHERE bl_item_id=${BLID};

-- Delete bucket_list_item by ID
Delete from bucket_list_item
Where bl_item_id = ${BLID}

-- Search for all bl items with given case-sensitive search name (input is string)
-- sorted by popularity
SELECT b.name, b.price, b.description, b.link, b.location, b.points_value 
FROM bucket_list_item b LEFT OUTER JOIN itemCount i
ON b.bl_item_id = i.bl_item_id
WHERE b.name LIKE '%${searchName}%'
OR b.location LIKE '%${searchName}%'
OR b.description LIKE '%${searchName}%'
OR b.link LIKE '%${searchName}%'
ORDER BY i.items DESC NULLS LAST;

-- Search for all bl items with given case-sensitive search name (input is string of a valid int)
-- you can search by bl_item_id
-- sorted by popularity
SELECT b.name, b.price, b.description, b.link, b.location, b.points_value 
FROM bucket_list_item b LEFT OUTER JOIN itemCount i
ON b.bl_item_id = i.bl_item_id
WHERE b.name LIKE '%${searchName}%'
OR b.location LIKE '%${searchName}%'
OR b.description LIKE '%${searchName}%'
OR b.link LIKE '%${searchName}%'
OR b.bl_item_id = ${searchName}
ORDER BY i.items DESC NULLS LAST;

-- Filter events by price, date, location, and sorting preference
select b.name, e.event_start, e.event_end, b.price, b.link, b.location, b.points_value
FROM bucket_list_item b, bucket_list_event e
WHERE b.bl_item_id = e.event_item_id
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND '${startDate}' <= e.event_start
AND e.event_end <= '${endDate}'
ORDER BY ${sortBy};

-- Filter food items food restrictions, price, location, and sorting preference
select b.name, b.price, b.link, b.location, fr.restriction, b.points_value
FROM bucket_list_item b, bucket_list_food f, food_restrictions fr
WHERE b.bl_item_id = f.food_item_id
AND fr.restriction_id = f.restrictions
AND f.restrictions LIKE '${restrictions}'
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
ORDER BY ${sortBy};

-- Filter activities by location, price, date and sorting preference
select b.name, a.activity_start, a.activity_end, a.weekdays_scheduled, b.price, b.link, b.location, b.points_value
FROM bucket_list_item b, bucket_list_activity a
WHERE b.bl_item_id = a.activity_item_id
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND '${startDate}' <= a.activity_end
ORDER BY ${sortBy};

-- Sorting activities by recently added
-- Similar for food and event
select b.name, a.activity_start, a.activity_end, a.weekdays_scheduled, b.price, b.link, b.location, b.points_value
FROM bucket_list_item b, bucket_list_activity a, items i
WHERE b.bl_item_id = a.activity_item_id
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND '${startDate}' <= a.activity_end
order by i.modifiedlast DESC

-- Sorting events by popularity
-- Similar for food and event
select b.name, e.event_start, e.event_end, b.price, b.link, b.location, b.points_value
FROM bucket_list_event e, bucket_list_item b LEFT OUTER JOIN itemCount i
ON b.bl_item_id = i.bl_item_id
WHERE b.bl_item_id = e.event_item_id
AND b.location LIKE '${location}'
AND '${priceMin}' <= b.price AND b.price <= '${priceMax}'
AND '${startDate}' <= e.event_start
AND e.event_end <= '${endDate}'
order by i.items DESC NULLS LAST