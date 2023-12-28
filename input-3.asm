define keypressed   $ff 
define key_up       $77
define key_down     $73
define key_left     $61
define key_right    $64
define white_pixel  $01
define blank        $00
define pos_l        $00 
define pos_h        $01 

define clr_cyan     $03
define clr_purple   $04
define clr_green    $05
define clr_blue     $06

jsr init 
jsr main

init:
    lda #$00
    sta pos_l
    lda #$02
    sta pos_h
    ldy #$10

    lda #clr_cyan
    sta $200
    lda #clr_purple
    sta $300
    lda #clr_green
    sta $400
    lda #clr_blue
    sta $500

    rts

main:
    lda #white_pixel 
    sta (pos_l), y   
    
    ldx keypressed
    cpx #key_left
        beq move_left
    cpx #key_right
        beq move_right
    cpx #key_down
        beq move_down
    cpx #key_up
        beq move_up
    jmp main


move_left:
    lda #blank
    sta (pos_l), y 
    dey
    ldx #$0 
    stx keypressed
    jmp main

move_right:
    lda #blank
    sta (pos_l), y 
    iny
    ldx #$0 
    stx keypressed
    jmp main

move_down:
    lda #blank
    sta (pos_l), y
    lda pos_l
    adc #$1f
    	bcs next_buffer
    sta pos_l
    ldx #$0 
    stx keypressed
    jmp main


move_up:
    lda #blank
    sta (pos_l), y
    lda pos_l
    cmp #$00
    beq prev_buffer
    sbc #$20
    sta pos_l
    ldx #$0 
    stx keypressed
    jmp main

next_buffer:
    inc pos_h
    ldx #$0 
    stx keypressed
    stx pos_l
    clc
    jmp main

prev_buffer:
    dec pos_h
    ldx #$0 
    stx keypressed
    
    lda #$e0
    sta pos_l
    clc
    jmp main    
