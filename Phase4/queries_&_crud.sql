

/*Queries*/
go

/*1*/
create proc proc_city_filter		@city	nvarchar(max)
as begin
select * from agahi where city=@city
end
go

/*2*/
create proc proc_dastebandi_filter	@dastebandi	  nvarchar(max)
as begin
select * from agahi where dastebandi=@dastebandi
end
go

/*3*/
create proc proc_dastebandi_field_filter	 @dastebandi  nvarchar(max),  @field nvarchar(max),  @value nvarchar(max)  /*table type eror should be debug*/
as begin
declare @query nvarchar(max)
set @query= N'select * from '+@dastebandi + ' where ' + @field + '=' + ''''+@value+'''';
exec (@query)
end
go


/*4*/
create proc proc_starred_filter		@user_id	int
as begin
select * from starred where usr_id=@user_id
end
go

/*5*/
create proc proc_date_filter		@date	date
as begin
select * from agahi where ag_date=@date
end
go

/*6*/
create proc proc_title_search	@text	nvarchar(max)
as begin
select * from agahi where title like '%'+@text+'%'
end
go

/*7*/
create proc proc_has_image_filter
as begin
select * from agahi where ag_image is not null
end
go

/*8*/
create proc proc_tavafoghi_filter
as begin
select * from agahi where tavafoghi=1
end
go

/*9*/
create proc proc_is_immediate_filter
as begin
select * from agahi where is_immediate=1
end
go

/*10*/
create proc proc_users_with_more_than_ten_agahi
as begin
select usr_id
from publish
group by usr_id
having COUNT(agahi_id) > 10;
end
go

/*11*/
create proc proc_price_range   @least_price	 int, @most_price	int
as begin
select id
from agahi
where price > @least_price and price < @most_price
end 
go

/*12*/
create proc proc_others_group  @name	nvarchar(MAX)
as begin
select id, daste_type, daste_name
from dastebandi
where @name = daste_type
end
go

/*13*/
create proc proc_unpublished_agahi
as begin
select *
from  agahi
where ag_status=N'منتشر نشده'
end 
go

/*14*/
create proc proc_message_number 
as begin
select count(chat_id) as number_of_chat
from chat
where DATEDIFF(DAY, chat_date, GETDATE()) < 7
end
go

/*15*/
create proc proc_home_with_parking
as begin 
select h.id
from house h, agahi
where h.id = agahi.id and parking=1
end 
go

/*16*/
create proc proc_total_sales
as begin
select sum(price) as total_sale
from agahi
where ag_status = N'فروخته'
end
go

/*17*/
create proc proc_new_vehicles
as begin
select *
from vehicle, agahi
where vehicle.id = agahi.id and YEAR(made_date) > 1395
end
go

/*18*/
create proc proc_average_sell
as begin
select avg(price) as average_sale
from agahi
where ag_status = N'فروخته'
group by YEAR(ag_date)
end
go

/*19*/
create proc proc_all_new_peride
as begin
select agahi.id
from agahi, vehicle
where brand = N'پراید' and  DATEDIFF(DAY, ag_date, GETDATE()) < 7
end
go

/*20*/
create proc proc_verified_agahi_by_monitoring  @id  int
as begin
select a.* from verify,agahi a
where monitor_id=@id and agahi_id=a.id
end 
go


/*update columns*/
ALTER TABLE agahi
ALTER COLUMN title nvarchar(Max)

ALTER TABLE agahi
ALTER COLUMN descriptions nvarchar(max)

ALTER TABLE agahi
ALTER COLUMN ag_status nvarchar(50)


/*update columns chat*/
ALTER TABLE chat
ALTER COLUMN chat_text nvarchar(max)


/*update columns dastebandi*/
ALTER TABLE dastebandi
ALTER COLUMN daste_name nvarchar(MAX)



/*update columns electronic_device*/
ALTER TABLE electronic_device
ALTER COLUMN dv_name nvarchar(MAX)


ALTER TABLE electronic_device
ALTER COLUMN brand nvarchar(MAX)


ALTER TABLE electronic_device
ALTER COLUMN company_id int


