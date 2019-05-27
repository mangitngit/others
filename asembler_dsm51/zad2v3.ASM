a:
FLAGA EQU 34H
LICZ EQU 30H
POZ EQU 31H
RUCH EQU 32H
SPEED EQU 33H
            LJMP START
            ORG 100H
START:         
           
            LCALL LCD_INIT
            MOV A, #40H ;POCZATEK LINI DOLNEJ WYSWIETLACZA LCD
            LCALL USTAW_KURSOR
            MOV DPTR, #ZACHETA                                               ;"animacja-rekamy"
            MOV A, #16  ;WYPISZE MAKSYMALNIE 16 ZNAKOW
            LCALL PISZ_TEKST
REPET:
            MOV LICZ, #0
            MOV RUCH, #0
            MOV POZ, #0
			MOV FLAGA, #16
			MOV SPEED, #10
            MOV DPTR, #HASLO
PETLA:
            LCALL CZYT_KLAWISZ
            JB ACC.0, KLAW_0
            JB ACC.1, KLAW_1
            JB B.7, KLAW_ENT
            LJMP PETLA
KLAW_0:
            MOV SPEED, #200
            ;MOV A, #40H ;POCZATEK LINI DOLNEJ WYSWIETLACZA LCD
            ;LCALL USTAW_KURSOR
            ;MOV A, #30H ;'0'
            ;LCALL PISZ_ZNAK
            SJMP PETLA
KLAW_1:    
            MOV SPEED, #20
            ;MOV A, #40H
            ;LCALL USTAW_KURSOR
            ;MOV A, #35H ;'1'
            ;LCALL PISZ_ZNAK
            SJMP PETLA
KLAW_ENT:
            ;MOV DPTR, #HASLO
            XRL RUCH, #1 ;ZMIENIA OSTATNI BIT RUCH NA PRZECIWNY
            MOV LICZ, #0
            SJMP PETLA
           
LCD_GOTOWY:
            PUSH PSW
            PUSH ACC
            PUSH DPL
            PUSH DPH
            MOV DPTR,#LCDRC+0FF00H
ODCZEKAJ:
            MOVX A,@DPTR
            JB ACC.7, ODCZEKAJ; Jezeli bit ACC.7 == 1, gotowy
            POP DPH
            POP DPL
            POP ACC
            POP PSW
            RET
 
;PISZ ROZKAZ DO LCD (WE:A)
PISZ_ROZKAZ:
            LCALL LCD_GOTOWY
            PUSH PSW
            PUSH ACC
            PUSH DPL
            PUSH DPH
            MOV DPTR, #LCDWC + 0FF00H ; wpis rozkazów
            MOVX @DPTR, A;kopiuj dane do pamieci zewnetrznej  
            POP DPH
            POP DPL
            POP ACC
            POP PSW
            RET
           
;PISZ ZNAK (WE:A ASCII)
PISZ_ZNAK:
            LCALL LCD_GOTOWY
            PUSH PSW                         ; push - zapisz na stos
            PUSH ACC
            PUSH DPL
            PUSH DPH
            MOV DPTR, #LCDWD+0FF00H
            MOVX @DPTR, A
            POP DPH                           ; pop - czytaj stos
            POP DPL
            POP ACC
            POP PSW
            RET
           
;czytaj znak (wy:a)
CZYT_ZNAK:
            LCALL LCD_GOTOWY
            PUSH PSW
            PUSH DPL
            PUSH DPH
            MOV DPTR, #LCDRD + 0FF00H
            MOVX A,@DPTR
            POP DPH
            POP DPL
            POP PSW
            RET
           
;ustaw kursor (we:A)
USTAW_KURSOR:
            LCALL LCD_GOTOWY
            PUSH PSW
            PUSH ACC
            PUSH DPL
            PUSH DPH
            ORL A,#80H
            MOV DPTR, #LCDWC + 0FF00H
            MOVX @DPTR, A
            POP DPH
            POP DPL
            POP ACC
            POP PSW
            RET
           
;znajdz kursor (wy:A)
ZNAJDZ_KURSOR:
            LCALL LCD_GOTOWY
            PUSH PSW
            PUSH DPL
            PUSH DPH
            MOV DPTR, #LCDRC+0FF00H
            MOVX A,@DPTR
            POP DPH
            POP DPL
            POP PSW
            RET
           
;pisz tekst
;we: DPTR (tekst w ROM), A - ile znakow
;wy:A - ile faktycznie znakow
PISZ_TEKST:
            JZ WYKONANE; skok gdy A=0
            PUSH PSW
            PUSH B
            MOV B, A
            CLR  A  ; zeruj akumulator
            PUSH ACC; a potem go zapamietej ? mamy pamiętać pusty ?
           
