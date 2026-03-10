# FPGA Traffic Light System 🚦

A hardware-based traffic light controller written in Verilog, designed and implemented on the Digilent Arty Z7-20 FPGA development board. 



This project simulates a dual-intersection traffic light system. It features a robust Finite State Machine (FSM), manual timer configuration via physical switches, button debouncing, and Binary-Coded Decimal (BCD) outputs for an external 7-segment display.

## Table of Contents
   1. [Table of Contents](#table-of-contents)
   2. [Features](#features)
   3. [Project Structure](#project-structure)
   4. [Finite State Machine Overview](#finite-state-machine-overview)
   5. [Hardware I/O Mapping](#hardware-io-mapping)

## Features
* **Dual Intersection Control:** Manages two sets of traffic lights (Light 1 and Light 2) with synchronized transitions (Red, Green, Yellow).
* **Programmable Timers:** Users can dynamically reconfigure the duration of Red, Green, and Yellow lights using onboard switches and buttons.
* **Hardware Debouncing:** Custom debounce module ensures stable button presses without false triggers.
* **Countdown Display:** Outputs active countdown timers in BCD format, ready to be routed to an external 7-segment display module via PMOD headers.

## Project Structure

```
fpga-traffic-light-system/
├── constraint/
│   └── Arty-Z7-20-Master.xdc
├── rtl/
│   ├── btn_debounce.v
│   ├── seven_seg_controller.v
│   ├── traffic_controller.v
│   └── traffic_light_top.v
└── tb/
    └── tb_traffic_light.v
```


## Finite State Machine Overview

**Automatic Mode:**
* `RED1_GREEN2_STATE`
* `RED1_YELLOW2_STATE`
* `GREEN1_RED2_STATE`
* `YELLOW1_RED2_STATE`

**Configuration Mode:**
If the user want to enters manual configuration mode, it navigates through: `RED_MAN`, `GREEN_MAN`, and `YELLOW_MAN` states, allowing the user to set new timings before returning to standard operation.

## Hardware I/O Mapping

| Signal | Direction | Interface | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | System Clock | Base clock for debouncing and 1Hz timing |
| `rst` | Input | Button | System reset, restores default timings (R=5, G=3, Y=2) |
| `btnR` / `btnL` | Input | Buttons | Navigate through manual configuration states |
| `btnC` | Input | Button | Commit/Save the new timer configuration |
| `sw[3:0]` | Input | Switches | Set timing duration in seconds (1 to 15) |
| `red, green, yellow` | Output | LEDs | Traffic Light 1 indicators |
| `red2, green2, yellow2`| Output | LEDs | Traffic Light 2 indicators |
| `bcd1[3:0]` | Output | External/PMOD | BCD output for Light 1 countdown |
| `bcd2[3:0]` | Output | External/PMOD | BCD output for Light 2 countdown |

