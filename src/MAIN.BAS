'
' main.bas
'  druglord main file
'
#include "IOEVENT.BI"
#include "REGION.BI"
#include "DLSCREEN.BI"
#include "LEVEL.BI"

'*** declarations
declare function dl_main() as integer
declare sub dl_init()
declare sub test_loop()
declare sub main_menu()

common shared scr_width as uinteger
common shared scr_height as uinteger
common shared input_mode as integer


dl_init()     'initialize dl
dl_main()     'jump into main routine

'*** implementation
public sub dl_init()

	dim console_size_byte as integer

	console_size_byte = width()       

	scr_height = hiword(console_size_byte)
	scr_width = loword(console_size_byte)            

	input_mode = IMODE_KEYBOARD
	screen_init()
	clear_region(sridx_playfield)	
	
end sub

public function dl_main() as integer       
	main_menu()

	return 0
end function

public sub main_menu()
	dim choice as integer
	
	choice = IEVT_NONE

	clear_region(sridx_moniker)
	text_to_region(sridx_moniker, 1, 1, "Main Menu")
	
	clear_region(sridx_playfield)
		
	text_to_region(sridx_playfield, 3, 3, "D R U G L O R D")
	text_to_region(sridx_playfield, 5, 3, "1 	New Game")
	text_to_region(sridx_playfield, 6, 3, "2 	Open Game")
	text_to_region(sridx_playfield, 7, 3, "3 	Level Editor")
	text_to_region(sridx_playfield, 8, 3, "4 	Avatar Editor")
	text_to_region(sridx_playfield, 9, 3, "ESC	Exit")
	text_to_region(sridx_playfield, 11, 6, "->")

	
	do until choice = IEVT_EXIT
		
		if choice <> IEVT_NONE then
        	clear_region(sridx_moniker)
        	text_to_region(sridx_moniker, 1, 1, "Main Menu")

			clear_region(sridx_playfield)
		
			text_to_region(sridx_playfield, 3, 3, "D R U G L O R D")
			text_to_region(sridx_playfield, 5, 3, "1 	New Game")
			text_to_region(sridx_playfield, 6, 3, "2 	Open Game")
			text_to_region(sridx_playfield, 7, 3, "3 	Level Editor")
			text_to_region(sridx_playfield, 8, 3, "4 	Avatar Editor")
			text_to_region(sridx_playfield, 9, 3, "ESC	Exit")
			text_to_region(sridx_playfield, 11, 6, "->")
		end if
	
		choice = get_next_event(input_mode)
		
		if choice <> IEVT_NONE then
			clear_region(sridx_dialog)
		end if
		
		if choice = IEVT_KEYPRESS then
			select case last_key_pressed
				case "1"
					text_to_region(sridx_dialog, 1, 1, "New Game")
				case "2"
					text_to_region(sridx_dialog, 1, 1, "Open Game")
				case "3"
					text_to_region(sridx_dialog, 1, 1, "Level Editor")
					level_editor()
				case "4"
					text_to_region(sridx_dialog, 1, 1, "Avatar Editor")
				case else
					beep
					text_to_region(sridx_dialog, 1, 1, "Invalid Choice")
			end select
		end if
		
	loop
	
	color 7, 0
	cls
	end
	
end sub

public sub test_loop()
	dim e as integer

	do until e = IEVT_EXIT
		e = get_next_event(input_mode)

        if e <> IEVT_NONE then
            clear_region(sridx_dialog)
        end if

		select case e
			case IEVT_MOTION_UP
			    text_to_region(sridx_dialog, 1, 1, "MOTION UP")
			case IEVT_MOTION_DOWN
				text_to_region(sridx_dialog, 1, 1, "MOTION DOWN")
			case IEVT_MOTION_LEFT
				text_to_region(sridx_dialog, 1, 1, "MOTION LEFT")
			case IEVT_MOTION_RIGHT
				text_to_region(sridx_dialog, 1, 1, "MOTION RIGHT")
			case IEVT_INVENTORY_TOGGLE
				text_to_region(sridx_dialog, 1, 1, "INVENTORY TOGGLE")
            case IEVT_KEYPRESS
                text_to_region(sridx_dialog, 1, 1, last_key_pressed)
		end select
	loop

end sub
