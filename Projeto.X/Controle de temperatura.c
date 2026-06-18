#include <xc.h>
#include "nxlcd.h"
#include "isr.h"
#define _XTAL_FREQ 20000000



#pragma config FOSC = HS // Fosc = 20MHz -> Tcy = 200ns
#pragma config CPUDIV = OSC1_PLL2
#pragma config WDT    = ON
#pragma config WDTPS  = 512
#pragma config PBADEN = OFF
#pragma config LVP    = OFF

signed char menu=1;

void main() {
        char atraso;
        ADCON1 = 0x0F;
        TRISBbits.TRISB0 = 1;
        TRISBbits.TRISB1 = 1;
        TRISBbits.TRISB2 = 1;
        TRISAbits.TRISA5 = 0;
        TRISAbits.TRISA3 = 0;
        TRISCbits.TRISC1 = 0;
        TRISCbits.TRISC2 = 0;
        INTCON2bits.nRBPU = 0;



        TRISE = 0x00;
        TRISD = 0x00;
        TRISCbits.TRISC2 = 0;
        ADCON1 = 0x0F; 

        // Configuração do timer 1 com prescaler 8
        T1CON = 0b10110101;
        TMR1H = 0;
        TMR1L = 0;
        // Seleção de Timer1
        T3CONbits.T3CCP1 = 0;
        T3CONbits.T3CCP2 = 0;

        // Configuração do CCP -> modo comparação
        CCP1CON = 0b00001011;	 // Special event trigger
        PIR1bits.CCP1IF = 0;	 // zera flag da interrupção CCP1
        PIE1bits.CCP1IE = 1;	 // habilita interrupção do CCP1
        IPR1bits.CCP1IP = 1;
        //CCPR1 = 3125 = 0x0C35
        CCPR1H = 0x0C;
        CCPR1L = 0x35;

        RCONbits.IPEN = 0;		// desabilita prioridade
        INTCONbits.PEIE = 1;	// habilita interrupções de periféricos	
        INTCONbits.GIE = 1;		// habilita interrupções global
    
        //Configura??o das interrup??es
        RCONbits.IPEN = 1; // habilita prioridade

        // Configura??o de INT0
        INTCONbits.INT0IE = 1; // habilita INT0
        INTCONbits.INT0IF = 0; // zera flag da INT0
        // INT0 ? sempre de alta prioridade
        // Configura??o de INT1
        INTCON3bits.INT1IE = 1; // habilita INT1
        INTCON3bits.INT1IF = 0; // zera flag da INT1
        INTCON3bits.INT1IP = 0; // interrup??o INT1 ? de baixa prioridade

            // Configura??o de INT2
        INTCON3bits.INT2IE = 1; // habilita INT2
        INTCON3bits.INT2IF = 0; // zera flag da INT2
        INTCON3bits.INT2IP = 0; // interrup??o INT2 ? de baixa prioridade

        INTCONbits.GIEL = 1; // habilita interrup??es de baixa prioridade
        INTCONbits.GIEH = 1; // habilita interrup??es de alta prioridade
   

        OpenXLCD( FOUR_BIT & LINES_5X7 );
        WriteCmdXLCD(0x01);
        __delay_ms(16);

        WriteCmdXLCD(0x80);
        putrsXLCD("Opcoes do Menu:");
        WriteCmdXLCD(0x0C);

while (1) {
        CLRWDT();
        PORTAbits.RA5 = 0;
        PORTAbits.RA3 = 1;
        WriteCmdXLCD(0xC0);
        switch (menu){
            case 1:
            putrsXLCD("Controle Aberto ");
            break;

            case 2:
            putrsXLCD("Controle Fechado");
            break;

            case 3:
            putrsXLCD("Liga Ventilador ");
            break;
            
        }
       for (atraso=0; atraso<50; atraso++)
            __delay_ms(10);
    }
}