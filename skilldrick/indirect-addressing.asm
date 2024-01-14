; ---------------------------------------------
; -  DRAW A LINE Accross memory location ------
; ---------------------------------------------
; 
; Uses indirect addressing to draw a straight line
; from memory locaton 0200 to 0500 using indirect 
; addressing

define x_pos    $10
define pos_l    $00       ; position low byte
define pos_h    $01       ; position high byte
define row      $20
define rand_clr $fe       ; random color address

jsr init
jsr loop

; Load values 00 and 02 into memory locations 00 and 01
; these values will equal memory address $0200 when using
; indirect address to memory location $00
; also set Y register to hold value $10
init:
 lda #$00
 sta pos_l
 lda #$02
 sta pos_h
 ldy #x_pos
 clc
 rts

loop:
 lda rand_clr       ; load a random color into a register
 sta (pos_l), y     ; store the white pixel at indirect location 00 with y offset. This points to address 0200
 
 lda pos_l          ; load whats at memory location 00 into a register
 adc #row           ; add $20 (32) to a register. On the emulator one line equals 32 so this will make us go one line down in memory
 bcs handle_newline ; branch to inc_y if carry flag is set, this happens when vale in A exceeds one byte 
 sta pos_l          ; store updated A value into memory address 00
 jmp loop           ; keep looping      

handle_newline:
 lda pos_h
    cmp #$05
    beq reset_y     ; reset y pos to initial value if maxed out
 inc pos_h          ; increment value at memory location 01 by 1. This will tranfer us from 200 to 300 etc without rolling back
 stx pos_l          ; clear whatever is at memory location 00
 clc                ; clear carry flag
 jmp loop           ; return to main SR           
 
reset_y:
 jsr init
 jmp loop