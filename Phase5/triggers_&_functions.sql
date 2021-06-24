/*functions*/
/*this function returns	elapsed time since agahi release*/
CREATE FUNCTION modateEnteshar(
	@release_date		date
)
RETURNS		int
AS 
BEGIN
	RETURN  DATEDIFF(DAY, @release_date, GETDATE())
END

go



/*2*/
CREATE FUNCTION khone_haye_do_khabe_ya_bishtar()
RETURNS TABLE 
AS
RETURN 
(
	SELECT *
	FROM house	
	WHERE floor_num > 1
);

go

/*3*/
CREATE FUNCTION etelaate_agahi
(
	@ID		int
)
RETURNS TABLE
AS
RETURN
(
	SELECT * 
	FROM agahi
	WHERE agahi.id = @ID
);

go




/*triggers*/

/*this is a table for log data */


--1
CREATE TABLE deleted_users(
	id				INT		PRIMARY KEY,
	usr_name		NVARCHAR(50),
	mobile_number	CHAR(11),
	f_name			NVARCHAR(MAX),
	l_name			NVARCHAR(MAX),
	email			NVARCHAR(150),
	pass			NVARCHAR(MAX),
	addresses		NVARCHAR(MAX),
	deleted_date		DATE
);

GO


CREATE TRIGGER delete_user_trigger
ON USERS
AFTER DELETE	
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO deleted_users
	(
		id,
		usr_name,
		mobile_number,
		f_name,
		l_name,
		email,
		pass,
		addresses,
		deleted_date
	)
	SELECT 
		u.id,
		u.usr_name,
		u.mobile_number,
		u.f_name,
		u.l_name,
		u.email,
		u.pass,
		u.addresses,
		GETDATE()
	FROM 
	deleted u
END

GO




--2
create table Rent_House_in_zanjan
(
	id	int		foreign key references house(id),
	house_image		nvarchar(max),
	house_title		nvarchar(max),
	house_price		int
)
go

create trigger found_new_house_in_zanjan
on house
after insert
as
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Rent_House_in_zanjan
	(
		id,
		house_image,
		house_title,
		house_price
	)
	SELECT 
		i.id,
		ag.ag_image,
		ag.title,
		ag.price
		
	FROM 
	  inserted i join agahi ag on i.id=ag.id

	WHERE ag.city= 'زنجان' and i.deal_type = 'اجاره'
END
go




--3
create table updated_price
(
	id int foreign key references agahi(id),
	price int
)
go


create trigger agahi_updated_price
on agahi
after update
as
	set nocount on
	if update(price)
	BEGIN
	insert into updated_price
	SELECT

		i.id,
		i.price

	FROM	 
		inserted i join deleted d on i.id=d.id
	END

go

--select * from agahi
--update  agahi set price=2000 where id=510
--select * from updated_price
--select * from house
--exec insert_house 'test','test','test',N'زنجان',0,100,'2022/2/12',N'فعال',0,N'متفرقه',10,'test',10,'2022/2/12',10,0,0,0,0,N'اجاره',N'همه',0
--select * from Rent_House_in_zanjan