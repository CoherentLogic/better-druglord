'
' REGION.BAS
'
#include "region.bi"

redim shared regions(1) as region
dim shared region_index as integer

public sub region_init()
    region_index = 1
end sub

public function new_region(region_struct as region) as integer
    dim ret_val as integer

    redim preserve regions(region_index) as region

    with region_struct
        .width = region_struct.bottom_right_col - region_struct.top_left_col
        .height = region_struct.bottom_right_row - region_struct.top_left_row
    end with

    regions(region_index) = region_struct

    clear_region(region_index)
    text_to_region(region_index, 1, 1, regions(region_index).t_buffer)

    ret_val = region_index
    region_index += 1

    return ret_val
end function

public function region_width(idx as integer) as integer
	return regions(idx).width
end function

public function region_height(idx as integer) as integer
	return regions(idx).height
end function


public sub clear_region(idx as integer)
    dim row as integer
    dim col as integer

    for row = regions(idx).top_left_row to regions(idx).bottom_right_row
        for col = regions(idx).top_left_col to regions(idx).bottom_right_col
            locate row, col
            color regions(idx).forecolor, regions(idx).backcolor
            print " ";
        next col
    next row

end sub

public sub region_locate(idx as integer, row as integer, col as integer)
	locate reg_scr_row(idx, row), reg_scr_col(idx, col)
end sub

public function get_string_region(idx as integer, row as integer, _
                                  col as integer, prompt as string) as string
    dim retval as string

    region_locate(idx, row, col)
    color regions(idx).forecolor, regions(idx).backcolor

    line input prompt, retval

    return retval

end function

public function get_integer_region(idx as integer, row as integer, _
                                  col as integer, prompt as string) as integer

    dim retval as integer

    region_locate(idx, row, col)
    color regions(idx).forecolor, regions(idx).backcolor
    
    print prompt;
    input " ", retval

    return retval


end function

public function get_float_region(idx as integer, row as integer, _
                                  col as integer, prompt as string) as single

    dim retval as single

    region_locate(idx, row, col)
    color regions(idx).forecolor, regions(idx).backcolor

    print prompt;
    input " ", retval

    return retval

end function

public sub text_to_region(idx as integer, row as integer, _ 
                          col as integer, text as string)
    dim i as integer
    dim c as string
    dim cr as integer
    dim cc as integer
    
    cr = row
    cc = col

    for i = 1 to len(text)
        c = mid(text, i, 1)

        locate reg_scr_row(idx, cr), reg_scr_col(idx, cc)
        color regions(idx).forecolor, regions(idx).backcolor
        print c

        if cc = regions(idx).bottom_right_col then
            cc = 1
            if cr < regions(idx).bottom_right_row then
            	cr += 1
            else
            	exit sub
            end if
        else
            cc += 1
        end if
    
    next i
            
end sub


public function reg_scr_col(idx as integer, col as integer) as integer

    dim ret_val as integer

    col = col -1
    ret_val = col + regions(idx).top_left_col

    return ret_val

end function

public function reg_scr_row(idx as integer, row as integer) as integer
    
    dim ret_val as integer

    row = row - 1
    ret_val = row + regions(idx).top_left_row

    return ret_val

end function
