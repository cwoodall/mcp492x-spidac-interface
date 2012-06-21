#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <math.h>
#include "HRL_SPI.h"
#include "HRL_MCP492x.h"

void setup() {
  // Initiate SPI in Mode 0 with MSB first, NO interrupts and a clock of F_CPU/2 
  setupSPI(SPI_MODE_0, SPI_MSB, SPI_NO_INTERRUPT, SPI_MASTER_CLK2);
  SETUP_DAC;
  _delay_us(100);  
}


int config = 0x30;
int data = 0;
void loop() {
  writeMCP492x((sin(M_PI*data/(0xFFF))*0x800) + 0x800, 0x30);
  delayMicroseconds(10);
  if (data < (0xFFF*2))
    data += 0x800;
  else
    data = 0;
  delayMicroseconds(10);
}

