'
' ioevent.bas
'
#include "IOEVENT.BI"
#include "KEYB.BI"

public function get_next_event(input_mode as integer) as integer
    
    select case input_mode
        case IMODE_KEYBOARD
            dim keyboard_input as string
            keyboard_input = inkey$

            select case keyboard_input
                case K_UP
                    return IEVT_MOTION_UP
                case K_DOWN
                    return IEVT_MOTION_DOWN
                case K_LEFT
                    return IEVT_MOTION_LEFT
                case K_RIGHT
                    return IEVT_MOTION_RIGHT
                case "B"
                    return IEVT_INVENTORY_TOGGLE
                case K_TAB
                    return IEVT_FIELD_NEXT
                case K_BACKSPACE
                    return IEVT_ERASE_LEFT
                case K_DEL
                    return IEVT_ERASE_RIGHT
                case K_PGUP
                    return IEVT_NEXT_PAGE
                case K_PGDOWN
                    return IEVT_PREVIOUS_PAGE
                case K_ESC
                    return IEVT_EXIT
                case K_F1
                    return IEVT_HELP
                case K_F2
                    return IEVT_SAVE
                case K_F5
                    return IEVT_REFRESH
                case else
                    if keyboard_input <> "" then
                        last_key_pressed = keyboard_input
                        return IEVT_KEYPRESS
                    else
                        return IEVT_NONE
                    end if
            end select
        case IMODE_JOYSTICK
            return IEVT_NONE
    end select

end function