POWTARZAJ:
            POP ACC; czyli mamy tu pusty
            PUSH ACC
            MOVC A, @A+DPTR
            JZ TERMINATOR
            LCALL PISZ_ZNAK
            POP ACC
            INC A
            PUSH ACC
            DJNZ B, POWTARZAJ; skok gdy B!=0, skoro B jest nie używane to po co to ?
           
TERMINATOR:
            POP ACC
            POP B
            POP PSW
           
WYKONANE:
			
            RET
           
GAZETA:
            DB 'To jest wiadomosc'
            DB 'Nowe dane'


			
;czytanie klawiatury
;wy A - statust klawiszy 0-7, B -status klawiszy 8-F       
CZYT_KLAWISZ:
            PUSH PSW
            MOV A,R0
            PUSH ACC
            MOV A, R1
            PUSH ACC
			
ZAJETE:
            MOV A, #4
            LCALL DELAY_MS
            LCALL MOJA_AKCJA
            MOV R0, #CSKB0
            MOV R1, #CSKB1
            MOVX A, @R0
            CPL A
            MOV B,A
            MOVX A,@R1
            CPL A ;odwr bity na przeciwne
            ORL A, B
            JNZ ZAJETE
           
WOLNE:
            MOV A, #4
            LCALL DELAY_MS
            LCALL MOJA_AKCJA
            MOV R0, #CSKB0
            MOV R1, #CSKB1
            MOVX A,@R0
            CPL A
            MOV B, A
            MOVX A,@R1
            CPL A
            XCH A, B ;X-CHANGE
            PUSH ACC
            PUSH B
            ORL A, B
            JNZ WYKRYTE
            POP B
            POP ACC
            SJMP WOLNE
           
WYKRYTE:
            MOV A, #4
            LCALL DELAY_MS
            LCALL MOJA_AKCJA
            MOV R0, #CSKB0
            MOV R1, #CSKB1
            MOVX A, @R0
            CPL A
            MOV R0, A
            MOVX A, @R1
            CPL A
            MOV R1, A
            POP B
            POP ACC
            XRL A,R0
            JNZ WOLNE
            MOV A, B; Ja tu nic nie mam
            XRL A, R1
            JNZ WOLNE
            POP ACC
            XCH A,R1; Tu też nic nie mam
            MOV B, A
            POP ACC
            XCH A,R0
            POP PSW
			
			
			
            RET
           
MOJA_AKCJA:
            INC LICZ
            MOV A,LICZ
            MOV B, SPEED ;U NAS MUSI TO BYC ZMIENNA, SLYZY DO STEROWANIA SZYBKOSCIA GAZETY
            DIV AB 
            MOV LICZ, B
            JZ POMIN    ; JEZELI WYNIKIEM DZIELENIA JEST ZERO TO POMIN I NIE RUSZAJ(NIE MINAL CZAS DO RUCHU)
            MOV A,RUCH
            JZ POMIN
			
			
			MOV A, #0FH
            SUBB A, POZ
			INC A
			LCALL USTAW_KURSOR
            MOV A, #32
            LCALL PISZ_ZNAK
           
            ;LCALL USTAW_KURSOR
            ;MOVX A, @DPTR
            ;LCALL PISZ_ZNAK
           
           
            MOV A, #0FH
            SUBB A, POZ
            LCALL USTAW_KURSOR
			
			MOV A, FLAGA
            MOVX A, @DPTR
            LCALL PISZ_ZNAK
           
           
           
            INC POZ     ; PRZESUN WSKAZNIK
			
            ;ANL POZ, #0FH   ; JAKBY MODULO 16
			MOV A, POZ
			MOV B, FLAGA
			DIV AB
			MOV A, B
			JZ HEHE
            MOV A, POZ
           
            ; JAKBY MODULO 16
            ;MOV A, POZ
            ;LCALL USTAW_KURSOR
            ;MOV A, #' '
            ;LCALL PISZ_ZNAK
            RET
HEHE:
	MOV POZ, #0
	DEC FLAGA
	INC DPTR
	MOV A, FLAGA
	JZ JUMP
	RET

RESECIK:
        MOV DPTR, #HASLO
        RET
POMIN:
            RET
JUMP:
	LJMP REPET
 
ZACHETA:
            DB 'Animacja-Reklamy',0        
HASLO:
            DB 'JA-ZAPRASZAM-WAS',0