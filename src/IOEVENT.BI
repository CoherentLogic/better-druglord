#ifndef __IOEVENT_BI__
#define __IOEVENT_BI__

common shared last_key_pressed as string

declare function get_next_event(input_mode as integer) as integer

'IMODE constants
const IMODE_KEYBOARD as integer = 0
const IMODE_JOYSTICK as integer = 1

'IEVT constants
const IEVT_NONE as integer = 0

'MOTION events
const IEVT_MOTION_UP as integer = 1
const IEVT_MOTION_DOWN as integer = 2
const IEVT_MOTION_LEFT as integer = 3
const IEVT_MOTION_RIGHT as integer = 4
const IEVT_PREVIOUS_PAGE as integer = 5
const IEVT_NEXT_PAGE as integer = 6

'INVENTORY events
const IEVT_INVENTORY_TOGGLE as integer = 20

'FIELD events
const IEVT_FIELD_NEXT as integer = 30
const IEVT_FIELD_PREVIOUS as integer = 31

'GENERIC events
const IEVT_EXIT as integer = 50
const IEVT_KEYPRESS as integer = 51
const IEVT_ERASE_LEFT as integer = 52
const IEVT_ERASE_RIGHT as integer = 53
const IEVT_SAVE as integer = 54
const IEVT_HELP as integer = 55
const IEVT_REFRESH as integer = 56
#endif
