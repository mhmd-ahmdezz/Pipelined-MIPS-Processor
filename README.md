# Pipelined MIPS Processor - RTL Design & Functional Verification
> **Status:** RTL Verified | Hazard-Free Pipeline Confirmed | Verification Environment: In Progress
## Table of Contents:
- [Pipelined MIPS Processor - RTL Design \& Functional Verification](#pipelined-mips-processor---rtl-design--functional-verification)
  - [Table of Contents:](#table-of-contents)
  - [Project Overview:](#project-overview)
  - [Architecture:](#architecture)
  - [Verification Startegy:](#verification-startegy)
  - [Roadmap:](#roadmap)
  - [Tools \& Technologies:](#tools--technologies)
  - [How to Run:](#how-to-run)
  - [What I'm Learnging](#what-im-learnging)

## Project Overview:
this project implements a **5-stage pipelined MIPS processor** in SystemVerilog. The goal is not only to build a working RTL Design, but to build a layered verification environment, coverage-driven testbench.

## Architecture:
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
## Verification Startegy:
## Roadmap:
## Tools & Technologies:
## How to Run:
## What I'm Learnging