/*update columns home_tools*/
ALTER TABLE home_tools
ALTER COLUMN color nvarchar(MAX)


ALTER TABLE home_tools
ALTER COLUMN brand nvarchar(MAX)


/*update columns house*/
ALTER TABLE house
ALTER COLUMN h_address nvarchar(max)


/*update columns monitoring*/
ALTER TABLE monitoring
ALTER COLUMN dep_name nvarchar(MAX)


/*personal_tools*/
ALTER TABLE personal_tools
ALTER COLUMN color nvarchar(MAX)


/*update columns special_user*/
ALTER TABLE special_user
ALTER COLUMN access_name nvarchar(MAX)


ALTER TABLE special_user
ALTER COLUMN sp_type nvarchar(MAX)


/*update columns support*/
ALTER TABLE support
ALTER COLUMN dep_name nvarchar(max)


/*update used_stage
ALTER TABLE used_stage
ALTER COLUMN us_type nvarchar(MAX)*/


/*update users*/
ALTER TABLE users
ALTER COLUMN f_name nvarchar(MAX)


ALTER TABLE users
ALTER COLUMN l_name nvarchar(MAX)


/*ALTER TABLE users
ALTER COLUMN email nvarchar(MAX)*/


ALTER TABLE users
ALTER COLUMN pass nvarchar(MAX)


ALTER TABLE users
ALTER COLUMN addresses nvarchar(max)


/*update vehicles*/
ALTER TABLE vehicle
ALTER COLUMN color nvarchar(MAX)


ALTER TABLE vehicle
ALTER COLUMN gearbox nvarchar(MAX)


ALTER TABLE vehicle
ALTER COLUMN brand nvarchar(MAX)



/*update a row from users*/
update users
set f_name = 'mohammad reza'
where email = 'm.rezza@gmail.com'

create table temp (
	ID		INT
);

drop table temp;


/*delete a row from users*/
delete 
from users
where email = 'm.rezza@gmail.com'

/*change price of existing tavafoghi agahi*/
update Agahi set price=Null where tavafoghi=1

/*check price of tavafoghi agahi*/
alter table agahi add constraint tavafoghi_price check((tavafoghi=1 and price=null) or (tavafoghi=0 and price is not null));

/*if you want to drop constraint*/
--alter table Agahi drop constraint tavafoghi_price




/*insert procedure*/
go

--1 (elec_dev)
create proc proc_insert_elec_dev		@title nvarchar(max),  @ag_image nvarchar(max),  @description nvarchar(max),	@city nvarchar(max),  @tavafoghi bit,
								@price int,	@ag_date date,	@ag_status nvarchar(50),  @is_immediate bit,  @dastebandi nvarchar(max),

								@dv_name nvarchar(max),	@brand nvarchar(max),	@company_name nvarchar(max),	@us_type nvarchar(max)
as begin


insert into agahi values(@title,@ag_image,@description,@city,@tavafoghi,@price,@ag_date,@ag_status,@is_immediate,N'لوازم الکترونیکی')

declare @id int
set @id = (select top 1 id from agahi order by id DESC)

declare @usid int
set @usid= (select usid from used_stage where us_type=@us_type)

declare @company_id int
set @company_id = (select id from company where cmp_name=@company_name)
insert into electronic_device values(@id,@dv_name,@brand,@usid,@company_id)
end
go

--2 (home_tools)
create proc proc_insert_home_tools	@title nvarchar(max),  @ag_image nvarchar(max),  @description nvarchar(max),	@city nvarchar(max),  @tavafoghi bit,
								@price int,	@ag_date date,	@ag_status nvarchar(50),  @is_immediate bit,  @dastebandi nvarchar(max),

								@tool_name nvarchar(max),	@tool_type_name nvarchar(max),	@color nvarchar(max),	@brand nvarchar(max)
as begin


insert into agahi values(@title,@ag_image,@description,@city,@tavafoghi,@price,@ag_date,@ag_status,@is_immediate,N'لوازم خانه')

declare @id int
set @id = (select top 1 id from agahi order by id DESC)

