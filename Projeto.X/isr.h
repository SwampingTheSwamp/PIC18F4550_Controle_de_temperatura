#include <xc.h>

// Rotina de Serviço de Interrupção (ISR) de alta prioridade
void __interrupt(high_priority) ISR_Alta_Prioridade(void);

// Rotina de Serviço de Interrupção (ISR) de baixa prioridade
void __interrupt(low_priority) ISR_Baixa_Prioridade(void);
