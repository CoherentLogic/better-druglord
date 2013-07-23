#ifndef __LEVEL_BI__
#define __LEVEL_BI__	

declare sub level_editor()
declare sub level_editor_init()
declare sub le_set_page(page_number as integer)
declare sub le_set_coords(row as integer, col as integer)
declare sub le_repaint()
declare sub le_bounds_check()
declare sub le_set_data(element_type as integer, metadata as integer)
declare sub le_file_load(filename as string)
declare sub le_file_write()
declare sub le_init_npc(idx as integer)
declare sub le_init_vendor(idx as integer)
declare function le_choose_faction() as integer
declare function le_choose_weapon() as integer
declare sub le_set_npc()
declare function le_yes_no(prompt as string) as integer
declare sub le_set_vendor()

common shared level_current_page as integer
common shared level_total_pages as integer
common shared level_current_row as integer
common shared level_current_col as integer
common shared level_repaint_flag as integer
common shared level_filename as string
common shared level_dirty as integer

type level_header
	magic as string * 4                 'DLEL
    major_version as integer
    minor_version as integer
    revision as integer
	level_name as string * 30
	level_description as string * 255
	page_count as integer
    npc_count as integer
    vendor_count as integer
end type

type npc_record
    index as integer
    npc_name as string * 30
    npc_description as string * 255
    npc_exalted_greeting as string * 50
    npc_revered_greeting as string * 50
    npc_honored_greeting as string * 50
    npc_friendly_greeting as string * 50
    npc_neutral_greeting as string * 50
    npc_hostile_greeting as string * 50
    faction as integer
    weapon as integer
    health_points as integer
    level as integer
end type

type vendor_record
    index as integer
    vendor_name as string * 30
    vendor_exalted_greeting as string * 50
    vendor_revered_greeting as string * 50
    vendor_honored_greeting as string * 50
    vendor_friendly_greeting as string * 50
    vendor_neutral_greeting as string * 50
    vendor_hostile_greeting as string * 50
    faction as integer
    weapon as integer
    stock_cannabis as integer
    price_cannabis as integer
    stock_cocaine as integer 
    price_cocaine as integer   
    stock_heroin as integer
    price_heroin as integer
    stock_knives as integer
    price_knives as integer
    stock_brassknuckles as integer
    price_brassknuckles as integer
    stock_handguns as integer
    price_handguns as integer
    stock_rifles as integer
    price_rifles as integer
    stock_machineguns as integer
    price_machineguns as integer
end type

type page_record
    page_number as integer
	page_data(19,59) as integer
	page_metadata(19,59) as integer
end type

common shared le_header as level_header

const ELEM_NONE as integer = 0
const ELEM_WALL as integer = 1
const ELEM_NPC as integer = 2
const ELEM_VENDOR as integer = 3
const ELEM_FOOD as integer = 4
const ELEM_WEAPON as integer = 5
const ELEM_STREET as integer = 6
const ELEM_MONEY as integer = 7

const WEAPON_NONE = 0
const WEAPON_FISTS = 1
const WEAPON_BRASSKNUCKLES = 2
const WEAPON_KNIFE = 3
const WEAPON_HANDGUN = 4
const WEAPON_RIFLE = 5
const WEAPON_MACHINEGUN = 6

#ifdef __FB_DOS__
    const REND_WALL as string = chr(219)
    const REND_STREET as string = chr(176)
    const REND_NPC_SAFE as string = "n"
    const REND_NPC_UNSAFE as string = "N"
    const REND_VENDOR_SAFE as string = "v"
    const REND_VENDOR_UNSAFE as string = "V"
    const REND_WEAPON = "W"
    const REND_FOOD = "F"
#endif

#ifdef __FB_LINUX__
    
#endif

#ifdef __FB_WIN32__

#endif

#endif
