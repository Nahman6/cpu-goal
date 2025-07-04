# 8-Bit Custom CPU in Verilog

This is a simple 8-bit CPU designed from scratch using SystemVerilog. It performs basic arithmetic and logic operations and is ideal for understanding the fundamentals of processor design.

## Components

- `alu.sv` – Performs ADD, SUB, AND based on `alu_op`.
- `control_unit.sv` – Decodes opcodes to generate control signals.
- `register_file.sv` – Holds 8 general-purpose 8-bit registers.
- `cpu_core.sv` – Ties together all modules.
- `cpu_core_tb.sv` – Testbench with sample instructions.

## Features

- Custom 16-bit instruction format:
  [15:10] Opcode
  [9:7] rs
  [6:4] rt
  [3:1] rd
  [0] Padding (unused)

- Supported instructions:
- `000000` → ADD
- `000001` → SUB
- `000010` → AND

---

Example Simulation:

```verilog
instruction = 16'b000000_010_011_001_0; // ADD R1 = R2 + R3


Initial values:
R2 = 5
R3 = 7

Expected result: R1 = 12 ✅


## How to Run
You can run this project using:

-EDA Playground
-ModelSim / Questa / Icarus Verilog / GTKWave
```