declare @tool_type_id int
set @tool_type_id= (select id from dastebandi where daste_name=@tool_name and daste_type=@tool_type_name)

insert into home_tools values(@id,@tool_type_id,@color,@brand)
end
go


--3 (house)
create proc proc_insert_house	    @title nvarchar(max),  @ag_image nvarchar(max),  @description nvarchar(max),	@city nvarchar(max),  @tavafoghi bit,
								@price int,	@ag_date date,	@ag_status nvarchar(50),  @is_immediate bit,  @dastebandi nvarchar(max),

								@metraj int,	@h_address nvarchar(max),	@floor_num int,	@build_date date,	@room_num int,	@elevator bit,
								@anbari bit,	@shakhsi bit,	@parking bit,	@deal_type nvarchar(max),	@suitable_for nvarchar(max), @sale bit


as begin


insert into agahi values(@title,@ag_image,@description,@city,@tavafoghi,@price,@ag_date,@ag_status,@is_immediate,N'املاک')

declare @id int
set @id = (select top 1 id from agahi order by id DESC)

insert into house values(@id,@metraj,@h_address,@floor_num,@build_date,@room_num,@elevator,@anbari,@shakhsi,@parking,@deal_type,@suitable_for,@sale)
end
go


--4 (other)
create proc proc_insert_other  @title nvarchar(max),  @ag_image nvarchar(max),  @description nvarchar(max),	@city nvarchar(max),  @tavafoghi bit,
							@price int,	@ag_date date,	@ag_status nvarchar(50),  @is_immediate bit,  @dastebandi nvarchar(max),

							@tool_name nvarchar(max),	@tool_type_name nvarchar(max)
as begin
insert into agahi values (@title,@ag_image,@description,@city,@tavafoghi,@price,@ag_date,@ag_status,@is_immediate,N'متفرقه')

declare @id int
set @id = (select top 1 id from agahi order by id DESC)

declare @tool_type_id int
set @tool_type_id= (select id from dastebandi where daste_name=@tool_name and daste_type=@tool_type_name)

insert into other values(@id,@tool_type_id)
end
go


--5 (personal_tools)
create proc proc_insert_personal_tools  @title nvarchar(max),  @ag_image nvarchar(max),  @description nvarchar(max),	@city nvarchar(max),  @tavafoghi bit,
									@price int,	@ag_date date,	@ag_status nvarchar(50),  @is_immediate bit,  @dastebandi nvarchar(max),

									@tool_name nvarchar(max),	@tool_type_name nvarchar(max),	@color nvarchar(max),	@for_male bit
as begin
insert into agahi values(@title,@ag_image,@description,@city,@tavafoghi,@price,@ag_date,@ag_status,@is_immediate,N'لوازم شخصی')

declare @tool_type_id int
set @tool_type_id= (select id from dastebandi where daste_name=@tool_name and daste_type=@tool_type_name)

declare @id int
set @id = (select top 1 id from agahi order by id DESC)

insert into personal_tools values(@id,@tool_type_id,@color,@for_male)
end
go


--6 (vehicle)
create proc proc_insert_vehicle  @title nvarchar(max),  @ag_image nvarchar(max),  @description nvarchar(max),	@city nvarchar(max),  @tavafoghi bit,
							@price int,	@ag_date date,	@ag_status nvarchar(50),  @is_immediate bit,  @dastebandi nvarchar(max),

							@color nvarchar(max),	@karkaed nvarchar(max),	@motor_status nvarchar(max),	@shasi_badane_status nvarchar(max),
							@third_person_insuranse_deadline date,	@sanad bit,	@gearbox nvarchar(max),	@payment_type nvarchar(max),  @made_date date,  @brand nvarchar(max)
							
as begin
insert into agahi values(@title,@ag_image,@description,@city,@tavafoghi,@price,@ag_date,@ag_status,@is_immediate,N'وسیله نقلیه')

declare @id int
set @id = (select top 1 id from agahi order by id DESC)

insert into vehicle values(@id,@color,@karkaed,@motor_status,@shasi_badane_status,@third_person_insuranse_deadline,@sanad,@gearbox,@payment_type,@made_date,@brand)
end
go