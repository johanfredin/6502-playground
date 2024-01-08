/*
    -----------------------------
    -       WRITE COOL CHARS    -
    -----------------------------
    
    Screen Memory Address: 
    ----------------------
    The screen memory address for the Commodore 64 starts at memory location 1024 (or hexadecimal $0400). 
    This memory location holds the information for what is displayed on the screen. 
    The screen memory is a total of 1000 bytes, covering the screen area of 40 columns by 25 rows. 
    Each character on the screen corresponds to a single byte in this memory area, which determines the character and 
    color displayed at that position.

    Screen Memory Length: 
    ---------------------
    The screen memory on the Commodore 64 is 1000 bytes long ($0400 to $07E7 in hexadecimal), 
    representing the entire visible screen area.

    High RAM ($C000 - $FFFF): This area is generally available for user programs
*/



*=$2000                 // start location of our program        
BasicUpstart2(start)    // Makes vice call our program at startup

.var chrin_addr = $ffe4         // address of c64 subroutine that retrieves the asci value of last key pressed and stores in A  
.var screen_start_addr = $0400  // start address of screen
.var screen_l = $07e7           // Lenght of screen addr (1000)
.var n_cols = 40
.var n_rows = 25
.var current_line = $C000

start:
charloop:
    jsr chrin_addr
    cmp #$00
    beq charloop
    sec
    sbc #$40

    // Iterate the rows and cols to print a character on each memory address byte
    ldx #$00
    next_line:
        sta screen_start_addr, x
        sta screen_start_addr + $ff, x
        sta screen_start_addr + $1fe, x
        sta screen_start_addr + $2fd, x
        inx
        bne next_line
    rts
