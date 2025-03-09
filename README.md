# Advanced Digital Car Lock & Health Monitoring System

## Overview
A gate-level digital car security and health monitoring system ensuring vehicle safety before ignition. It integrates a PIN-based digital lock and pre-ignition health checks for critical components.

## Key Features
- **Digital Lock:** 16-bit PIN authentication for ignition access.
- **Pre-Ignition Health Check:** Monitors engine oil, battery voltage, oil pressure, fuel, and radiator water levels.
- **Post-Ignition Safety:** Checks tyre pressure, engine temperature, seatbelt, and airbag status.
- **Automation:**
  - Rain sensor adjusts wiper speed.
  - Auto headlight control (fog, low, high beams).
  - Ride height adjustment based on driving mode.
  - Expected driving range calculation.

## Inputs & Outputs
**Inputs:**
- 16-bit PIN, 16-bit component status, 2-bit rain sensor, 3-bit headlight status, 4-bit driving mode.

**Outputs:**
- 1-bit authentication status, 1-bit warnings, 2-bit wiper speed, 3-bit headlight control, 4-bit ride height, 16-bit driving range.

## Technologies Used
- Gate-level logic: AND, OR, XOR, NOT gates.
- Comparators, multipliers, XNOR-based authentication.
- Seven-segment display logic.

## Simulation Device
- **Intel FPGA: "10M50DAF484C7G"** (Quartus Prime).

## Notes
- Developed with **minimal knowledge** of **gate-level modeling, Verilog, and Quartus Prime**.

## Conclusion
Enhances security, reliability, and automation by preventing unauthorized access and ensuring safe vehicle operation.

---
**Author:** Soneesh

