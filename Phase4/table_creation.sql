create table users
(
	id				int	identity(100,1)		primary key,
	usr_name		nvarchar(50)			unique,
	mobile_number	char(11),
	f_name			nvarchar(20),
	l_name			nvarchar(20),
	email			nvarchar(150)			unique,
	pass			nvarchar(Max),			
	addresses		nvarchar(150)
);

create table agahi
(	
	id				int identity(500,1)		primary key,
	title			nvarchar(20),
	ag_image		nvarchar(200),
	descriptions	nvarchar(1000),
	city			nvarchar(50),
	tavafoghi		bit,
	price			int,
	ag_date			date,
	ag_status		nvarchar(20),
	is_immediate	bit,
	dastebandi		nvarchar(50)
);

create table support
(
	id			int identity(100,1)		primary key,
	dep_name	nvarchar(50)
);

create table monitoring
(
	id			int identity(200,1)		primary key,
	dep_name	nvarchar(50)
);


create table special_user
(
	id				int					foreign key references users(id) on delete cascade	on update cascade,
	access_name		nvarchar(50),
	support_dep		int			        foreign key references support(id),
	monitor_dep		int					foreign key references monitoring(id),
	sp_type			nvarchar(50),
	primary key(id)
);

create table chat
(
	usr_id_1		int					foreign key references users(id),
	usr_id_2		int					foreign key references users(id),
	chat_id			int identity(1,1),
	chat_text		nvarchar(1000),
	chat_date		date,
	primary key(usr_id_1,usr_id_2,chat_id),
);

create table ticket
(
	usr_id			int							foreign key references users(id) ,
	support_id		int							foreign key references special_user(id) ,
	ticket_id		int identity(1,1),
	primary key(usr_id,support_id,ticket_id),
);

create table publish
(
	usr_id			int					foreign key references users(id),
	agahi_id		int					foreign key references agahi(id),
	primary key(usr_id,agahi_id),
);

create table verify
(
	agahi_id		int					foreign key references agahi(id) ,
	monitor_id		int					foreign key references special_user(id) ,
	primary key(agahi_id,monitor_id),
);

create table starred
(
	usr_id			int					foreign key references users(id) ,
	agahi_id		int					foreign key references agahi(id),
	primary key(usr_id,agahi_id),
);

create table used_stage
(
	usid			int	identity(10,1)		primary key,
	us_type			nvarchar(50)			unique,
);


create table company
(
	id				int	identity(10,1)		primary key,
	cmp_name		nvarchar(50)			unique
);

create table electronic_device
(
	id				int					foreign key references agahi(id) on delete cascade	on update cascade,
	dv_name			nvarchar(50),
	brand			nvarchar(50),
	usid			int					foreign key references used_stage(usid),
	company_id		int					foreign key references company(id),
	primary key(id)
);


create table house
(
	id				int					foreign key references agahi(id) on delete cascade	on update cascade,
	metraj			int,
	h_address		nvarchar(1000),
	floor_num		int,
	build_date		date,
	room_num		int,
	elevator		bit,
	anbari			bit,
	shakhsi			bit,			/* if not it is for amlak*/
	parking			bit,
	deal_type		nvarchar(50),
	suitable_for	nvarchar(50),
	sale			bit,			/* if not it is for rent*/
	primary key(id),

	check (deal_type in (N'فروش', N'رهن', N'اجاره')) 
);

create table vehicle
(
	id								int					foreign key references agahi(id) on delete cascade	on update cascade,
	color							nvarchar(20),
	karkard							int,
	motor_status					nvarchar(30),
	shasi_badane_status				nvarchar(50),
	third_person_insuranse_deadline	date,
	sanad							bit,
	gearbox							nvarchar(20),		/* manual or automatic*/
	payment_type					nvarchar(50),
	made_date						date,
	brand							nvarchar(50),
	primary key(id),
);

create table dastebandi
(
	id				int	identity(10,1)		primary key,
	daste_name		nvarchar(50),
	daste_type		nvarchar(max)
);

create table home_tools
(
	id				int				foreign key references agahi(id) on delete cascade	on update cascade,
	tool_type_id	int				foreign key references dastebandi(id),
	color			nvarchar(50),
	brand			nvarchar(50),
	primary key(id),
);

create table personal_tools
(
	id				int				foreign key references agahi(id) on delete cascade	on update cascade,
	tool_type_id	int				foreign key references dastebandi(id) ,
	color			nvarchar(50),
	for_male		bit,
	primary key(id),
);

create table other
(
	dastebandi_id	int				foreign key references dastebandi(id) ,
	id				int				foreign key references agahi(id) on delete cascade	on update cascade,
	primary key(id),
);

