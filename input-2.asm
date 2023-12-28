    define keypressed   $ff 
    define key_up       $77
    define key_down     $73
    define key_left     $61
    define key_right    $64

    define white_pixel  $01
    define blank        $00

    define pos_l        $00       ; position low byte
    define pos_h        $01       ; position high byte


    jsr init 
    jsr main

    ; Load values 00 and 02 into memory locations 00 and 01
    ; these values will equal memory address $0200 when using
    ; indirect address to memory location $00
    ; also set Y register to hold value $10
    init:
        lda #$00
        sta pos_l
        lda #$02
        sta pos_h
        ldy #$10
        rts

    main:
        ; display
        lda #white_pixel    ; load a random color into a register
        sta (pos_l), y     ; store the white pixel at indirect location 00 with y offset. This points to address 0200
        
        ; check input
        ldx keypressed
        cpx #key_left
            beq move_left
        cpx #key_right
            beq move_right
        jmp main

    move_left:
        ; clear current pos
        lda #blank
        sta (pos_l), y 
        dey
        ; clear last key pressed
        ldx #$0 
        stx keypressed
        rts

    move_right:
        ; clear current pos
        lda #blank
        sta (pos_l), y 
        iny
        ; clear last key pressed
        ldx #$0 
        stx keypressed
        rts

    move_down:
        adc #$20
        bcs handle_newline_down

    move_up:
        sbc #$20
        bcs handle_newline_up

    handle_newline_up:
        dec pos_h          ; decrement value at memory location 01 by 1. This will tranfer us from 300 to 300 etc without rolling back
        ldx #$00
        stx pos_l          ; clear whatever is at memory location 00
        clc                ; clear carry flag
        jmp main

    handle_newline_down:
        inc pos_h          ; increment value at memory location 01 by 1. This will tranfer us from 200 to 300 etc without rolling back
        ldx #$00
        stx pos_l          ; clear whatever is at memory location 00
        clc                ; clear carry flag
        jmp main

    clear_display:
           
        
        rts
        
    display:
        
        rts