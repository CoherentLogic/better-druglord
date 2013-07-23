'
' level.bas
'

#include "IOEVENT.BI"
#include "REGION.BI"
#include "DLSCREEN.BI"
#include "LEVEL.BI"
#include "FACTION.BI"
#include "file.bi"

extern input_mode as integer

redim shared le_pages(1) as page_record
redim shared le_npcs(1) as npc_record
redim shared le_vendors(1) as vendor_record

public sub level_editor()
   
    level_current_page = 1

    level_editor_init()

    dim e as integer   

    do until e = IEVT_EXIT
        e = get_next_event(input_mode)

        select case e
            case IEVT_PREVIOUS_PAGE
                le_set_page(level_current_page - 1)
            case IEVT_NEXT_PAGE
                le_set_page(level_current_page + 1)
            case IEVT_MOTION_UP
                le_set_coords(level_current_row - 1, level_current_col)
            case IEVT_MOTION_DOWN
                le_set_coords(level_current_row + 1, level_current_col)
            case IEVT_MOTION_LEFT
                le_set_coords(level_current_row, level_current_col - 1)
            case IEVT_MOTION_RIGHT
                le_set_coords(level_current_row, level_current_col + 1)
            case IEVT_HELP
                
            case IEVT_SAVE
                le_file_write()
            case IEVT_REFRESH
                level_repaint_flag = 1
            case IEVT_KEYPRESS
                select case last_key_pressed                   
                    case "w"
                        le_set_data(ELEM_WALL, 0)
                    case "n"
                        le_set_npc()
                    case "v"
                        le_set_vendor()
                end select
            case IEVT_ERASE_RIGHT
                le_set_data(ELEM_NONE, 0)
        
        end select

        if level_repaint_flag = 1 then
            le_repaint()
        end if
    loop            
end sub

public sub level_editor_init()
    dim i as integer

    color 7, 0
    cls

    level_dirty = 0    

    line input "Filename? ", level_filename

    level_filename = ucase(left(level_filename, 8)) + ".DLV"

    if not fileexists(level_filename) then
        input "Pages? ", level_total_pages
        le_header.page_count = level_total_pages
        line input "Level name? ", le_header.level_name
        line input "Level description? ", le_header.level_description
        input "NPC count? ", le_header.npc_count
        input "Vendor count? ", le_header.vendor_count

        with le_header
            .magic = "DLEL"
            .major_version = 0
            .minor_version = 1
            .revision = 1
        end with

        redim le_pages(level_total_pages) as page_record
        redim le_npcs(le_header.npc_count) as npc_record
        redim le_vendors(le_header.vendor_count) as vendor_record

        for i = 0 to le_header.npc_count - 1
            le_init_npc(i)
        next i

        for i = 0 to le_header.vendor_count - 1
            le_init_vendor(i)
        next i

        level_dirty = 1
    else
        le_file_load(level_filename)
    end if

    cls

    'clear regions
    clear_region(sridx_playfield)
    clear_region(sridx_moniker)
    clear_region(sridx_menu_area)
    clear_region(sridx_hp)

    'populate regions
    text_to_region(sridx_moniker, 1, 1, "Level Editor")    
    le_set_page(1)
    le_set_coords(20, 30)
end sub

public sub le_file_write()
    
    '
    ' file layout
    '   HEADER
    '   NPC RECORDS
    '   VENDOR RECORDS
    '   PAGE RECORDS
    '

    dim i as integer
    dim file_number as integer
    file_number = freefile

    open level_filename for binary as #file_number

    le_header.magic = "DLEL"
    put #file_number, , le_header

    for i = 0 to le_header.npc_count - 1
        put #file_number, , le_npcs(i)
    next i

    for i = 0 to le_header.vendor_count - 1
        put #file_number, , le_vendors(i)
    next i

    for i = 0 to le_header.page_count - 1
        put #file_number, , le_pages(i)
    next i

    close #file_number 
    level_dirty = 0

    clear_region(sridx_dialog)
    text_to_region(sridx_dialog, 1, 1, "Level saved as " + level_filename)
end sub

