

CREATE VIEW UsersDetail AS
SELECT f_name+' '+l_name as UserFullName,
mobile_number as Phone, addresses as Address,
(select count(*) from starred s where s.usr_id = u.id) as StarredCount,
(select count(*) from publish p where p.usr_id = u.id) as ReleasedAgahiCount,
(select count(*) from ticket t where t.usr_id = u.id) as TicketCount,(case 
when su.access_name is null then 'no special access'
else su.access_name end) as Access
FROM users u
left join special_user su on su.id = u.id;
go

select * from UsersDetail

go
CREATE VIEW Best10Offers AS
SELECT top 10 a.id,title,city,(case 
when a.tavafoghi=0 then '-'
else N'توافقی' end) as Tavafoghi,price,ag_date as [Aghahi Date],dastebandi,(case 
when a.ag_image is null then 'no image available!'
else a.ag_image end) as ImageUrl
FROM agahi a
left join electronic_device ed on ed.id = a.id
where ag_status =N'فعال'
order by a.ag_date,is_immediate desc;
go

select * from Best10Offers;

go
CREATE VIEW SpecialUsersMonitoring AS
select s.id as SUId ,access_name as [Access Level],
dep_name as [Department Name]
from special_user s
left join support s2 on s2.id =s.support_dep
left join verify v on v.monitor_id = s.monitor_dep ;

go
select * from SpecialUsersMonitoring