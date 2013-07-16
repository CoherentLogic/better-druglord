'
' keyb.bi
'  keyboard constants
'

#ifndef __KEYB_BI__
#define __KEYB_BI__
const K_LEFT as string = chr$(255) + "K"
const K_RIGHT as string = chr$(255) + "M"
const K_UP as string = chr$(255) + "H"
const K_DOWN as string = chr$(255) + "S"
const K_ESC as string = chr$(27)
const K_BS as string = chr$(8)
const K_TAB as string = chr$(9)
const K_PGUP as string = chr$(255) + "I"
const K_PGDOWN as string = chr$(255) + "Q"
const K_HOME as string = CHR$(255) + "G"
const K_END as string = CHR$(255) + "O"
const K_INSERT = CHR$(255) + "R"
const K_ENTER = CHR$(13)
const K_F1 = CHR$(255) + CHR$(59)
const K_F2 = CHR$(255) + CHR$(60)
const K_F4 = CHR$(255) + CHR$(62)
const K_F5 = CHR$(255) + CHR$(63)
const K_F6 = CHR$(255) + CHR$(64)
const K_F7 = CHR$(255) + CHR$(65)
const K_F8 = CHR$(255) + CHR$(66)
const K_F9 = CHR$(255) + CHR$(67)
const K_F10 = CHR$(255) + CHR$(68)
const K_F11 = CHR$(255) + CHR$(133)
const K_F12 = CHR$(255) + CHR$(134)
const K_CTRLC = CHR$(3)
const K_CTRLS = CHR$(19)
const K_CTRLT = CHR$(20)
const K_CTRLQ = CHR$(17)
const K_CTRLW = CHR$(23)
#endif