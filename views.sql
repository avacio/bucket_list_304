drop view itemCount;

create view itemCount as
select bl_item_id, COUNT(*) as items
from bucket_list_contains
group by bl_item_id;

drop view user_bucket_list_items;
create view user_bucket_list_items as
select * 
from bucket_list_item b
where b.bl_item_id IN 
	(select c.bl_item_id
	from bucket_list_contains c
	where c.list_id IN 
		(select u.list_id
		from user_has_bucket_list u));

