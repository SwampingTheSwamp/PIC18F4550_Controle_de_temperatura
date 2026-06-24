#include "isr.h"

// --------------------------------------------------------------------
// Interrup��o de alta prioridade
// --------------------------------------------------------------------

// Rotina de Servi�o de Interrup��o (ISR) de alta prioridade
void __interrupt(high_priority) ISR_Alta_Prioridade(void){

    PIR1bits.CCP1IF = 0;	
    LATCbits.LATC2 = !LATCbits.LATC2;
 
            extern signed char menu;
            
    switch (menu){
            case 1:
    
            break;
            case 2:
                   
            break;
            case 3:
             
            break;
            
    }
            INTCONbits.INT0IF = 0;
 
}


// --------------------------------------------------------------------
// Interrup��o de baixa prioridade 
// --------------------------------------------------------------------
// Rotina de Servi�o de Interrup��o (ISR) de baixa prioridade
void __interrupt(low_priority) ISR_Baixa_Prioridade(void){
    extern signed char menu;
        // Ocorr?ncia de INT1
        if (INTCON3bits.INT1IF){
        menu++;
        if (menu == 5)
        menu = 1;
        INTCON3bits.INT1IF = 0;
        }
        // Ocorr?ncia de INT2
        else if (INTCON3bits.INT2F){
        menu--;
        if (menu == 0)
            menu = 3;
            INTCON3bits.INT2IF = 0;
        }
   
}
