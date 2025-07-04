## 🔹 Phase 1: ALU + Register File + Control Unit

This is the first milestone of my 8-bit CPU project built in Verilog.  
In this phase, I’ve implemented the **core components** of the processor that handle simple arithmetic instructions.

---

## 🧠 What This Phase Includes

- **3-bit ALU** that supports:
  - ADD
  - SUB
  - AND
- **Register File** with 8 general-purpose 8-bit registers (R0 to R7)
- **Control Unit** that decodes instructions (6-bit opcode)
- **CPU Core Module** that connects ALU, control, and registers
- **Testbench** that simulates sample instructions and verifies outputs

---

## 🧱 Instruction Format (16-bit)

[15:10] Opcode → Tells the control unit which ALU operation to perform
[9:7] rs → Source Register 1
[6:4] rt → Source Register 2
[3:1] rd → Destination Register
[0] Padding (unused for now)

## ✅ Supported Instructions (via Opcode)

| Opcode | Operation | Description           |
| ------ | --------- | --------------------- |
| 000000 | ADD       | R[rd] = R[rs] + R[rt] |
| 000001 | SUB       | R[rd] = R[rs] - R[rt] |
| 000010 | AND       | R[rd] = R[rs] & R[rt] |

---

## 🧪 Example Simulation

Testbench simulates the following:

1. `ADD R1, R2, R3`
2. `SUB R4, R3, R2`
3. `AND R5, R2, R3`

Initial values in registers:

```verilog
registers[2] = 5;
registers[3] = 7;

R1 = 12   // 5 + 7
R4 = 2    // 7 - 5
R5 = 5    // 5 & 7

## Files

src/alu.sv – Arithmetic logic unit
src/register_file.sv – Register storage and access
src/control_unit.sv – Instruction decoder
src/cpu_core.sv – Main CPU module
testbench/cpu_core_tb.sv – Testbench for simulation

```
