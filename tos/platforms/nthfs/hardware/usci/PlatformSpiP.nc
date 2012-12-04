#include <stdio.h>
#include <stdint.h>

module PlatformSpiP {
  provides interface Init;
  uses {
    interface Resource;
  }
}

implementation {

  command error_t Init.init() {
	  /*
msp430_usci_spi_default_config.ctlw0 = ((UCCKPH + UCMSB + UCMST + UCSYNC) << 8) | UCSSEL__SMCLK;
msp430_usci_spi_default_config.brw = 1;
msp430_usci_spi_default_config.mctl = 0;*/
//printf("PlatformSpiP Init.init()\n");

    return call Resource.immediateRequest();
  }

  event void Resource.granted() { /*printf("Request granted in PlatformSpiP\n");*/ }
}
