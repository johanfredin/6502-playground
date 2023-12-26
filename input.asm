define keypressed   $ff 
define key_up       $77
define key_down     $73
define key_left     $61
define key_right    $64

define white_pixel $01
define blank $0
define top_grid $200
define upper_mid_grid $300
define lower_mid_grid $400
define bottom_grid $500

; Display pixel 
ldx #white_pixel
ldy #$0

main:
    stx top_grid, y
    lda keypressed
    cmp #key_left
    beq move_left
    cmp #key_right
    beq move_right
    jmp main

move_right:
    ; clear current pos
    ldx #blank
    ; increment pos by 1
    iny
    ; Load white pixel into x
    ldx #white_pixel
    ; Display white pixel at new position
    stx top_grid, y 
    ; Return to main loop
    jmp main

move_left:
    jmp main


;Memory location $fe contains a new random byte on every instruction.
;Memory location $ff contains the ascii code of the last key pressed.
;Memory locations $200 to $5ff map to the screen pixels. Different values will draw different colour pixels. The colours are:
;
;    $0: Black
;    $1: White
;    $2: Red
;    $3: Cyan
;    $4: Purple
;    $5: Green
;    $6: Blue
;    $7: Yellow
;    $8: Orange
;    $9: Brown
;    $a: Light red
;    $b: Dark grey
;    $c: Grey
;    $d: Light green
;    $e: Light blue
;    $f: Light grey
