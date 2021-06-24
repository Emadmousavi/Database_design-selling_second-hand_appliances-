exec city_filter @city=N'زنجان'

exec dastebandi_filter @dastebandi=N'لوازم الکترونیکی'

exec dastebandi_field_filter @dastebandi=N'house' , @field=N'floor_num', @value=3

exec starred_filter @user_id=100

exec date_filter @date='2021-10-29'

exec title_search @text=N'پراید'

exec has_image_filter 

exec tavafoghi_filter

exec is_immediate_filter

exec users_with_more_than_ten_agahi

exec price_range @least_price=3000000, @most_price=12000000

exec others_group @name=N'لوازم خانه'

exec unpublished_agahi

exec message_number

exec home_with_parking

exec total_sales

exec new_vehicles

exec average_sell

exec all_new_peride

exec verified_agahi_by_monitoring @id=100








