#ifndef __REGION_BI__
#define __REGION_BI__

type region
    ' bounds
    top_left_row as integer
    top_left_col as integer
    bottom_right_row as integer
    bottom_right_col as integer

    ' colors
    forecolor as integer
    backcolor as integer

    ' buffer
    t_buffer as string

    width as integer
    height as integer
end type

declare sub region_init()
declare function new_region(region_struct as region) as integer
declare sub clear_region(idx as integer)
declare sub text_to_region(idx as integer, row as integer, col as integer, text as string)
declare function reg_scr_col(idx as integer, col as integer) as integer
declare function reg_scr_row(idx as integer, row as integer) as integer
declare function region_width(idx as integer) as integer
declare function region_height(idx as integer) as integer
declare sub region_locate(idx as integer, row as integer, col as integer)
declare function get_string_region(idx as integer, row as integer, col as integer, prompt as string) as string
declare function get_integer_region(idx as integer, row as integer, col as integer, prompt as string) as integer
declare function get_float_region(idx as integer, row as integer, col as integer, prompt as string) as single


#endif
