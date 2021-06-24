alter table users add constraint verify_mobile_number check(mobile_number like '09%')
alter table agahi add constraint verify_agahi_date check(ag_date>getdate())
alter table agahi add constraint agahi_bit_checker check(is_immediate in (0,1))
alter table house add constraint house_bit_checker check(parking in (0,1) and elevator in (0,1) and shakhsi in (0,1) and anbari in (0,1))
alter table house add constraint house_suitabke_for_checker check(suitable_for in (N'همه', N'متاهل', N'مجرد'))
alter table vehicle add constraint vehicle_motor_status_checker check (motor_status in (N'سالم', N'تعویض شده', N'نیاز به تعمیر'))
alter table vehicle add constraint vehicle_shasi_badane_status_checker check (shasi_badane_status in (N'پلمپ', N'تعویض شده', N'ضربه خورده'))
alter table vehicle add constraint vehicle_payment_type_checker check (payment_type in (N'قسطی', N'نقدی'))
alter table vehicle add constraint vehicle_sanad_checker check(sanad in (0,1))
alter table dastebandi add constraint dastebandi_type_checker check(daste_type in (N'متفرقه', N'وسایل شخصی','لوازم خانه'))
alter table agahi add constraint agahi_dastebandi_checker check(dastebandi in (N'متفرقه',N'وسایل شخصی',N'لوازم خانه',N'وسیله نقلیه',N'لوازم الکترونیکی',N'املاک'))
alter table used_stage add constraint us_type_checker check (us_type in (N'نو',N'در حد نو',N'کارکرده',N'نیاز به تعمیر'))
alter table agahi add constraint agahi_status_checker check(ag_status in (N'فعال',N'منتشر نشده',N'فروخته'))





/*update constraint using delete contraint*/
alter table agahi drop constraint agahi_bit_checker
alter table agahi add constraint agahi_bit_checker check(is_immediate in (0,1) and tavafoghi in (0,1))
