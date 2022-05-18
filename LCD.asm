
	list		p=16f877A	
	#include	<p16f877A.inc>	
	
    __CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF



	
SAYAC1	EQU 0X20
SAYAC2	EQU 0X21
LCD_DATA    EQU	0X22
SAYAC	EQU 0X23
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F					







    ORG     0x000             	

    nop			  			  	
    goto    BASLA              

	

    ORG     0x004             	

    movwf   w_temp            
    movf	STATUS,w          	
    movwf	status_temp       	
    movf	PCLATH,w	  		
    movwf	pclath_temp	  		
    
   
    
CIKIS
    movf	pclath_temp,w	  	
    movwf	PCLATH		  		
    movf    status_temp,w     	
    movwf	STATUS            	
    swapf   w_temp,f
    swapf   w_temp,w          	
	retfie      
	
;****************************************************************************	

	
;*****************************************************************************	

;*****************************************************************************

;******************************************************************************

BASLA
	BANKSEL	TRISB
	CLRF	TRISB
	BANKSEL	PORTB
	CLRF	PORTB
	CALL	TEMIZLE
	CALL	KARAKTERLER
	
VERI_YAZ
	MOVWF	LCD_DATA
	SWAPF	LCD_DATA,W
	CALL	VERI_GONDER
	MOVF	LCD_DATA,W
	CALL	VERI_GONDER
	RETURN
VERI_GONDER
	ANDLW	0X0F
	MOVWF	PORTB
	BANKSEL	PORTB
	BSF PORTB,4
	BSF PORTB,5
	CALL	GECIKME
	BCF	PORTB,5
	RETURN
KOMUT_YAZ
	MOVWF	LCD_DATA
	SWAPF	LCD_DATA,W
	CALL	KOMUT_GONDER
	MOVF	LCD_DATA,W
	CALL	KOMUT_GONDER
	RETURN
KOMUT_GONDER
	ANDLW	0X0F
	MOVWF	PORTB
	BANKSEL	PORTB
	BSF PORTB,5
	CALL	GECIKME
	BCF PORTB,5
	RETURN
GECIKME
	MOVLW	0XA0
	MOVWF	SAYAC1
	
GECIKME1
	MOVLW	0XA0
	MOVWF	SAYAC2
GECIKME2
	DECFSZ	SAYAC2,1
	GOTO	GECIKME2
	DECFSZ	SAYAC1,1
	GOTO	GECIKME1
	RETURN
	
TEMIZLE
	MOVLW	0X02
	CALL	KOMUT_YAZ
	MOVLW	0X0C
	CALL	KOMUT_YAZ
	MOVLW	0X28
	CALL	KOMUT_YAZ
	RETURN
SATIR2
	MOVLW	0XC0
	CALL	KOMUT_YAZ
	RETURN
KARAKTERLER
	MOVLW	'A'
	CALL	VERI_YAZ
	MOVLW	'L'
	CALL	VERI_YAZ
	MOVLW	'I'
	CALL	VERI_YAZ
	RETURN
END
	
	
	
	
