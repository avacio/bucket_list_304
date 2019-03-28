drop view allFood;
drop view allEvents;
drop view allActivities;

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

drop view japanbl;

create view japanbl as
select blc.bl_item_id
from bucket_list_contains blc
where blc.list_id IN 
	(select ubl.list_id
	from user_has_bucket_list ubl
	where ubl.consumer_username = 'hauntingsjapan');

drop view japanFriends;
drop view japan;
create view japanFriends as
select blc.bl_item_id
from bucket_list_contains blc
where blc.list_id IN
(select u.list_id
from user_has_bucket_list u
where u.consumer_username IN
(select f.friend_username
from is_friend_of f
where f.consumer_username = 'hauntingsjapan'));

create view japan as
select blc.bl_item_id
from bucket_list_contains blc
where blc.list_id IN 
	(select u.list_id
	from user_has_bucket_list u
	where u.consumer_username = 'hauntingsjapan');

drop view goals;
drop view consumerpoints;
create view goals as
select g.points 
from goal_sets g
where g.consumer_username = 'hauntingsjapan';

create view consumerpoints as
select c.points 
from consumer c
where c.consumer_username = 'hauntingsjapan';


