/**
 * Msp430Timer32khzMapC presents as paramaterized interfaces all of the 1 micro
 * hardware timers on the MSP430x5xxx that are available for compile time allocation.
 *
 * Based on chips/msp430/x5xxx/timer/Msp430TimerC.nc and TI SLAS655B (MSP430F543xA, MSP430F541xA Datasheet).
 *
 * @author Adam Erdelyi <a.erdelyi@nthfs.jku.at>
 */

configuration Msp430Timer32khzMapC {
  provides {
    interface Msp430Timer[ uint8_t id ];
    interface Msp430TimerControl[ uint8_t id ];
    interface Msp430Compare[ uint8_t id ];
  }
}
implementation {
  components Msp430TimerC;

  Msp430Timer[0] = Msp430TimerC.Timer1_A;
  Msp430TimerControl[0] = Msp430TimerC.Control1_A0;
  Msp430Compare[0] = Msp430TimerC.Compare1_A0;

  Msp430Timer[1] = Msp430TimerC.Timer1_A;
  Msp430TimerControl[1] = Msp430TimerC.Control1_A1;
  Msp430Compare[1] = Msp430TimerC.Compare1_A1;

  Msp430Timer[2] = Msp430TimerC.Timer1_A;
  Msp430TimerControl[2] = Msp430TimerC.Control1_A2;
  Msp430Compare[2] = Msp430TimerC.Compare1_A2;
}
