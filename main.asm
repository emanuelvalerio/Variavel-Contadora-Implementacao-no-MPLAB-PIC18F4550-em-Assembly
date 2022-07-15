
; EMANUEL VALERIO PEREIRA - MATRICULA 471055
    
    #include "p18f4550.inc"
    
    CONFIG FOSC = XT_XT
    CONFIG WDT = OFF
    CONFIG LVP = OFF
    
    VARIAVEIS UDATA_ACS 0
        CONT1 RES 1 
	CONT2 RES 1
	KEY1 EQU .0 ; PINO RC0
	KEY2 EQU .1 ; PINO RC1
        
 
 RES_VECT CODE 0X0000
    GOTO START
 MAIN_PROG CODE
 
START 
    CLRF CONT1     ; Zerando a variavel CONT1
    CLRF CONT2     ; Zerando a variavel CONT2
    CLRF TRISD     ; TORNANDO A PORTD COMO SAIDA
    BSF TRISC,KEY1 ; condigurando s chave1 como porta de entrada
    BSF TRISC,KEY2 ; condigurando s chave1 como porta de entrada
    CLRF PORTD    ; Zera PORTD
    
; ROTINA
LOOP
    
    BTFSC PORTC,KEY1 ; VERIFICA SE KEY1 ESTA PRESSIONADA, E PULA SE NAO ESTIVER
    BRA LOOPA   
    BRA LOOPB
    LOOPA            ; CASO EM QUE KEY1 É PRESSIONADA
    BTFSC PORTC,KEY2 ; VERIFICA SE KEY2 ESTA PRESSIONADA, E PULA SE NAO ESTIVER
    BRA LOOPC 
    BRA LOOPD 
    LOOPB           ; CASO EM QUE KEY1 NÃO É PRESSIONADA
    BRA LOOPE 
    BRA LOOPF
    LOOPC           ; CASO EM QUE AS DUAS CHAVES ESTAO PRESSIONADAS
    GOTO LOOP      
    LOOPD           ; CASO EM QUE SOMENTE A KEY1 ESTÁ PRESSIONADA
    CALL INCREMENT
    GOTO LOOP
    LOOPE           ; CASO EM QUE SOMENTE A KEY2 ESTÁ PRESSIONADA
    CALL DECREMENT
    GOTO LOOP
    LOOPF           ; CASO EM QUE NENHUMA CHAVE É PRESSIONADA
GOTO LOOP

; SUB-ROTINAS	
    INCREMENT 
	CALL DELAY200MS 
	CALL DELAY200MS
	CALL DELAY200MS
	CALL DELAY200MS
	CALL DELAY200MS
        BTFSC PORTC,KEY1 ;CASO BOTAO NAO ESTEJA PRESSIONADO PULE PARA A PROXIMA
	INCF PORTD       ;Incrementa PORTD 
    RETURN               ;Retorna para a ultima posição antes da função
    
    DECREMENT 
	CALL DELAY200MS 
	CALL DELAY200MS 
	CALL DELAY200MS 
	CALL DELAY200MS 
	CALL DELAY200MS 
	BTFSC PORTC,KEY2  ;CASO BOTAO NAO ESTEJA PRESSIONADO PULE PARA A PROXIMA
        DECF PORTD        ;DECREMENTA PORTD
    RETURN
    
 
    DELAY200MS
 MOVLW .200		;Coloca o valor 200 no registrador
 MOVWF CONT2		;Passa o valor 200 do registrador para variável CONT2

DELAYM
 CALL DELAY200U		;Chama a função de delay de 200us
 CALL DELAY200U		;Chama a função de delay de 200us
 CALL DELAY200U		;Chama a função de delay de 200us
 CALL DELAY200U		;Chama a função de delay de 200us
 CALL DELAY200U		;Chama a função de delay de 200us
 DECFSZ CONT2		;Decrementa CONT2 e pula caso seja 0
 BRA DELAYM		;Volta para a Subrotina DELAYM
 RETURN			;Retorna para a última posição antes da função

DELAY200U		
 MOVLW .48		;Coloca o valor 48 no registrador
 MOVWF CONT1		;Passa o valor 48 do registrador para variável CONT1

DELAY
 NOP			;Não faz nada por 1 ciclo de clock
 DECFSZ CONT1		;Decrementa CONT1 e pula caso seja 0
 BRA DELAY		;Volta para a Subrotina DELAY
 RETURN			;Retorna para a ultima posição antes da função
 
END