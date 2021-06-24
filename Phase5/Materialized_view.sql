--1
create view mv_show_general_advert_info
with schemabinding
as
select id,title,ag_image,price,city from dbo.agahi;
go

create unique clustered index clin_show_general_advert_info
on mv_show_general_advert_info (id)
go


--2
create view mv_show_urgent_house_advert
with schemabinding
as
select ag.id, ag.title, ag.ag_image, ag.price, ag.city
from dbo.house h join dbo.agahi ag on h.id = ag.id
and ag.is_immediate=1
go

create unique clustered index clin_show_ticket_info
on mv_show_urgent_house_advert (id)
go


--3
create view mv_show_general_starred_advert_info
with schemabinding
as
select st.agahi_id , ag.title, ag.ag_image,ag.price , ag.city 
from dbo.starred st join dbo.agahi ag on st.agahi_id=ag.id 
go

create unique clustered index clin_show_general_starred_advert_info
on mv_show_general_starred_advert_info(agahi_id)
go
