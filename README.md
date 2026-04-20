# Pipelined MIPS Processor - RTL Design & Functional Verification
> **Status:** RTL Verified | Hazard-Free Pipeline Confirmed | Verification Environment: In Progress
## Table of Contents
- [Table of Contents](#table-of-contents)
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Verification Startegy](#verification-startegy)
- [What I'm Learning](#what-im-learning)

## Project Overview
this project implements a **5-stage pipelined MIPS processor** in SystemVerilog. The goal is not only to build a working RTL Design, but to build a layered verification environment, coverage-driven testbench.

## Architecture
The processor implements the classic **5-stage MIPS pipeline**
| Stage | Name | Description |
|-------|------|-------------|
| IF | Instruction Fetch | Fetches the instruction from memory using program counter(PC)|
| ID | Instruction Decode | Decode opcode, read register file, generates control signals|
| EX | Execute | ALU Operations|
| MEM | Memory Access | Load/store operations to data memory |
| WB  | Write Back | Write result back to the register file |
<!-- 
### Hazard Handling:
| Hazard Type | Solution | Status |
|-------------|----------|--------|
| RAW | Register Forwarding (EX-EX, MEM-EX paths) | Implemented |
| Load-Use Hazard | Pipeline Stall (1-cycle bubble insertion) | Implemented | -->
## Verification Startegy
This section contains the verification approach applied to this project, progressing from 
**directed testing** toward **coverage-driven verification**.
- [x] TCL Automation Suite: Developed scripts to automate instruction assembly and memory loading using MARS.
- [x] Directed Testbench: Execute some assembly codes which check how the design handle the hazards. 
- [ ] Comparing Register File and Data Memory dumps with a Golden Model (MARS Simulator).
- [ ] SystemVerilog Assertions and Functional Coverage: Adding Concurrent assertions to monitor pipeline integrity.
- [ ] OOP-Based Testbench: Moving toward a class-based environment utilizing Mailboxes and Events for Inter-Process Communication (IPC).
- [ ] UVM-Lite Architecture: Implementing a modular Driver-Monitor-Scoreboard structure.

## What I'm Learning
- SystemVerilog Interporcess Communication
- Layered Testbench Components
- SystemVerilog Class-Based Verification Environment
