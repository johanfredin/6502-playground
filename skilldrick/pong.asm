define p1_l $01
define p1_h $00
define p1_top $02
define p1_bottom $03

define top_bound    $02
define bottom_bound $e5

define keypressed      $ff 
define p1_key_up       $77
define p1_key_down     $73

define p_height $06

define clr_white  $01
define clr_black  $00

define row #$20

jsr init
jsr main

init:
    ; init player1
    ldx #$00
    ldy #$00
    init_p1:
        lda #$02
        stx p1_l, y
        iny
        cpy #p_height
        bne init_p1 
        
