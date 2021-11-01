; ADD 2 8-bit numbers and store result in a 16-bit nr ---------------------

define num1 $14 ; 20
define num2 $f0 ; 240

define low_byte $01
define high_byte $00

clc
lda #num1   	  ; load num1 into A 
adc #num2   	  ; add num2 (20 + 240 = 255 + 5) 
sta low_byte    ; store a in low byte
lda high_byte   ; load high byte addr into a resetting a to 0
adc #$00   	    ; add the remainder from carry 
sta high_byte   ; store in high byte
		            ; hight byte should now be 01
		            ; low byte should now be 04
		            ; $01 + $04 = $0104 = 260 
brk		

; ============================================================

; example code of program that branches on
; carry clear (bcc)

lda #$FF
ldx #$00
inc:
  sta $0201, x
  adc #$05	; add 5 resulting in carry
  bcc res	; 2nd iteration will clear carry
  inx
  jmp inc

res:
  ; $0200 should hold value 0a (10). 
  ; first carry resulted in A rolling over to 4
  ; with carry flag set
  ; next adc added 5 + 1 to a register -> 10
  sta $0200
  brk
  
