-- Sets the pagesize so that all entries appear on one page (ie. the header doesn't repeat after every line in a select statement)
set pagesize 50000;

-- Deletes all the tables pertaining to bucket list if it exists

drop table bucket_list_item cascade constraints;
drop table bucket_list_food cascade constraints;
drop table bucket_list_event cascade constraints;
drop table bucket_list_activity cascade constraints;
drop table admin cascade constraints;
drop table consumer cascade constraints;
drop table is_friend_of cascade constraints;
drop table creates_modifies_item cascade constraints;
drop table item_request_requests cascade constraints;
drop table item_request_evaluates cascade constraints;
drop table goal_sets cascade constraints;
drop table user_has_bucket_list cascade constraints;
drop table bucket_list_contains cascade constraints;

-- Update the changes onto the SQL DB
commit;


-- Create all the tables for the Bucket List DB

create table bucket_list_item (
	bl_item_id int,
	price decimal,
    name varchar(50) not null,
	description varchar(500) not null,
	location varchar(100) not null,
	points_value int not null,
	primary key (bl_item_id)
);

grant select on bucket_list_item to public;


create table bucket_list_food (
	food_item_id int,
	restrictions varchar(100),
	nutrition varchar(100),
	primary key (food_item_id),
    foreign key (food_item_id) references bucket_list_item (bl_item_id) on delete cascade
);

grant select on bucket_list_food to public;


create table bucket_list_event (
	event_item_id int,
	event_start timestamp not null,
	event_end timestamp not null,
	primary key (event_item_id),
    foreign key (event_item_id) references bucket_list_item (bl_item_id) on delete cascade
);

grant select on bucket_list_event to public;


create table bucket_list_activity (
	activity_item_id int,
	activity_start timestamp not null,
	activity_end timestamp not null,
	weekdays_scheduled varchar(100),
	primary key (activity_item_id),
    foreign key (activity_item_id) references bucket_list_item (bl_item_id) on delete cascade
);

grant select on bucket_list_activity to public;


create table admin (
	admin_username varchar(20),
	admin_password varchar(50) not null,
	primary key (admin_username)
);

grant select on admin to public;


create table consumer (
	consumer_username varchar(20),
	consumer_password varchar(50) not null,
	name varchar(100) not null,
	points int default(0),
	email_address varchar(150) not null,
	phone_number varchar(15),
	primary key (consumer_username)
);

grant select on consumer to public;


create table is_friend_of (
	consumer_username varchar(20),
	friend_username varchar(20),
	primary key (consumer_username, friend_username),
	foreign key (consumer_username) references consumer (consumer_username),
	foreign key (friend_username) references consumer (consumer_username)
);

grant select on is_friend_of to public;


create table item_request_requests (
	request_id int,
	bl_item_id int,
	type varchar(10) not null,
	name varchar(50) not null,
	description varchar(500) not null,
	contact_info varchar(50),
	requested_date date not null,
	consumer_username varchar(20) not null,
	is_evaluated int not null,
	primary key (request_id),
	foreign key (bl_item_id) references bucket_list_item,
	foreign key (consumer_username) references consumer
);

grant select on item_request_requests to public;


create table creates_modifies_item (
	bl_item_id int,
	admin_username varchar(20) not null,
	request_id int,
	created_modified_date date not null,
    primary key (bl_item_id, request_id),
	foreign key (bl_item_id) references bucket_list_item,
	foreign key (admin_username) references admin,
	foreign key (request_id) references item_request_requests
);

grant select on creates_modifies_item to public;


create table item_request_evaluates (
	request_id int, 
	evaluated_date date not null,
	is_approved int not null,
	admin_username varchar(20) not null,
	primary key (request_id),
	foreign key (request_id) references item_request_requests,
	foreign key (admin_username) references admin
);

grant select on item_request_evaluates to public;


create table goal_sets (
	consumer_username varchar(20),
	achieve_by_date date default(CURRENT_DATE),
	points int default(0),
	is_achieved int default (0),
	primary key (consumer_username, achieve_by_date),
	foreign key (consumer_username) references consumer
);

grant select on goal_sets to public;


create table user_has_bucket_list (
	list_id int,
	percent_completed int default(0),
	privacy_level int default(0),
	consumer_username varchar(20) not null,
	primary key (list_id),
    foreign key (consumer_username) references consumer
);

grant select on user_has_bucket_list to public;


create table bucket_list_contains (
	list_id int,
	bl_item_id int,
	primary key (list_id, bl_item_id),
	foreign key (list_id) references user_has_bucket_list,
	foreign key (bl_item_id) references bucket_list_item
);

grant select on bucket_list_contains to public;

commit;


-- Insert data into bucket_list_item

insert into bucket_list_item
values (1, 0, 'Doll Town', 'Stroll through this small village where you''ll find the dolls easily outnumber the people.', 'Nagoro, Japan', 100);

insert into bucket_list_item
values (2, 5.99, 'Cheese Bubble Tea', 'A unique bubble tea made with cheese.', 'Richmond, BC', 10);

insert into bucket_list_item
values (3, 30, 'CatFe', 'A cafe where you can play with cats while you drink coffee. If you like the cat you can even apply to adopt them!', 'Vancouver, Canada', 100);

insert into bucket_list_item
values (4, 50, 'Hello Kitty Cafe', 'A unique Hello Kitty themed cafe. Everything from the dining experience to the dishes are Hello Kitty themed.', 'Bangkok, Thailand', 60);

insert into bucket_list_item
values (5, 50, 'Super Scary Labyrinth of Fear', 'At 900m long, this is the longest haunted house in the world! Come visit the ghosts at this mental institution located in the Fuji-Q theme park.', 'Fuji-Q Highland Theme Park, Japan', 1000);

insert into bucket_list_item
values (6, 20, 'Crater of Diamonds State Park',  'Try your luck at finding diamonds in this state park. You get to keep the diamonds you find.', 'Pike County, Arkansas', 80);

insert into bucket_list_item
values (7, 45, 'Dining in the Dark', 'Immerse your senses with this pitch-black dining experience.', 'Kitsilano, Vancouver', 100);

insert into bucket_list_item
values (8, 30, 'Ramen Museum', 'Take a tour at this museum dedicated to the history and different regional styles of ramen.', 'Osaka, Japan', 25);

insert into bucket_list_item
values (9, 75, 'Skywalk at Macau Tower', 'Walk around the edge of Macau Tower in this thrilling adventure.', 'Macau, China', 500);

insert into bucket_list_item
values (10, 54.99, 'Paris catacombs', 'Visit the underground ossuaries of Paris ... if you dare ...', 'Paris, France', 1000);

insert into bucket_list_item
values (11, 124.99, 'Dinner in the Sky', 'Dine 160+ feet off the ground with this unique dining experience.', 'Worldwide', 500);

insert into bucket_list_item
values (12, 17.75, 'Trickeye Museum', 'Trick your friends with this museum dedicated to 2D and 3D illusions.', 'Seoul, South Korea', 50);

insert into bucket_list_item
values (13, 439.99, 'XLine Dubai', 'Zipline across the city of Dubai in the worlds longest urban zipline.', 'Dubai', 250);

insert into bucket_list_item
values (14, 95, 'Sandboarding', 'Can''t swim? Hate water? Try sand surfing in the great Sahara desert instead!', 'Morocco', 100);

insert into bucket_list_item
values (15, 20.99, 'Hotel de Glace', 'Visit North America''s only ice hotel. Made entirely of snow and ice it''s the coolest way to spend the night!', 'Quebec, Canada', 50);

commit;


-- Insert data into bucket_list_food

insert into bucket_list_food
values (2, 'Contains dairy products', 'Semi-nutritious');

insert into bucket_list_food
values (3, 'May contain dairy products', null);

insert into bucket_list_food
values (4, 'Please check the menu', null);

insert into bucket_list_food
values (11, 'Please ask your server for details', null);

insert into bucket_list_food
values (15, null, 'Do not consume in large quantities')

commit;


-- Insert data into bucket_list_event

insert into bucket_list_event
values (1, TO_TIMESTAMP('2018-05-06 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2018-05-06 12:00', 'YYYY-MM-DD HH24:MI'));

insert into bucket_list_event
values (7, TO_TIMESTAMP('2019-10-31 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2019-10-31 11:30', 'YYYY-MM-DD HH24:MI'));

insert into bucket_list_event
values (10, TO_TIMESTAMP('2019-10-31 20:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2019-10-31 22:00', 'YYYY-MM-DD HH24:MI'));

insert into bucket_list_event
values (14, TO_TIMESTAMP('2019-07-13 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2019-07-13 10:00', 'YYYY-MM-DD HH24:MI'));


commit;


-- Insert data into bucket_list_activity

insert into bucket_list_activity
values (5, TO_TIMESTAMP('2019-01-02 22:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2019-12-31 23:59', 'YYYY-MM-DD HH24:MI'), 'Fri, Sat, Sun');

insert into bucket_list_activity
values (6, TO_TIMESTAMP('2020-05-01 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2020-09-30 18:00', 'YYYY-MM-DD HH24:MI'), null);

insert into bucket_list_activity
values (8, TO_TIMESTAMP('2019-01-20 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2019-05-10 10:00', 'YYYY-MM-DD HH24:MI'), 'Mon, Tues, Wed, Thu, Fri');

insert into bucket_list_activity
values (9, TO_TIMESTAMP('2018-07-01 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2018-07-31 17:00', 'YYYY-MM-DD HH24:MI'), 'Sat, Sun');

insert into bucket_list_activity
values (12, TO_TIMESTAMP('2017-02-09 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2017-07-15 10:00', 'YYYY-MM-DD HH24:MI'), null);

insert into bucket_list_activity
values (13, TO_TIMESTAMP('2019-05-01 11:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2019-09-30 20:00', 'YYYY-MM-DD HH24:MI'), 'Fri, Sat, Sun');

commit;


-- Insert data into admin

insert into admin
values ('marinachun', 'iloveubc');

insert into admin
values ('renwang', 'ilovecpsc');

insert into admin
values ('cherylyao', 'ilove304');

insert into admin
values ('alexisgervacio', 'ilovescience');

commit;


-- Insert data into consumer

insert into consumer
values ('hauntingsjapan', 'iizuka233', 'Rimi Iizuka', 100, 'rimi.i@gmail.com', null);

insert into consumer
values ('cyberboy', 'cyborg4evers', 'Shawma Chun', 670, 'cyberboy@gmail.com', '8085258517');

insert into consumer
values ('justinandkoh', '1156koh!', 'Justin Koh', 0, 'justin.k@gmail.com', null);

insert into consumer
values ('matthew.liao437', 'liao39?8', 'Matthew Liao', 15, 'matt.l@alumni.ubc.ca', null);

insert into consumer
values ('widjaja', 'widjajajo890%', 'Johnson Widjaja', 500, 'widjaja.john@hotmail.com', '7789452034');

commit;


-- Insert data into is_friend_of

insert into is_friend_of
values ('hauntingsjapan', 'cyberboy');

insert into is_friend_of
values ('justinandkoh', 'widjaja');

insert into is_friend_of
values ('matthew.liao437', 'justinandkoh');

commit;

-- Insert data into item_request_requests

insert into item_request_requests
values (1, 1, 'event', 'Doll Town', 'Stroll through this small village where you''ll find the dolls easily outnumber the people.', null, TO_DATE('2016-05-06', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (2, 2, 'food', 'Cheese Bubble Tea', 'Cheese bubble tea', null, TO_DATE('2016-02-18', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (3, 3, 'food', 'CatFe', 'A cafe where you can play with cats while you drink coffee. If you like the cat you can even apply to adopt them!', 'catfe@gmail.ca', TO_DATE('2016-02-14', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (4, 4, 'food', 'Hello Kitty Cafe', 'A unique Hello Kitty themed cafe. Everything from the dining experience to the dishes are Hello Kitty themed.', null, TO_DATE('2016-02-14', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (5, 5, 'activity', 'Super Scary Labyrinth of Fear', 'At 900m long, this is the longest haunted house in the world! Come visit the ghosts at this mental institution located in the Fuji-Q theme park.', null, TO_DATE('2016-04-26', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (6, 6, 'activity', 'Crater of Diamonds State Park',  'Try your luck at finding diamonds in this state park. You get to keep the diamonds you find.', 'craterdiamonds@gmail.com', TO_DATE('2016-04-28', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (7, 7, 'event', 'Dining in the Dark', 'Immerse your senses with this pitch-black dining experience.', null, TO_DATE('2017-08-10', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (8, 8, 'activity', 'Ramen Museum', 'Take a tour at this museum dedicated to the history and different regional styles of ramen.', 'ramenmuseum@gmail.jp', TO_DATE('2017-08-13', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (9, 9, 'activity', 'Skywalk at Macau Tower', 'Walk around the edge of Macau Tower in this thrilling adventure.', 'macautower@gmail.com', TO_DATE('2017-07-31', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (10, 10, 'event', 'Paris catacombs', 'Visit the underground ossuaries of Paris ... if you dare ...', 'visitparis@gmail.com', TO_DATE('2017-10-13', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (11, 11, 'food', 'Dinner in the Sky', 'Dine 160+ feet off the ground with this unique dining experience.', null, TO_DATE('2019-02-13', 'YYYY-MM-DD'), 'widjaja', 1);

insert into item_request_requests
values (12, 12, 'activity', 'Trickeye Museum', 'Trick your friends with this museum dedicated to 2D and 3D illusions.', 'trickeyemuseum@gmail.com', TO_DATE('2018-12-27', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (13, 13, 'activity', 'XLine Dubai', 'Zipline across the city of Dubai in the worlds longest urban zipline.', 'xlinedubai@gmail.com', TO_DATE('2019-02-05', 'YYYY-MM-DD'), 'widjaja', 1);

insert into item_request_requests
values (14, 14, 'event', 'Sandboarding', 'Can''t swim? Hate water? Try sand surfing in the great Sahara desert instead!', 'tourismmorocco@gmail.com', TO_DATE('2019-02-13', 'YYYY-MM-DD'), 'justinandkoh', 1);

insert into item_request_requests
values (15, 15, 'food', 'Hotel de Glace', 'Visit North America''s only ice hotel. Made entirely of snow and ice it''s the coolest way to spend the night!', 'hoteldeglace@gmail.ca', TO_DATE('2019-03-01', 'YYYY-MM-DD'), 'justinandkoh', 1);

insert into item_request_requests
values (16, 1, 'event', 'Doll Town', 'Stroll through this small village where you''ll find the dolls easily outnumber the people.', null, TO_DATE('2019-02-06', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (17, 2, 'food', 'Cheese Bubble Tea', 'A unique bubble tea.', null, TO_DATE('2019-02-20', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (18, 2, 'food', 'Cheese Bubble Tea', 'A unique bubble tea made with cheese.', null, TO_DATE('2019-02-20', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (19, 10, 'activity', 'Poveglia Island', 'Located just a couple minutes from Venice, this island was used as a quarintine from the plague and as a mental institution. Needless to say it''s home to thousands of (angry) ghosts!', null, TO_DATE('2019-02-28', 'YYYY-MM-DD'), 'hauntingsjapan', 0);

insert into item_request_requests
values (20, 2, 'food', 'Seasonal BBT at Coco', 'Come try Coco''s seasonal bubble tea! For a limited time only with limited quantities.', 'cococanada@coco.com', TO_DATE('2019-03-01', 'YYYY-MM-DD'), 'matthew.liao437', 1);

commit;


-- Insert data into creates_modifies_item

insert into creates_modifies_item
values (1, 'cherylyao', 1, TO_DATE('2016-02-19', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (2, 'cherylyao', 2, TO_DATE('2016-02-19', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (3, 'cherylyao', 3, TO_DATE('2016-02-19', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (4, 'cherylyao', 4, TO_DATE('2016-02-19', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (5, 'renwang', 5, TO_DATE('2016-05-01', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (6, 'marinachun', 6, TO_DATE('2016-05-01', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (7, 'marinachun', 7, TO_DATE('2017-08-13', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (8, 'marinachun', 8, TO_DATE('2017-08-13', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (9, 'alexisgervacio', 9, TO_DATE('2017-08-13', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (10, 'cherylyao', 10, TO_DATE('2017-11-20', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (11, 'alexisgervacio', 11, TO_DATE('2019-01-15', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (12, 'alexisgervacio', 12, TO_DATE('2019-01-15', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (13, 'renwang', 13, TO_DATE('2019-02-14', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (14, 'renwang', 14, TO_DATE('2019-02-14', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (15, 'marinachun', 15, TO_DATE('2019-03-01', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (1, 'marinachun', 17, TO_DATE('2019-03-01', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (2, 'marinachun', 16, TO_DATE('2019-03-01', 'YYYY-MM-DD'));

insert into creates_modifies_item
values (2, 'cherylyao', 18, TO_DATE('2019-03-01', 'YYYY-MM-DD'));

commit;


-- Insert data into item_request_evaluates

insert into item_request_evaluates
values (1, TO_DATE('2016-02-19', 'YYYY-MM-DD'), 1, 'cherylyao');

insert into item_request_evaluates
values (2, TO_DATE('2016-02-19', 'YYYY-MM-DD'), 1, 'cherylyao');

insert into item_request_evaluates
values (3, TO_DATE('2016-02-19', 'YYYY-MM-DD'), 1, 'cherylyao');

insert into item_request_evaluates
values (4, TO_DATE('2016-02-19', 'YYYY-MM-DD'), 1, 'cherylyao');

insert into item_request_evaluates
values (5, TO_DATE('2016-05-01', 'YYYY-MM-DD'), 1, 'renwang');

insert into item_request_evaluates
values (6, TO_DATE('2016-05-01', 'YYYY-MM-DD'), 1, 'marinachun');

insert into item_request_evaluates
values (7, TO_DATE('2017-08-13', 'YYYY-MM-DD'), 1, 'marinachun');

insert into item_request_evaluates
values (8, TO_DATE('2017-08-13', 'YYYY-MM-DD'), 1, 'marinachun');

insert into item_request_evaluates
values (9, TO_DATE('2017-08-13', 'YYYY-MM-DD'), 1, 'alexisgervacio');

insert into item_request_evaluates
values (10, TO_DATE('2017-11-20', 'YYYY-MM-DD'), 1, 'cherylyao');

insert into item_request_evaluates
values (11, TO_DATE('2019-01-15', 'YYYY-MM-DD'), 1, 'alexisgervacio');

insert into item_request_evaluates
values (12, TO_DATE('2019-01-15', 'YYYY-MM-DD'), 1, 'alexisgervacio');

insert into item_request_evaluates
values (13, TO_DATE('2019-02-14', 'YYYY-MM-DD'), 1, 'renwang');

insert into item_request_evaluates
values (14, TO_DATE('2019-02-14', 'YYYY-MM-DD'), 1, 'renwang');

insert into item_request_evaluates
values (15, TO_DATE('2019-03-01', 'YYYY-MM-DD'), 1, 'marinachun');

insert into item_request_evaluates
values (16, TO_DATE('2019-03-01', 'YYYY-MM-DD'), 1, 'marinachun');

insert into item_request_evaluates
values (17, TO_DATE('2019-03-01', 'YYYY-MM-DD'), 1, 'marinachun');

insert into item_request_evaluates
values (18, TO_DATE('2019-03-01', 'YYYY-MM-DD'), 1, 'cherylyao');

insert into item_request_evaluates
values (20, TO_DATE('2019-03-15', 'YYYY-MM-DD'), 0, 'cherylyao');

commit;


-- Insert data into goal_sets

insert into goal_sets
values ('hauntingsjapan', TO_DATE('2019-03-31', 'YYYY-MM-DD'), 1000, 0);

insert into goal_sets
values ('cyberboy', TO_DATE('2018-10-31', 'YYYY-MM-DD'), 500, 1);

insert into goal_sets (consumer_username)
values ('justinandkoh');

insert into goal_sets
values ('matthew.liao437', TO_DATE('2017-09-12', 'YYYY-MM-DD'), 100, 0);

insert into goal_sets
values ('widjaja', TO_DATE('2030-12-31', 'YYYY-MM-DD'), 5000, 0);

commit;


-- Insert data into user_has_bucket_list 

insert into user_has_bucket_list
values (1, 10, 0, 'hauntingsjapan');

insert into user_has_bucket_list
values (2, 100, 1, 'cyberboy');

insert into user_has_bucket_list (list_id, consumer_username)
values (3, 'justinandkoh');

insert into user_has_bucket_list
values (4, 15, 1, 'matthew.liao437');

insert into user_has_bucket_list
values (5, 10, 1, 'widjaja');

commit;


-- Insert data into bucket_list_contains

insert into bucket_list_contains
values (1, 1);

insert into bucket_list_contains
values (1, 5);

insert into bucket_list_contains
values (1, 7);

insert into bucket_list_contains
values (1, 10);

insert into bucket_list_contains
values (2, 9);

insert into bucket_list_contains
values (2, 6);

insert into bucket_list_contains
values (2, 4);

insert into bucket_list_contains
values (4, 2);

insert into bucket_list_contains
values (4, 3);

insert into bucket_list_contains
values (4, 8);

insert into bucket_list_contains
values (4, 11);

insert into bucket_list_contains
values (5, 5);

insert into bucket_list_contains
values (5, 8);

insert into bucket_list_contains
values (5, 9);

insert into bucket_list_contains
values (5, 12);

insert into bucket_list_contains
values (5, 13);

insert into bucket_list_contains
values (5, 14);

commit;