drop table itemCount;

create view itemCount as
select bl_item_id, COUNT(*) as items
from bucket_list_contains
group by bl_item_id;

