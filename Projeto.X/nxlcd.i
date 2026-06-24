#line 1 "nxlcd.c"
#line 1 "nxlcd.c"

#line 7 "nxlcd.c"
 


#line 1 "./nxlcd.h"

#line 3 "./nxlcd.h"



#line 22 "./nxlcd.h"
 

 
#line 25 "./nxlcd.h"
 

#line 28 "./nxlcd.h"
#line 29 "./nxlcd.h"


#line 32 "./nxlcd.h"
 
 


#line 37 "./nxlcd.h"
 
#line 39 "./nxlcd.h"

 
#line 42 "./nxlcd.h"
#line 43 "./nxlcd.h"


#line 46 "./nxlcd.h"
 
#line 48 "./nxlcd.h"
#line 49 "./nxlcd.h"

#line 51 "./nxlcd.h"
#line 52 "./nxlcd.h"

#line 54 "./nxlcd.h"
#line 55 "./nxlcd.h"

 
#line 58 "./nxlcd.h"
#line 59 "./nxlcd.h"
#line 60 "./nxlcd.h"
#line 61 "./nxlcd.h"
#line 62 "./nxlcd.h"
#line 63 "./nxlcd.h"

 
#line 66 "./nxlcd.h"
#line 67 "./nxlcd.h"
#line 68 "./nxlcd.h"
#line 69 "./nxlcd.h"

 
#line 72 "./nxlcd.h"
#line 73 "./nxlcd.h"
#line 74 "./nxlcd.h"
#line 75 "./nxlcd.h"
#line 76 "./nxlcd.h"

#line 80 "./nxlcd.h"
#line 81 "./nxlcd.h"
#line 82 "./nxlcd.h"


#line 87 "./nxlcd.h"
#line 88 "./nxlcd.h"
#line 89 "./nxlcd.h"
#line 90 "./nxlcd.h"

 
void DelayFor18TCY(void);
void DelayPORXLCD(void);
void DelayXLCD(void);


#line 98 "./nxlcd.h"
 
void OpenXLCD(auto  unsigned char);


#line 103 "./nxlcd.h"
 
void SetCGRamAddr(auto  unsigned char);


#line 108 "./nxlcd.h"
 
void SetDDRamAddr(auto  unsigned char);


#line 113 "./nxlcd.h"
 
unsigned char BusyXLCD(void);


#line 118 "./nxlcd.h"
 
unsigned char ReadAddrXLCD(void);


#line 123 "./nxlcd.h"
 
char ReadDataXLCD(void);


#line 128 "./nxlcd.h"
 
void WriteCmdXLCD(auto  unsigned char);


#line 133 "./nxlcd.h"
 
void WriteDataXLCD(auto  char);


#line 138 "./nxlcd.h"
 
#line 140 "./nxlcd.h"


#line 143 "./nxlcd.h"
 
void putsXLCD(auto  char *);


#line 148 "./nxlcd.h"
 
void putrsXLCD(const char *);

#line 152 "./nxlcd.h"
#line 10 "nxlcd.c"


void DelayFor18TCY( void )         
{
    __delay_us(20);                
}

void DelayPORXLCD (void)           
{
    __delay_ms(15);                
}

void DelayXLCD (void)              
{
    __delay_ms(5);                 
}


#line 40 "nxlcd.c"
 
void OpenXLCD(unsigned char lcdtype)
{
        
        
#line 49 "nxlcd.c"
                            
        PORTD  &= 0x0f;
        TRISD  &= 0x0F;
#line 53 "nxlcd.c"
#line 56 "nxlcd.c"
#line 57 "nxlcd.c"
        TRISEbits.TRISE2  = 0;                    
        TRISEbits.TRISE0  = 0;
        TRISEbits.TRISE1  = 0;
        LATEbits.LATE2  = 0;                     
        LATEbits.LATE0  = 0;                     
        LATEbits.LATE1  = 0;                      

        
        DelayPORXLCD();
 
		 WriteCmdXLCD(0x30);
			DelayXLCD();
			DelayXLCD();
		 WriteCmdXLCD(0x30);
			DelayXLCD();
			DelayXLCD();
		 WriteCmdXLCD(0x32);
		while( BusyXLCD() );



        
        while(BusyXLCD());              
        WriteCmdXLCD(lcdtype);          

        
        while(BusyXLCD());              
        WriteCmdXLCD(0b00001011 &0b00001101 &0b00001110 );        
        while(BusyXLCD());              
        WriteCmdXLCD(0b00001111 &0b00001111 &0b00001111 );           

        
        while(BusyXLCD());              
        WriteCmdXLCD(0x01);             

        
        while(BusyXLCD());              
        WriteCmdXLCD(0b00000100 );   

        
        while(BusyXLCD());              
        SetDDRamAddr(0x80);                

        return;
}


#line 112 "nxlcd.c"
 
void SetCGRamAddr(unsigned char CGaddr)
{
#line 127 "nxlcd.c"
                                    
        TRISD  &= 0x0f;                 
        PORTD  &= 0x0f;                      
        PORTD  |= ((CGaddr | 0b01000000) & 0xf0);
#line 132 "nxlcd.c"
#line 136 "nxlcd.c"
        LATEbits.LATE2  = 0;                             
        LATEbits.LATE0  = 0;
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                              
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                                    
        PORTD  &= 0x0f;                      
        PORTD  |= ((CGaddr<<4)&0xf0);
#line 146 "nxlcd.c"
#line 149 "nxlcd.c"
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                              
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                                    
        TRISD  |= 0xf0;                 
#line 156 "nxlcd.c"
#line 158 "nxlcd.c"
#line 159 "nxlcd.c"
        return;
}