public sub le_file_load(filename as string)
    
    '
    ' file layout
    '   HEADER
    '   NPC RECORDS
    '   VENDOR RECORDS
    '   PAGE RECORDS
    '
    dim i as integer
    dim file_number as integer
    file_number = freefile

    if not fileexists(filename) then
        clear_region(sridx_dialog)
        text_to_region(sridx_dialog, 1, 1, "ERROR: File does not exist.")
        exit sub
    end if

    open filename for binary as #file_number
    
    get #file_number, , le_header
    

    if le_header.magic <> "DLEL" then
        clear_region(sridx_dialog)
        text_to_region(sridx_dialog, 1, 1, "ERROR: Invalid file format or file corrupt")
        exit sub
    end if
  
    level_total_pages = le_header.page_count
    redim le_pages(le_header.page_count) as page_record
    redim le_npcs(le_header.npc_count) as npc_record
    redim le_vendors(le_header.vendor_count) as vendor_record

    for i = 0 to le_header.npc_count - 1
        get #file_number, , le_npcs(i)
    next i

    for i = 0 to le_header.vendor_count - 1
        get #file_number, , le_vendors(i)
    next i
    
    for i = 0 to le_header.page_count - 1
        get #file_number, , le_pages(i)
    next i

    close #file_number
    
    level_repaint_flag = 1
    le_set_page(1)

end sub

public sub le_set_data(element_type as integer, metadata as integer)
    le_pages(level_current_page).page_data(level_current_row, level_current_col) = element_type
    le_pages(level_current_page).page_metadata(level_current_row, level_current_col) = metadata
    
    level_repaint_flag = 1
end sub

public sub le_set_npc()
    dim npc_idx as integer
    dim prompt as string

    clear_region(sridx_dialog)
    prompt = "Choose NPC (0-" + ltrim(rtrim(str(le_header.npc_count - 1))) + "): "
    
    npc_idx = get_integer_region(sridx_dialog, 1, 1, prompt)

    le_set_data(ELEM_NPC, npc_idx)
    clear_region(sridx_dialog)
    
    level_dirty = 1
    level_repaint_flag = 1    
end sub

public sub le_set_vendor()
    dim vendor_idx as integer
    dim prompt as string

    clear_region(sridx_dialog)
    prompt = "Choose Vendor (0-" + ltrim(rtrim(str(le_header.vendor_count - 1))) + "): "
    
    vendor_idx = get_integer_region(sridx_dialog, 1, 1, prompt)

    le_set_data(ELEM_VENDOR, vendor_idx)
    clear_region(sridx_dialog)
    
    level_dirty = 1
    level_repaint_flag = 1    
end sub


public sub le_repaint()
    dim r as integer
    dim c as integer
    dim txt as string

    for r = 1 to 20
        for c = 1 to 60
            select case le_pages(level_current_page).page_data(r, c)
                case ELEM_NONE
                    txt = " "
                case ELEM_WALL
                    txt = "."  
                case ELEM_NPC
                    txt = "N"
                case ELEM_VENDOR
                    txt = "V"              
            end select
            
            text_to_region(sridx_playfield, r, c, txt)            
        next c
    next r

    region_locate(sridx_playfield, level_current_row, level_current_col)

    level_repaint_flag = 0
end sub

public sub le_bounds_check()
    if level_current_row > 20 then
        level_current_row = 20
    end if
    if level_current_row < 1 then
        level_current_row = 1
    end if
    if level_current_col < 1 then
        level_current_col = 1       
    end if
    if level_current_col > 60 then
        level_current_col = 60       
    end if
    if level_current_page > level_total_pages then
        level_current_page = level_total_pages
    end if
    if level_current_page < 1 then
        level_current_page = 1
    end if
end sub

public sub le_set_page(page_number as integer)
    dim pg_text as string

    if page_number <> level_current_page then
        level_repaint_flag = 1
    end if

    level_current_page = page_number

    le_bounds_check()

    pg_text = trim(str(level_current_page)) + " OF " + trim(str(level_total_pages))
    clear_region(sridx_hp)
    text_to_region(sridx_hp, 1, 1, pg_text)
end sub    

public sub le_set_coords(row as integer, col as integer)
    dim coords_text as string

    level_current_row = row
    level_current_col = col

    le_bounds_check()
    
    coords_text = trim(str(level_current_row)) + ", " + trim(str(level_current_col))
    clear_region(sridx_money)
    text_to_region(sridx_money, 1, 1, coords_text)

    region_locate(sridx_playfield, level_current_row, level_current_col)
    level_repaint_flag = 0
end sub

public sub le_init_npc(idx as integer)
    print "NPC " + ltrim(rtrim(str(idx))) + " Parameters:"
    print
    
    le_npcs(idx).index = idx

    line input " Name:              ", le_npcs(idx).npc_name
    line input " Description:       ", le_npcs(idx).npc_description
    line input " Hostile Greeting:  ", le_npcs(idx).npc_hostile_greeting
    line input " Neutral Greeting:  ", le_npcs(idx).npc_neutral_greeting
    line input " Friendly Greeting: ", le_npcs(idx).npc_friendly_greeting
    line input " Honored Greeting:  ", le_npcs(idx).npc_honored_greeting
    line input " Revered Greeting:  ", le_npcs(idx).npc_revered_greeting
    line input " Exalted Greeting:  ", le_npcs(idx).npc_exalted_greeting
    input      " Health Points:     ", le_npcs(idx).health_points
    input      " Level (1-100):     ", le_npcs(idx).level

    le_npcs(idx).faction = le_choose_faction()
    le_npcs(idx).weapon = le_choose_weapon()        
