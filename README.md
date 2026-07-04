# VHDL UART Controller

## Overview
This repository contains the VHDL implementation of an 8-bit Universal Asynchronous Receiver/Transmitter (UART). The project was developed to understand and simulate hardware-level serial communication. It is designed to be synthesized on an FPGA and has been successfully tested using a PC serial terminal (Minicom).

## Features
* **Protocol:** RS232 standard format.
* **Frame Configuration:** 8 data bits, 1 start bit, 1 stop bit, and no parity bit.
* **Baud Rate Generation:** Derived from a 1550 kHz base clock (`clk`).
  * The transmission enable signal (`enableTX`) operates at 9.6 kHz.
  * The reception enable signal (`enableRX`) operates at 155 kHz. This allows for 16x oversampling of the incoming signal to handle asynchronous clock drift.
* **Hardware Error Detection:** Identifies framing errors (missing stop bit) and overrun errors (unread data).

## Architecture
The system is divided into several modular VHDL components:

### 1. `clkUnit` (Clock Generator)
This unit divides the processor's base clock into the specific frequencies required for transmission and reception. 

### 2. `TxUnit` (Transmitter)
Transmits data bit by bit over the `TxD` line. It uses a two-stage architecture with a buffer (`BufferT`) and a shift register (`RegisterT`) to allow the processor to queue the next byte while the current one is still transmitting.

### 3. `RxUnit` (Receiver)
Receives data from the `RxD` line. It waits for a start bit, then uses a 16-tick counter to sample the incoming data reliably in the middle of the bit period. It outputs a `DRdy` (Data Ready) signal upon successful reception and flags `FErr` (Framing Error) or `OErr` (Overrun Error) if issues occur.

### 4. `ctrlUnit` (Control Unit)
A state management module that tracks the UART's status. It provides interrupt signals to the processor (`IntR` for received data, `IntT` for transmission readiness) and exposes a control register (`ctrlReg`).

## FPGA Integration & Testing
The top-level entity, `UART_FPGA_N4`, wraps the core UART with additional components for physical hardware testing:
* **`diviseurClk`:** Scales the external board clock down to the required 1550 kHz base clock.
* **`echoUnit`:** A hardware loopback module. It listens for the `IntR` interrupt, reads the received character, and immediately writes it back to the transmitter.
