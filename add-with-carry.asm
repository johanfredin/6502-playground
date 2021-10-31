; ADD WITH CARRY
define num1 $14 ; 20
define num2 $f0 ; 240

define low_byte $01
define high_byte $00

clc
lda #num1   ; 
adc #num2   ; 20 + 240 = 255 + 5 
sta low_byte
lda high_byte
adc #$00
sta high_byte
brk