end sub

public sub le_init_vendor(idx as integer)
    print "Vendor " + ltrim(rtrim(str(idx))) + " Parameters:"
    print

    le_vendors(idx).index = idx

    line input " Name:              ", le_vendors(idx).vendor_name
    line input " Hostile Greeting:  ", le_vendors(idx).vendor_hostile_greeting
    line input " Neutral Greeting:  ", le_vendors(idx).vendor_neutral_greeting
    line input " Friendly Greeting: ", le_vendors(idx).vendor_friendly_greeting
    line input " Honored Greeting:  ", le_vendors(idx).vendor_honored_greeting
    line input " Revered Greeting:  ", le_vendors(idx).vendor_revered_greeting
    line input " Exalted Greeting:  ", le_vendors(idx).vendor_exalted_greeting
    
    le_vendors(idx).faction = le_choose_faction()
    le_vendors(idx).weapon = le_choose_weapon()

    le_vendors(idx).stock_cannabis = le_yes_no("Vendor stocks cannabis? ")
    if le_vendors(idx).stock_cannabis = 1 then
        input "Cannabis price/gm: ", le_vendors(idx).price_cannabis
    end if

    le_vendors(idx).stock_cocaine = le_yes_no("Vendor stocks cocaine? ")
    if le_vendors(idx).stock_cocaine = 1 then
        input "Cocaine price/gm: ", le_vendors(idx).price_cocaine
    end if

    le_vendors(idx).stock_heroin = le_yes_no("Vendor stocks heroin? ")
    if le_vendors(idx).stock_heroin = 1 then
        input "Heroin price/gm: ", le_vendors(idx).price_heroin
    end if

    le_vendors(idx).stock_knives = le_yes_no("Vendor stocks knives? ")
    if le_vendors(idx).stock_knives = 1 then
        input "Knives price/ea: ", le_vendors(idx).price_knives
    end if

    le_vendors(idx).stock_brassknuckles = le_yes_no("Vendor stocks brass knuckles? ")
    if le_vendors(idx).stock_brassknuckles = 1 then
        input "Brass knuckles price/ea: ", le_vendors(idx).price_brassknuckles
    end if

    le_vendors(idx).stock_handguns = le_yes_no("Vendor stocks handguns? ")
    if le_vendors(idx).stock_handguns = 1 then
        input "Handguns price/ea: ", le_vendors(idx).price_handguns
    end if

    le_vendors(idx).stock_rifles = le_yes_no("Vendor stocks rifles? ")
    if le_vendors(idx).stock_rifles = 1 then
        input "Rifles price/ea: ", le_vendors(idx).price_rifles
    end if

    le_vendors(idx).stock_machineguns = le_yes_no("Vendor stocks machine guns? ")
    if le_vendors(idx).stock_machineguns = 1 then
        input "Machine guns price/ea: ", le_vendors(idx).price_machineguns
    end if


end sub

public function le_yes_no(prompt as string) as integer
    dim e as integer

lprompt:
    print prompt;" (Y/N): ";

    do until e <> IEVT_NONE
        e = get_next_event(input_mode)
    loop

    select case ucase(last_key_pressed)
        case "Y"
            return 1
        case "N"
            return 0
        case else
            print "Invalid response. Must choose Y or N."
            goto lprompt
    end select
    
end function

public function le_choose_weapon() as integer
    dim wep as integer

    print
    print "Choose Weapon: "
    print
    print "0. None"
    print "1. Bare Fists"
    print "2. Brass Knuckles"
    print "3. Knife"
    print "4. Handgun"
    print "5. Rifle"
    print "6. Machine Gun"
    print
    input "  Choose 0-6: ", wep
    
    return wep
end function

public function le_choose_faction() as integer
    dim fac as integer

    print
    print "Choose Faction: "
    print
    print "0. Mexican Military"
    print "1. Los Zetas Cartel"
    print "2. Sinaloa Cartel"
    print "3. Gulf Cartel"
    print "4. La Familia Cartel"
    print "5. Tijuana Cartel"
    print "6. Beltran-Levya Cartel"
    print "7. Juarez Cartel"
    print "8. Knights Templar Cartel"
    print "9. Civilian"
    print
    input "  Choose 0-9: ", fac

    return fac
end function
