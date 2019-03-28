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
drop table food_restrictions cascade constraints;
drop table bucket_list_type cascade constraints;
drop table evaluation cascade constraints;

-- Update the changes onto the SQL DB
commit;


-- Create all the tables for the Bucket List DB

create table bucket_list_item (
	bl_item_id int,
	link varchar(500),
    name varchar(50) not null,
    price int,
	description varchar(500) not null,
	location varchar(100) not null,
	points_value int not null,
	primary key (bl_item_id)
);

grant select on bucket_list_item to public;


create table food_restrictions (
    restriction_id int,
    restriction varchar(100),
    primary key (restriction_id)
);

grant select on food_restrictions to public;


create table bucket_list_food (
	food_item_id int,
	restrictions int not null,
	primary key (food_item_id),
    foreign key (restrictions) references food_restrictions (restriction_id),
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


create table bucket_list_type (
    bl_type_id int,
    bl_type varchar(100),
    primary key (bl_type_id)
);

grant select on bucket_list_type to public;


create table evaluation (
    evaluated_id int,
    evaluation_desc varchar(100),
    primary key (evaluated_id)
);

grant select on evaluation to public;


create table item_request_requests (
	request_id int,
	bl_item_id int,
	bl_type_id int not null,
	name varchar(50) not null,
	description varchar(500) not null,
	requested_date date not null,
	consumer_username varchar(20),
	is_evaluated int default (0),
	primary key (request_id),
    foreign key (bl_type_id) references bucket_list_type,
	foreign key (bl_item_id) references bucket_list_item,
    foreign key (is_evaluated) references evaluation (evaluated_id),
	foreign key (consumer_username) references consumer
);

grant select on item_request_requests to public;


create table creates_modifies_item (
	bl_item_id int,
	admin_username varchar(20),
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
	is_approved int default(0),
	admin_username varchar(20),
	primary key (request_id),
    foreign key (is_approved) references evaluation (evaluated_id),
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
	consumer_username varchar(20),
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
values (1, 'https://news.nationalgeographic.com/2017/10/japan-dolls-population-artist-nagoro-spd/', 'Doll Town', 0, 'Stroll through this small village where you''ll find the dolls easily outnumber the people.', 'Nagoro, Japan', 100);

insert into bucket_list_item
values (2, 'http://www.happy-lemon.com/en/drink/drink.php', 'Cheese Bubble Tea', 6, 'A unique bubble tea made with cheese.', 'Richmond, BC', 10);

insert into bucket_list_item
values (3, 'www.catfe.ca', 'CatFe', 10, 'A cafe where you can play with cats while you drink coffee. If you like the cat you can even apply to adopt them!', 'Vancouver, Canada', 100);

insert into bucket_list_item
values (4, 'http://hellokittyhousebangkok.com/', 'Hello Kitty House', 30, 'A unique Hello Kitty themed cafe. Everything from the dining experience to the dishes are Hello Kitty themed.', 'Bangkok, Thailand', 60);

insert into bucket_list_item
values (5, 'https://www.fujiq.jp/en/attraction/senritsu.html', 'Super Scary Labyrinth of Fear', 69, 'At 900m long, this is the longest haunted house in the world! Come visit the ghosts at this mental institution located in the Fuji-Q theme park.', 'Fuji-Q Highland Theme Park, Japan', 1000);

insert into bucket_list_item
values (6, 'https://www.arkansasstateparks.com/parks/crater-diamonds-state-park', 'Crater of Diamonds State Park', 0, 'Try your luck at finding diamonds in this state park. You get to keep the diamonds you find.', 'Pike County, Arkansas', 80);

insert into bucket_list_item
values (7, 'http://www.darktable.ca/about.html', 'Dining in the Dark', 45, 'Immerse your senses with this pitch-black dining experience.', 'Kitsilano, Vancouver', 100);

insert into bucket_list_item
values (8, 'http://www.raumen.co.jp/english/', 'Ramen Museum', 3, 'Take a tour at this museum dedicated to the history and different regional styles of ramen.', 'Osaka, Japan', 25);

insert into bucket_list_item
values (9, 'https://www.macautower.com.mo/tower-adventure/tower-adventure/skywalk/', 'Skywalk at Macau Tower', 147, 'Walk around the edge of Macau Tower in this thrilling adventure.', 'Macau, China', 500);

insert into bucket_list_item
values (10, 'http://catacombes.paris.fr/en', 'Paris catacombs', 44, 'Visit the underground ossuaries of Paris ... if you dare ...', 'Paris, France', 1000);

insert into bucket_list_item
values (11, 'https://dinnerintheskycanada.com/', 'Dinner in the Sky', 150, 'Dine 160+ feet off the ground with this unique dining experience.', 'Canada', 500);

insert into bucket_list_item
values (12, 'http://trickeye.com/', 'Trickeye Museum', 15, 'Trick your friends with this museum dedicated to 2D and 3D illusions.', 'Seoul, South Korea', 50);

insert into bucket_list_item
values (13, 'http://xdubai.com/xline/', 'XLine Dubai', 500, 'Zipline across the city of Dubai in the worlds longest urban zipline.', 'Dubai', 250);

insert into bucket_list_item
values (14, 'http://www.mouhoutours.com/morocco-sandboarding-merzouga-experience/', 'Sandboarding', 450, 'Can''t swim? Hate water? Try sand surfing in the great Sahara desert instead!', 'Morocco', 100);

insert into bucket_list_item
values (15, 'https://www.valcartier.com/en/accommodations/ice-hotel/?langue=fr', 'Hotel de Glace', 350, 'Visit North America''s only ice hotel. Made entirely of snow and ice it''s the coolest way to spend the night!', 'Quebec, Canada', 50);

insert into bucket_list_item
values (16, 'http://villaescudero.com/amenities-activities/', 'The Labassin Waterfall Restaurant', 30, 'Dine at the foot of a waterfall at this exotic restaurant.', 'Phillipines', 50);

insert into bucket_list_item
values (17, 'https://shinjuku-robot.com/sp/', 'Robot Restaurant', 50, 'Do you prefer being with robots over people? Want an out of this world futristic experience? Then visit this colorful and crazy robot restaurant featuring robot  a robot show while you dine!', 'Shinjuku, Japan', 50);

insert into bucket_list_item
values (18, 'http://www.cerealkillercafe.co.uk/', 'Cereal Killer Cafe', 12, 'Are you a cereal killer? Do you constantly need a cereal fix? Then visit this cafe that offers cereals from all over the world along with 30 different types of milk.', 'London, UK', 50);

insert into bucket_list_item
values (19, 'http://moderntoilet.com.tw/', 'Modern Toilet Restaurant', 30, 'If you''re feeling adventurous and known for your iron stomach, then try you must go to this toilet themed restaurant in Taiwan! Everything is served in minature toilet themed dishes and arranged to fit the theme.', 'Taiwan', 100);

insert into bucket_list_item
values (20, 'https://kawaiimonster.jp/', 'Kawaii Monster Cafe', 40, 'Described as ''Alice in Wonderland meets Wonka on acid'', this Harajuku cafe highlights the colorful and crazy town that it''s located in. Visit in the day and night for two unique experiences you won''t forget.', 'Harajuku, Japan', 100);

insert into bucket_list_item
values (21, 'https://discoveryourindonesia.com/timang-beach/', 'Timang Beach Gondola', 19, 'If you want a thrill ride of a lifetime then nothing is more fitting than the gondola at Timang Beach. This hand pulled wooden gondola is nothing more than a chair and a system of pulleys strung across the ocean to link the main island to a rocky outcrop island used by fisherman.', 'Indonesia', 1000);

insert into bucket_list_item
values (22, 'https://www.bungy.co.nz/queenstown/nevis/nevis-swing/', 'Nevis Swing', 200, 'Take swinging to a whole new extreme with this swing designed to go over a river valley in a 300m arc!', 'Queenstown, New Zealand', 1000);

insert into bucket_list_item
values (23, 'https://daiba.ooedoonsen.jp/en/', 'Odaiba Onsen', 33, 'Melt your stress away in the various natural hot springs in one of Japan''s largest onsen theme parks!', 'Odaiba, Japan', 15);

insert into bucket_list_item
values (24, 'https://www.lightsouthk.com/', 'Lights // Out', 35, 'Get a sweat going while enjoying the night club atmosphere at this unique gym/nightclub!', 'Hong Kong China', 15);

insert into bucket_list_item
values (25, 'http://hkrunninggames.com/', 'HK Running Games', 65, 'Love game shows? Want to be in one? Then join the Running Games where you and your friends can compete in your very own game show! Based off of the popular Korean variety show, this experince features a variety of elaborate and hilarious activities to complete.', 'Hong Kong, China', 100);

insert into bucket_list_item
values (26, 'https://vancouversbestplaces.com/events-calendar/festivals-and-events/new-year-polar-bear-swims/', 'Polar Bear Swim', 0, 'A crazy annual tradition for many Vancouverites is taking a plunge in the icy waters of the ocean on New Year’s Day. Ring in the new year with a freezing, fresh, oceanic plunge!', 'English Bay, Vancouver, Canada', 250);

insert into bucket_list_item
values (27, 'http://ovaltine-cafe.com', 'Ovaltine Cafe', 15, 'Circa-1942 diner serving up all-day breakfast, burgers and sandwiches in a nostalgic atmosphere.', 'Vancouver, BC', 10);

insert into bucket_list_item
values (28, 'https://www.facebook.com/events/park-royal-west-vancouver-bc-v7t-canada/hike-rave-tonight/607052016336346/', 'Hike Rave', 5, 'The best night-hike of your life. A.k.a. the most Vancouver event ever.', 'Vancouver, BC',111);

commit;


-- Insert data into food_restrictions

insert into food_restrictions
values (0, 'Vegetarian');

insert into food_restrictions
values (1, 'Vegan');

insert into food_restrictions
values (2, 'Gluten free');

insert into food_restrictions
values (3, 'Dairy free');

insert into food_restrictions
values (4, 'Nut free');

insert into food_restrictions
values (5, 'Please ask server for details');

commit;


-- Insert data into bucket_list_food

insert into bucket_list_food
values (2, 0);

insert into bucket_list_food
values (3, 5);

insert into bucket_list_food
values (4, 5);

insert into bucket_list_food
values (11, 5);

insert into bucket_list_food
values (16, 5);

insert into bucket_list_food
values (17, 5);

insert into bucket_list_food
values (18, 1);

insert into bucket_list_food
values (19, 5);

insert into bucket_list_food
values (20, 5);

insert into bucket_list_food
values (27, 5);

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

insert into bucket_list_event
values (26, TO_TIMESTAMP('2019-01-01 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2019-01-01 17:00', 'YYYY-MM-DD HH24:MI'));

insert into bucket_list_event
values (28, TO_TIMESTAMP('2018-08-17 18:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2018-08-17 22:00', 'YYYY-MM-DD HH24:MI'));

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

insert into bucket_list_activity
values (15, TO_TIMESTAMP('2018-01-20 00:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2028-12-31 23:59', 'YYYY-MM-DD HH24:MI'), 'Mon, Tues, Wed, Thu, Fri, Sat, Sun');

insert into bucket_list_activity
values (21, TO_TIMESTAMP('2018-04-20 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2028-09-25 19:00', 'YYYY-MM-DD HH24:MI'), 'Mon, Tues, Wed, Thu, Fri, Sat, Sun');

insert into bucket_list_activity
values (22, TO_TIMESTAMP('2018-01-20 08:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2028-12-31 15:00', 'YYYY-MM-DD HH24:MI'), 'Mon, Tues, Wed, Fri, Sat, Sun');

insert into bucket_list_activity
values (23, TO_TIMESTAMP('2018-02-01 06:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2028-10-31 22:00', 'YYYY-MM-DD HH24:MI'), 'Mon, Tues, Wed, Thu, Fri, Sat, Sun');

insert into bucket_list_activity
values (24, TO_TIMESTAMP('2019-01-01 21:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-12-31 03:00', 'YYYY-MM-DD HH24:MI'), 'Thu, Fri, Sat, Sun');

insert into bucket_list_activity
values (25, TO_TIMESTAMP('2019-05-01 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2025-11-30 20:30', 'YYYY-MM-DD HH24:MI'), 'Tues, Wed, Thu, Fri, Sat');

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

insert into admin
values ('test', 'test');

commit;


-- Insert data into consumer

insert into consumer
values ('hi', 'password', 'Test User', 111, 'fake@gmail.com', null);

insert into consumer
values ('hauntingsjapan', 'password', 'Rimi Iizuka', 100, 'rimi.i@gmail.com', null);

insert into consumer
values ('cyberboy', 'cyborg4evers', 'Shawma Chun', 670, 'cyberboy@gmail.com', '8085258517');

insert into consumer
values ('justinandkoh', '1156koh!', 'Justin Koh', 0, 'justin.k@gmail.com', null);

insert into consumer
values ('matthew.liao437', 'liao39?8', 'Matthew Liao', 15, 'matt.l@alumni.ubc.ca', null);

insert into consumer
values ('widjaja', 'widjajajo890%', 'Johnson Widjaja', 500, 'widjaja.john@hotmail.com', '7789452034');

insert into consumer
values ('thrillingadventures', 'thrillseeker2000', 'John Doe', 100, 'john.doe@hotmail.com', '2507830991');

insert into consumer
values ('scaredycat100', 'ithinkineedtums', 'Jane Doe', 50, 'scaredy.deer@gmail.com', null);

insert into consumer
values ('surferbabe200', 'tula.44$89', 'Tula Smith', 90, 'tula.k.smith321@gmail.ca', '7789082686');

insert into consumer
values ('helloworld', 'hello4903', 'Simon Sayes', 150, 'hello.world4895@hotmail.com', null);

insert into consumer
values ('melodypond409', 'doctors.wife273', 'River Song', 315, 'archaeologists.rule1009x@gmail.com', '84736193758');

commit;


-- Insert data into is_friend_of

insert into is_friend_of
values ('hauntingsjapan', 'cyberboy');

insert into is_friend_of
values ('justinandkoh', 'widjaja');

insert into is_friend_of
values ('matthew.liao437', 'justinandkoh');

commit;


-- Insert data into bucket_list_type

insert into bucket_list_type
values (0, 'Food');

insert into bucket_list_type
values (1, 'Event');

insert into bucket_list_type
values (2, 'Activity');

commit;


-- Insert data into evaluation

insert into evaluation
values (0, 'Pending');

insert into evaluation
values (1, 'Approved');

insert into evaluation
values (2, 'Rejected');

commit;


-- Insert data into item_request_requests

insert into item_request_requests
values (1, 1, 1, 'Doll Town', 'Stroll through this small village where you''ll find the dolls easily outnumber the people.', TO_DATE('2016-05-06', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (2, 2, 0, 'Cheese Bubble Tea', 'Cheese bubble tea', TO_DATE('2016-02-18', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (3, 3, 0, 'CatFe', 'A cafe where you can play with cats while you drink coffee. If you like the cat you can even apply to adopt them!', TO_DATE('2016-02-14', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (4, 4, 0, 'Hello Kitty Cafe', 'A unique Hello Kitty themed cafe. Everything from the dining experience to the dishes are Hello Kitty themed.', TO_DATE('2016-02-14', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (5, 5, 2, 'Super Scary Labyrinth of Fear', 'At 900m long, this is the longest haunted house in the world! Come visit the ghosts at this mental institution located in the Fuji-Q theme park.', TO_DATE('2016-04-26', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (6, 6, 2, 'Crater of Diamonds State Park',  'Try your luck at finding diamonds in this state park. You get to keep the diamonds you find.', TO_DATE('2016-04-28', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (7, 7, 1, 'Dining in the Dark', 'Immerse your senses with this pitch-black dining experience.', TO_DATE('2017-08-10', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (8, 8, 2, 'Ramen Museum', 'Take a tour at this museum dedicated to the history and different regional styles of ramen.', TO_DATE('2017-08-13', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (9, 9, 2, 'Skywalk at Macau Tower', 'Walk around the edge of Macau Tower in this thrilling adventure.', TO_DATE('2017-07-31', 'YYYY-MM-DD'), 'cyberboy', 1);

insert into item_request_requests
values (10, 10, 1, 'Paris catacombs', 'Visit the underground ossuaries of Paris ... if you dare ...', TO_DATE('2017-10-13', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (11, 11, 0, 'Dinner in the Sky', 'Dine 160+ feet off the ground with this unique dining experience.', TO_DATE('2019-02-13', 'YYYY-MM-DD'), 'widjaja', 1);

insert into item_request_requests
values (12, 12, 2, 'Trickeye Museum', 'Trick your friends with this museum dedicated to 2D and 3D illusions.', TO_DATE('2018-12-27', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (13, 13, 2, 'XLine Dubai', 'Zipline across the city of Dubai in the worlds longest urban zipline.', TO_DATE('2019-02-05', 'YYYY-MM-DD'), 'widjaja', 1);

insert into item_request_requests
values (14, 14, 1, 'Sandboarding', 'Can''t swim? Hate water? Try sand surfing in the great Sahara desert instead!', TO_DATE('2019-02-13', 'YYYY-MM-DD'), 'justinandkoh', 1);

insert into item_request_requests
values (15, 15, 0, 'Hotel de Glace', 'Visit North America''s only ice hotel. Made entirely of snow and ice it''s the coolest way to spend the night!', TO_DATE('2019-03-01', 'YYYY-MM-DD'), 'justinandkoh', 1);

insert into item_request_requests
values (16, 1, 1, 'Doll Town', 'Stroll through this small village where you''ll find the dolls easily outnumber the people.', TO_DATE('2019-02-06', 'YYYY-MM-DD'), 'hauntingsjapan', 1);

insert into item_request_requests
values (17, 2, 0, 'Cheese Bubble Tea', 'A unique bubble tea.', TO_DATE('2019-02-20', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (18, 2, 0, 'Cheese Bubble Tea', 'A unique bubble tea made with cheese.', TO_DATE('2019-02-20', 'YYYY-MM-DD'), 'matthew.liao437', 1);

insert into item_request_requests
values (19, 10, 2, 'Poveglia Island', 'Located just a couple minutes from Venice, this island was used as a quarintine from the plague and as a mental institution. Needless to say it''s home to thousands of (angry) ghosts!', TO_DATE('2019-02-28', 'YYYY-MM-DD'), 'hauntingsjapan', 0);

insert into item_request_requests
values (20, 2, 0, 'Seasonal BBT at Coco', 'Come try Coco''s seasonal bubble tea! For a limited time only with limited quantities.', TO_DATE('2019-03-01', 'YYYY-MM-DD'), 'matthew.liao437', 2);

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
values (20, TO_DATE('2019-03-15', 'YYYY-MM-DD'), 2, 'cherylyao');

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

insert into user_has_bucket_list
values (6, 90, 1, 'thrillingadventures');

insert into user_has_bucket_list
values (7, 75, 1, 'scaredycat100');

insert into user_has_bucket_list
values (8, 0, 1, 'surferbabe200');

insert into user_has_bucket_list
values (9, 50, 1, 'helloworld');

insert into user_has_bucket_list
values (10, 15, 1, 'melodypond409');

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

Insert into bucket_list_contains values(4, 4);
Insert into bucket_list_contains values(4, 15);
Insert into bucket_list_contains values(4, 16);
Insert into bucket_list_contains values(4, 17);
Insert into bucket_list_contains values(4, 18);
Insert into bucket_list_contains values(4, 19);
Insert into bucket_list_contains values(4, 10);
Insert into bucket_list_contains values(4, 20);
Insert into bucket_list_contains values(4, 27);

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

insert into bucket_list_contains
values (6, 14);

insert into bucket_list_contains
values (6, 8);

insert into bucket_list_contains
values (6, 6);

insert into bucket_list_contains
values (6, 11);

insert into bucket_list_contains
values (6, 20);

insert into bucket_list_contains
values (6, 12);

insert into bucket_list_contains
values (7, 8);

insert into bucket_list_contains
values (7, 5);

insert into bucket_list_contains
values (7, 6);

insert into bucket_list_contains
values (7, 12);

insert into bucket_list_contains
values (7, 16);

insert into bucket_list_contains
values (8, 8);

insert into bucket_list_contains
values (8, 6);

insert into bucket_list_contains
values (8, 18);

insert into bucket_list_contains
values (8, 20);

insert into bucket_list_contains
values (8, 11);

insert into bucket_list_contains
values (9, 8);

insert into bucket_list_contains
values (9, 5);

insert into bucket_list_contains
values (9, 18);

insert into bucket_list_contains
values (9, 23);

insert into bucket_list_contains
values (9, 20);

insert into bucket_list_contains
values (10, 8);

insert into bucket_list_contains
values (10, 18);

insert into bucket_list_contains
values (10, 14);

insert into bucket_list_contains
values (10, 13);

insert into bucket_list_contains
values (10, 5);

insert into bucket_list_contains
values (10, 7);

commit;