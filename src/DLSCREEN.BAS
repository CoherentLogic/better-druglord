#include "region.bi"
#include "dlscreen.bi"

public sub screen_init()
   color 7,0
   cls

	' define screen regions
	dim sr_temp as region
	
	with sr_temp
		.top_left_row = 1
		.top_left_col = 1
		.bottom_right_row = 1
		.bottom_right_col = 11
		.forecolor = 15
		.backcolor = 0
		.t_buffer = ""
	end with
	sridx_hp = new_region(sr_temp)

	with sr_temp
		.top_left_row = 1
		.top_left_col = 12
		.bottom_right_row = 1
		.bottom_right_col = 20
		.forecolor = 15
		.backcolor = 0
		.t_buffer = ""
	end with
	sridx_money = new_region(sr_temp)

	with sr_temp
		.top_left_row = 1
		.top_left_col = 21
		.bottom_right_row = 1
		.bottom_right_col = 41
		.forecolor = 15
		.backcolor = 0
		.t_buffer = ""
	end with
	sridx_moniker = new_region(sr_temp)

	with sr_temp
		.top_left_row = 1
		.top_left_col = 42
		.bottom_right_row = 1
		.bottom_right_col = 52
		.forecolor = 15
		.backcolor = 0
		.t_buffer = ""
	end with
	sridx_vp = new_region(sr_temp)

	with sr_temp
		.top_left_row = 1
		.top_left_col = 53
		.bottom_right_row = 1
		.bottom_right_col = 60
		.forecolor = 12
		.backcolor = 0
		.t_buffer = ""
	end with
	sridx_tp = new_region(sr_temp)

	with sr_temp
		.top_left_row = 2
		.top_left_col = 1
		.bottom_right_row = 21
		.bottom_right_col = 60
		.forecolor = 15
		.backcolor = 1
		.t_buffer = ""
	end with
	sridx_playfield = new_region(sr_temp)

	with sr_temp
		.top_left_row = 2
		.top_left_col = 61
		.bottom_right_row = 21
		.bottom_right_col = 80
		.forecolor = 15
		.backcolor = 0
		.t_buffer = ""
	end with
	sridx_menu_area = new_region(sr_temp)
	
	with sr_temp
		.top_left_row = 22
		.top_left_col = 1
		.bottom_right_row = 24
		.bottom_right_col = 60
		.forecolor = 12
		.backcolor = 0
		.t_buffer = "Welcome to DRUGLORD."
	end with
	sridx_dialog = new_region(sr_temp)
	
	with sr_temp
		.top_left_row = 22
		.top_left_col = 61
		.bottom_right_row = 24
		.bottom_right_col = 80
		.forecolor = 15
		.backcolor = 0
		.t_buffer = ""
	end with
	sridx_npc_info = new_region(sr_temp)
end sub


