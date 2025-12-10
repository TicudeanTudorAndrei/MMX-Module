# MMX Arithmetic Unit in VHDL

This project implements a simplified **MMX-style arithmetic unit** in VHDL, capable of executing 16 packed-integer SIMD operations such as addition, subtraction, logical AND, shift operations, multiplication, and multiply-add (PMADD). 

The design follows Intel's original MMX conceptual model, using 64-bit packed data and segment-based execution (8b / 16b / 32b / 64b).

## Features
- **SIMD packed operations** (byte, word, doubleword, quadword)  
- **16 MMX instructions implemented**  
- **VHDL structural design** for adder, shifter, logic unit, multiplier  
- **Static memory for operands (128-bit entries)**  
- **Control unit** handling operation decoding & signal routing  
- **FPGA-ready top-level architecture** with switches, buttons, and SSD output  
- **Matrix-based multiplier** (structural)  
- **Supports saturation/wrap-around semantics where relevant**

## Supported Instructions
**Arithmetic:**  
- `PADD` (b, w, d)  
- `PSUB` (b, w, d)

**Logical:**  
- `PAND`

**Shift:**  
- `PSLL` (w, d, q)  
- `PSRL` (w, d, q)

**Multiply:**  
- `PMULLW`  
- `PMULHW`

**Multiply–Add:**  
- `PMADDWD`

> b = 8 bits, w = 16 bits, d = 32 bits, q = 64 bits

All operations are encoded using a 4-bit control signal

- “0000” = PADD (b) 
- "0100" = PSUB (w) 
- “0001” = PADD (w) 
- "0010" = PADD (d) 
- "0011" = PSUB (b) 
- "0101" = PSUB (d) 
- "0110" = PAND 
- "0111" = PSLL (w) 
- "1000" = PSLL (d) 
- "1001" = PSLL (q) 
- "1010" = PSRL (w) 
- "1011" = PSRL (d) 
- "1100" = PSRL (q) 
- "1101" = Pmullw 
- "1110" = Pmulhw 
- "1111" = Pmaddw

## Architecture Overview

### Adder  
- 64-bit segmented adder built from full adders  
- Segment-based carries (8/16/32-bit groups)

### Two’s-Complement Generator  
- Segment-aware two's complement for subtraction and negative values

### Shift Unit  
- Uses `numeric_std` left/right logical shifts  
- Supports 16-bit, 32-bit, and 64-bit packed shifting

### Logical Unit  
- Supports AND on full 64-bit packed operands

### Multiplier  
- Matrix-based structural multiplier  
- Supports:
  - PMULLW (lower 16 bits)
  - PMULHW (upper 16 bits)
  - PMADDWD (multiply + horizontal add)

### Control Unit  
- Decodes instruction  
- Enables correct datapath components  
- Selects final 64-bit result via multiplexers

### Top-Level System  
- Operands stored in 128-bit memory entries  
- Switches select instruction and memory address  
- 7-segment displays show low/high 32 bits of result  
- Ready for FPGA mapping

## Testing & Validation
All instructions validated through simulation:
- Packed addition/subtraction (8/16/32-bit)
- Logical AND
- Shifts
- Multiplication (low & high)
- Multiply–add

Each testbench compares RTL results with external reference values.
