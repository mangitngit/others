;STOPER
A:
TIME5FLAG EQU 20H
ALARMFLAG EQU 21H
CZAS EQU 22H

LED EQU P1.7
BUZZ EQU P1.5
MEM EQU 30H

            LJMP START
            ORG 03H	; EXT0 obsługa external 0
            RETI	; zabezpieczenie przed śmieciami
            ORG 0BH	; timer0
            LJMP STOPER
            RETI
            ORG 100H
START:
            LCALL LCD_INIT	; WSZYSTKIE PRZERWANIA PRZY OKAZJI SIE ZERUJA
            MOV TIME5FLAG, #1
            MOV ALARMFLAG, #1
            MOV CZAS, #0
		
            MOV A, #0
            LCALL USTAW_KURSOR	; wypisz RELAX w górnym wierszu LCD
            MOV DPTR, #NRELAX
            LCALL WRITE_TEXT
		
            MOV A, #40H
            LCALL USTAW_KURSOR	; wypisz początkowy klawisz 0 na dolnym wierszu LCD
            MOV A, #0
            LCALL WRITE_HEX	
		
            MOV TMOD, #21H	; ustawienie dla licznika trybu pracy 1
            MOV TH0, #256-180	; 50 ms
            MOV TL0, #0	; Pomiedzy TH0-TL0 (400) impulsami jest około 50 ms
            MOV MEM, #20
            SETB TR0
            SETB ET0
            SETB EA
		
OBROT:
; KL0
            LCALL WAIT_KEY	; zwraca numer klawisza przekonfertowany na od 0-15
		
            CJNE A, #0, KL1	; sprawdzenie czy wcisnieto klawisz 0-9, Esc lub Ent
            MOV A, #40H
            LCALL USTAW_KURSOR	; jeżeli wciśnięto, zeruj czas i wypisz numer przycisku
            MOV A, #0
            LCALL WRITE_HEX

            MOV A, TIME5FLAG	; sprawdzenie czy tryb Timeout 5s
            JZ OBROT
            MOV CZAS, #0	; jeżeli nie to zeruj
            LJMP OBROT
KL1:
            CJNE A, #1, KL2 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #1
            LCALL WRITE_HEX

            MOV A, TIME5FLAG
            JZ OBROT
            MOV CZAS, #0
            LJMP OBROT
KL2:
            CJNE A, #2, KL3 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #2
            LCALL WRITE_HEX

            MOV A, TIME5FLAG
            JZ OBROT
            MOV CZAS, #0
            LJMP OBROT	
KL3:
            CJNE A, #3, KL4 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #3
            LCALL WRITE_HEX

            MOV A, TIME5FLAG
            JZ OBROT
            MOV CZAS, #0
            LJMP OBROT
KL4:
            CJNE A, #4, KL5 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #4
            LCALL WRITE_HEX

            MOV A, TIME5FLAG
            JZ OBROT
            MOV CZAS, #0
            LJMP OBROT
KL5:
            CJNE A, #5, KL6 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #5
            LCALL WRITE_HEX	

            MOV A, TIME5FLAG
            JZ KLRET
            MOV CZAS, #0
            LJMP OBROT	
KL6:
            CJNE A, #6, KL7
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #6
            LCALL WRITE_HEX	

            MOV A, TIME5FLAG
            JZ KLRET
            MOV CZAS, #0
            LJMP OBROT
KL7:
            CJNE A, #7, KL8 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #7
            LCALL WRITE_HEX	

            MOV A, TIME5FLAG
            JZ KLRET
            MOV CZAS, #0
            LJMP OBROT
KL8:
            CJNE A, #8, KL9 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #8
            LCALL WRITE_HEX

            MOV A, TIME5FLAG
            JZ KLRET
            MOV CZAS, #0
            LJMP OBROT
KL9:
            CJNE A, #9, KLESC 
            MOV A, #40H
            LCALL USTAW_KURSOR
            MOV A, #9
            LCALL WRITE_HEX

            MOV A, TIME5FLAG
            JZ KLRET
            MOV CZAS, #0
            LJMP OBROT
KLESC:
            CJNE A, #14, KLENT	
            MOV A, TIME5FLAG
            JZ KLESCFUN	; jeżeli tryb timeout 5s
KLENT:
            CJNE A, #15, KLRET 	
            MOV A, ALARMFLAG
            JZ KLENTFUN	; jeżeli tryb alarm

KLRET:	
            LJMP OBROT
		
KLESCFUN:
            CPL LED	; wyłacz diodę
            MOV TIME5FLAG, #1	; wyczyść flagę trybu timeout 5s
		
            MOV A, #0
            LCALL USTAW_KURSOR	; wypisz RELAX
            MOV DPTR, #NRELAX
            LCALL WRITE_TEXT
		
            MOV CZAS, #0	; zeruj czas
		
            SJMP KLRET
		
KLENTFUN:
            CPL LED	; wyłącz diodę i buzzer
            CPL BUZZ
            MOV ALARMFLAG, #1	; wyczyść flagę trybu alarm
		
            MOV A, #0
            LCALL USTAW_KURSOR	; wypisz RELAX
            MOV DPTR, #NRELAX
            LCALL WRITE_TEXT
		
            MOV CZAS, #0	; zeruj czas
		
            SJMP KLRET
		
STOPER:	; obługa przerwania
            PUSH PSW	; zachowaj PSW
            PUSH ACC	; przechowanie rejestrów na stosie
            PUSH 0	; push aktywnego banku
            MOV TH0, #256-180	; załaduj T0 (50ms)
            DJNZ MEM, POSTOJ	; czy mineła 1 sek
		
            MOV A, #4EH	; ustaw kursor w prawym dolnym rogu do wypisania aktualnego czasu
            LCALL USTAW_KURSOR
		
            MOV A, CZAS	; incrementownanie czasu
            ADD A, #1
            DA A	; poprawka BCD
            MOV CZAS, A
            LCALL WRITE_HEX	; wypisanie czasu
            MOV MEM, #20	; ustaw czas 20*50ms = 1 sek
		
            MOV A, TIME5FLAG
            JZ ALARMFUN	; jeżeli tryb timeout 5s

            MOV A, ALARMFLAG
            JZ POSTOJ; jeżeli tryb alarm
		
            MOV A, CZAS
            CJNE A, #25, POSTOJ	; jeżeli czas wyniósł około 20 sek
		
            MOV TIME5FLAG, #0	; ustaw flage aktywnego trybu timeout 5s
            CPL LED	
            MOV CZAS, #0
		
            MOV A, #0
            LCALL USTAW_KURSOR	; wypisanie TIMEOUT 5s
            MOV DPTR, #NTIMEOUT
            LCALL WRITE_TEXT

POSTOJ:
            POP 0
            POP ACC
            POP PSW
            RETI	; powrót z przerwania

ALARMFUN:
            MOV A, CZAS
            CJNE A, #5, POSTOJ ; jeżeli czas = 5s
		
            CPL BUZZ	; włączenie buzzera
            MOV TIME5FLAG, #1	; ustawienie flag
            MOV ALARMFLAG, #0
		
            MOV A, #0
            LCALL USTAW_KURSOR	; wypisanie ALARM
            MOV DPTR, #NALARM
            LCALL WRITE_TEXT
            
            SJMP POSTOJ



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


NRELAX:
            DB 'RELAX      ',0        
NTIMEOUT:
            DB 'TIMEOUT 5s ',0
NALARM:
            DB 'ALARM      ',0