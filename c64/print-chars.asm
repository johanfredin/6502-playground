// Constants
.var screen_mem = $0400
.var bg_color_addr = $d020
.var border_color_addr = $d021
.var text_color_addr = $0286

// Kernel routines
.var chrin = $ffe4
.var cls = $e544

.var stop_key = $103    // esc

// Colors
.var clr_black = $0
.var clr_white = $1
.var clr_red = $2

BasicUpstart2(start)

// Start address of program
*=$2000

start:
    lda #clr_black
    sta bg_color_addr
    lda #clr_red
    sta border_color_addr
    lda #clr_white
    sta text_color_addr
    jsr cls
    ldx #$00
intro_loop:
    lda start_message, x
    beq get_input
    sta screen_mem, x
    inx
    jmp intro_loop
get_input:
    jsr chrin
    cmp #$00
    beq get_input
    cmp #stop_key
    beq quit

    // Convert ascii to screen code value
    sec
    sbc #$40
    ldx #$00
print_char:
    sta screen_mem, x
    sta screen_mem + 255, x
    sta screen_mem + 510, x
    sta screen_mem + (999 - 255), x // 999 - 255 as start point because screen is 0-999 and we dont want to overlap into memory that does not belong to screen
    inx
    bne print_char
    jmp get_input
quit:
    jsr cls
    rts
start_message:
    .text "press a key or esc to quit"
    .byte 0