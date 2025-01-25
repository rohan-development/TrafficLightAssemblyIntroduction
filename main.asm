.include "m328pdef.inc"   ;Include 328P predefines
.equ GREEN = (1<<PB5)     ;Define green LED pin
.equ YELL = (1<<PB4)      ;Define yellow LED pin
.equ RED = (1<<PB3)       ;Define red LED pin
.equ PORT = PORTB	    	  ;Define used port (DDR)
.equ DDR = DDRB			      ;Define used port
ldi r16,GREEN|YELL|RED	  ;Bitmask of 3 pins in r16
out DDR, r16			        ;Put bitmask into DDR
reset:					          ;Label for reset point
ldi r16,GREEN			        ;Put green into the bitmask
run:					            ;"Loop" label
out PORT,r16			        ;Write out current colour
rcall delay1s			        ;Wait 1 second
cpi r16,YELL		      	  ;Check if YELL is in r16
breq yellow				        ;Branch if YELL was in r16
rcall delay1s			        ;Wait another second if not yellow
yellow:					          ;Label for when colour=yellow
lsr r16					          ;Shift colour down 1 bit
cpi r16,(1<<PB2)		      ;Check if colours overflowed
breq reset				        ;If overflowed, reset colour
rjmp run				          ;If no overflow, loop again
delay1s:				          ;Delay 1 second function
  ldi  r18, 82			      ;Load 82 into r18
  ldi  r19, 43			      ;Load 43 into r19
  ldi  r20, 0			        ;Load 0 into r20
L1:						            ;Loop 1 label
  dec  r20				        ;Subtract 1 from r20
  brne L1				          ;If r20 has a 0, go to L1
  dec  r19				        ;If not, decrement r19
  brne L1				          ;If r19 has a 0, go to L1
  dec  r18				        ;If not, decrement r18
  brne L1			        	  ;If r18 has a 0, go to L1
  ret				          	  ;Return (exit function)