#line 170 "nxlcd.c"
 
void SetDDRamAddr(unsigned char DDaddr)
{
#line 185 "nxlcd.c"
                                    
        TRISD  &= 0x0f;                 
        PORTD  &= 0x0f;                      
        PORTD  |= ((DDaddr | 0b10000000) & 0xf0);
#line 190 "nxlcd.c"
#line 194 "nxlcd.c"
        LATEbits.LATE2  = 0;                             
        LATEbits.LATE0  = 0;
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                              
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                                    
        PORTD  &= 0x0f;                      
        PORTD  |= ((DDaddr<<4)&0xf0);
#line 204 "nxlcd.c"
#line 207 "nxlcd.c"
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                              
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                                    
        TRISD  |= 0xf0;                 
#line 214 "nxlcd.c"
#line 216 "nxlcd.c"
#line 217 "nxlcd.c"
        return;
}


#line 226 "nxlcd.c"
 
unsigned char BusyXLCD(void)
{
        LATEbits.LATE2  = 1;                     
        LATEbits.LATE0  = 0;
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
#line 248 "nxlcd.c"
                            
        if(PORTD &0x80)
#line 251 "nxlcd.c"
#line 253 "nxlcd.c"
        {
                LATEbits.LATE1  = 0;              
                DelayFor18TCY();
                LATEbits.LATE1  = 1;              
                DelayFor18TCY();
                LATEbits.LATE1  = 0;
                LATEbits.LATE2  = 0;             
                return 1;               
        }
        else                            
        {
                LATEbits.LATE1  = 0;              
                DelayFor18TCY();
                LATEbits.LATE1  = 1;              
                DelayFor18TCY();
                LATEbits.LATE1  = 0;
                LATEbits.LATE2  = 0;             
                return 0;               
        }
#line 273 "nxlcd.c"
}


#line 286 "nxlcd.c"
 
unsigned char ReadAddrXLCD(void)
{
        char data;                      

#line 301 "nxlcd.c"
        LATEbits.LATE2  = 1;                     
        LATEbits.LATE0  = 0;
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
                            
        data = PORTD &0xf0;          
#line 309 "nxlcd.c"
#line 311 "nxlcd.c"
        LATEbits.LATE1  = 0;                      
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
                            
        data |= (PORTD >>4)&0x0f;    
#line 318 "nxlcd.c"
#line 320 "nxlcd.c"
        LATEbits.LATE1  = 0;
        LATEbits.LATE2  = 0;                     
#line 323 "nxlcd.c"
        return (data&0x7f);             
}


#line 337 "nxlcd.c"
 
char ReadDataXLCD(void)
{
        char data;

#line 353 "nxlcd.c"
        LATEbits.LATE2  = 1;
        LATEbits.LATE0  = 1;
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
                            
        data = PORTD &0xf0;          
#line 361 "nxlcd.c"
#line 363 "nxlcd.c"
        LATEbits.LATE1  = 0;                      
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
                            
        data |= (PORTD >>4)&0x0f;    
#line 370 "nxlcd.c"
#line 372 "nxlcd.c"
        LATEbits.LATE1  = 0;                                      
        LATEbits.LATE0  = 0;                     
        LATEbits.LATE2  = 0;
#line 376 "nxlcd.c"
        return(data);                   
}


#line 387 "nxlcd.c"
 
void WriteCmdXLCD(unsigned char cmd)
{
#line 402 "nxlcd.c"
                            
        TRISD  &= 0x0f;
        PORTD  &= 0x0f;
        PORTD  |= cmd&0xf0;
#line 407 "nxlcd.c"
#line 411 "nxlcd.c"
        LATEbits.LATE2  = 0;                     
        LATEbits.LATE0  = 0;
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                            
        PORTD  &= 0x0f;
        PORTD  |= (cmd<<4)&0xf0;
#line 421 "nxlcd.c"
#line 424 "nxlcd.c"
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                            
        TRISD  |= 0xf0;
#line 431 "nxlcd.c"
#line 433 "nxlcd.c"
#line 434 "nxlcd.c"
        return;
}


#line 448 "nxlcd.c"
 
void WriteDataXLCD(char data)
{
#line 463 "nxlcd.c"
                            
        TRISD  &= 0x0f;
        PORTD  &= 0x0f;
        PORTD  |= data&0xf0;
#line 468 "nxlcd.c"
#line 472 "nxlcd.c"
        LATEbits.LATE0  = 1;                     
        LATEbits.LATE2  = 0;
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                            
        PORTD  &= 0x0f;
        PORTD  |= ((data<<4)&0xf0);
#line 482 "nxlcd.c"
#line 485 "nxlcd.c"
        DelayFor18TCY();
        LATEbits.LATE1  = 1;                      
        DelayFor18TCY();
        LATEbits.LATE1  = 0;
                            
        TRISD  |= 0xf0;
#line 492 "nxlcd.c"
#line 494 "nxlcd.c"
#line 495 "nxlcd.c"
        return;
}


#line 509 "nxlcd.c"
 
void putsXLCD(char *buffer)
{
        while(*buffer)                  
        {
                while(BusyXLCD());      
                WriteDataXLCD(*buffer); 
                buffer++;               
        }
        return;
}


#line 532 "nxlcd.c"
 
void putrsXLCD(const char *buffer)
{
        while(*buffer)                  
        {
                while(BusyXLCD());      
                WriteDataXLCD(*buffer); 
                buffer++;               
        }
        return;
}
