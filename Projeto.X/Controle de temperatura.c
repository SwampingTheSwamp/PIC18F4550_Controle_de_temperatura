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

unsigned char h = 12, m = 0;

void escreve2dig(unsigned char v);

void main() {
    char atraso;

    // --- Configuracao de I/O e A/D ---
    ADCON1 = 0x0F;              // todos os pinos como digitais (ajustar
                                 // depois ao habilitar os canais do LM35
                                 // e do potenciometro)
    TRISBbits.TRISB0 = 1;       // INT0
    TRISBbits.TRISB1 = 1;       // INT1
    TRISBbits.TRISB2 = 1;       // INT2
    TRISAbits.TRISA5 = 0;
    TRISAbits.TRISA3 = 0;
    TRISCbits.TRISC1 = 0;
    TRISCbits.TRISC2 = 0;
    INTCON2bits.nRBPU = 0;
    TRISE = 0x00;
    TRISD = 0x00;

    // --- Configuração PWM CCP1 usando Timer2 ---

    // Timer2 ligado
    // Prescaler 16
    T2CON = 0b00000111;

    // Período do PWM
    // Fpwm = Fosc / (4 * (PR2+1) * prescaler)
    // PR2 = 249 -> aproximadamente 5kHz
    PR2 = 249;


    // CCP1 em modo PWM
    CCP1CON = 0b00001100;


    // Duty cycle inicial 0%
    CCPR1L = 0;
    CCP1CONbits.DC1B0 = 0;
    CCP1CONbits.DC1B1 = 0;

    // --- Configuracao de prioridade e interrupcoes globais ---
    RCONbits.IPEN = 1;          // habilita niveis de prioridade
    INTCONbits.PEIE = 1;        // habilita interrupcoes de perifericos

    // INT0 (sempre alta prioridade por hardware)
    INTCONbits.INT0IE = 1;
    INTCONbits.INT0IF = 0;

    // INT1 (baixa prioridade)
    INTCON3bits.INT1IE = 1;
    INTCON3bits.INT1IF = 0;
    INTCON3bits.INT1IP = 0;

    // INT2 (baixa prioridade)
    INTCON3bits.INT2IE = 1;
    INTCON3bits.INT2IF = 0;
    INTCON3bits.INT2IP = 0;

    INTCONbits.GIEL = 1;        // habilita interrupcoes de baixa prioridade
    INTCONbits.GIEH = 1;        // habilita interrupcoes de alta prioridade

    // --- Inicializacao do LCD ---
    OpenXLCD( FOUR_BIT & LINES_5X7 );
    WriteCmdXLCD(0x01);
    __delay_ms(16);
    WriteCmdXLCD(0x80);
    putrsXLCD("Menu: ");
    escreve2dig(h);
    putcXLCD(':');
    escreve2dig(m);

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

        // Consome a confirmacao feita via INT0 dentro da ISR.
        // Aqui e o lugar certo para, no futuro, chamar as funcoes
        // que de fato iniciam cada modo (malha aberta / fechada / ventilador).
        if (menu_confirmado != 0){
            switch (menu_confirmado){
                case 1:
                    // TODO: iniciar controle em malha aberta (PWM fixo 75%)
                    break;
                case 2:
                    // TODO: iniciar controle em malha fechada (PI)
                    break;
                case 3:
                    // TODO: iniciar acionamento do ventilador (40% / 5s)
                    break;
            }
            menu_confirmado = 0;
        }

        for (atraso = 0; atraso < 50; atraso++)
            __delay_ms(10);
    }
}

void escreve2dig(unsigned char v) {
    putcXLCD((v / 10) + '0');
    putcXLCD((v % 10) + '0');
}