/*
 * Copyright (c) 2011 University of Utah. 
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:  
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 *
 *
 * @author Adam Erdelyi
 */

#include <RadioConfig.h>

configuration HplCC2520C{
    provides{
      interface GeneralIO as CCA;
      interface GeneralIO as CSN;
      interface GeneralIO as FIFO;
      interface GeneralIO as FIFOP;
      interface GeneralIO as RSTN;
      interface GeneralIO as SFD;
      interface GeneralIO as VREN;

      interface GpioInterrupt as FifoInterrupt;
      interface GpioInterrupt as FifopInterrupt;

      interface GpioCapture as SfdCapture;

      interface Resource as SpiResource;
      interface SpiByte;
      interface SpiPacket;
      //interface FastSpiByte;

      //interface GeneralIO as SLP_TR;

      //interface GpioCapture as IRQ;
      
      
      interface Alarm<TRadio, tradio_size> as Alarm;
      
      
      interface LocalTime<TRadio> as LocalTimeRadio;
    }
}

implementation{
//SPI
  components PlatformSpiC as SpiC;
  SpiResource = SpiC;
  SpiByte = SpiC;
  SpiPacket = SpiC;
  /*
  components CC2520SpiConfigC as RadioSpiConfigC;
  RadioSpiConfigC.Init <- SpiC;
  RadioSpiConfigC.ResourceConfigure <- SpiC;
*/
//Pins
  components HplMsp430GeneralIOC as IO;
  components new Msp430GpioC() as CCAM;
  components new Msp430GpioC() as CSNM;
  components new Msp430GpioC() as FIFOM;
  components new Msp430GpioC() as FIFOPM;
  components new Msp430GpioC() as RSTNM;
  components new Msp430GpioC() as SFDM;
  components new Msp430GpioC() as VRENM;

  CCAM	-> IO.Port13;
  CSNM	-> IO.Port30;
  FIFOM	-> IO.Port15;
  FIFOPM-> IO.Port16;
  RSTNM	-> IO.Port12;
  SFDM	-> IO.Port81;
  VRENM	-> IO.Port17;

  CCA    = CCAM;
  CSN    = CSNM;
  FIFO   = FIFOM;
  FIFOP  = FIFOPM;
  RSTN   = RSTNM;
  SFD    = SFDM;
  VREN   = VRENM;

//Capture
  components Msp430TimerC;
  components new GpioCaptureC() as CaptureSFDC;

  CaptureSFDC.Msp430TimerControl -> Msp430TimerC.Control0_A1;
  CaptureSFDC.Msp430Capture -> Msp430TimerC.Capture0_A1;
  CaptureSFDC.GeneralIO -> IO.Port81;

  SfdCapture = CaptureSFDC.Capture;
  
//Interrupts
  components HplMsp430InterruptC as IIO;
  components new Msp430InterruptC() as InterruptFIFOC;
  components new Msp430InterruptC() as InterruptFIFOPC;

  InterruptFIFOC.HplInterrupt -> IIO.Port15;
  InterruptFIFOPC.HplInterrupt -> IIO.Port16;

  FifoInterrupt = InterruptFIFOC.Interrupt;
  FifopInterrupt = InterruptFIFOPC.Interrupt;
  ///TODO CCA interrupt?
  

  /*
    components HplSam3sGeneralIOC as IO;
    SLP_TR = IO.PioC22;
    RSTN = IO.PioC27;
    SELN = IO.PioA19;
    
    components HplSam3sGeneralIOC;
    IRQ = HplSam3sGeneralIOC.CapturePioB1;
  */

/*
  components new GpioCaptureC() as SfdCaptureC;
  components HplSam3TCC;
  SfdCapture = SfdCaptureC;
  SfdCaptureC.TCCapture -> HplSam3TCC.TC1Capture; // TIOA1
  SfdCaptureC.GeneralIO -> IO.HplPioA15;*/

  components new AlarmMicro16C() as AlarmC;
  Alarm = AlarmC;

  components LocalTimeMicroC;
  LocalTimeRadio = LocalTimeMicroC;

}

