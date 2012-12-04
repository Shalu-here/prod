/**
 * Msp430TimerMicroMapC presents as paramaterized interfaces all of the 1 micro
 * hardware timers on the MSP430x5xxx that are available for compile time allocation.
 *
 * Based on chips/msp430/x5xxx/timer/Msp430TimerC.nc and TI SLAS655B (MSP430F543xA, MSP430F541xA Datasheet).
 *
 * @author Adam Erdelyi <a.erdelyi@nthfs.jku.at>
 */

configuration Msp430TimerMicroMapC {
  provides {
    interface Msp430Timer[ uint8_t id ];
    interface Msp430TimerControl[ uint8_t id ];
    interface Msp430Compare[ uint8_t id ];
  }
}
implementation {
  components Msp430TimerC;
  
  Msp430Timer[0] = Msp430TimerC.Timer0_A;
  Msp430TimerControl[0] = Msp430TimerC.Control0_A0;
  Msp430Compare[0] = Msp430TimerC.Compare0_A0;

  //TA0.1 is used for SFD capture
  
  Msp430Timer[1] = Msp430TimerC.Timer0_A;
  Msp430TimerControl[1] = Msp430TimerC.Control0_A2;
  Msp430Compare[1] = Msp430TimerC.Compare0_A2;

  Msp430Timer[2] = Msp430TimerC.Timer0_A;
  Msp430TimerControl[2] = Msp430TimerC.Control0_A3;
  Msp430Compare[2] = Msp430TimerC.Compare0_A3;

  Msp430Timer[3] = Msp430TimerC.Timer0_A;
  Msp430TimerControl[3] = Msp430TimerC.Control0_A4;
  Msp430Compare[3] = Msp430TimerC.Compare0_A4;
}
