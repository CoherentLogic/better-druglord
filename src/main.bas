'
' main.bas
'  druglord main file
'
#include "keyb.bi"

'*** declarations
declare function dl_main() as integer
declare sub dl_init()
declare sub splash_screen()
declare sub main_loop()

common shared scr_width as uinteger
common shared scr_height as uinteger

dl_init()	  'initialize dl
dl_main()	  'jump into main routine

'*** implementation
public sub dl_init()
       dim console_size_byte as integer

       console_size_byte = width()       

       scr_height = hiword(console_size_byte)
       scr_width = loword(console_size_byte)            
end sub

public function dl_main() as integer
       splash_screen()       
       main_loop()

       return 0
end function

public sub splash_screen()
       cls
       locate scr_height, scr_width - 8
       color 15, 0: print "DRUGLORD"
       sleep 5
end sub

public sub main_loop()

       dim key_input as string

       do
              key_input = inkey$

       	      select case key_input
       	      	     case K_LEFT
		     	  print "left"
	             case K_RIGHT
	      	     	  print "right"
	      	     case K_UP
	      	     	  print "up"
	      	     case K_DOWN
	      	          print "down"
		     case K_ESC
			  exit sub			  
	      end select
       loop

end sub