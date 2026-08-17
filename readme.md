# d4²

16 bit cpu to learn verilog
- 16x 16-bit registers
- 16-bit ALU/data path
- 16-bit instructions
- 16-bit addresses
- 16 registers
    - 4-bit opcode
    - 4-bit destination register
    - 4-bit source register

## instruction

```
16-bit instruction
       │
       ├── [15:12] → opcode
       ├── [11:8]  → reserved
       ├── [7:4]   → Rd
       └── [3:0]   → Rs
```

## alu

```
sel     operation
──────────────────
0001    ADD
0010    XOR
0011    XNOR

flags[0] = carry
flags[1] = unused
flags[2] = unused
flags[3] = unused
```

## example program

```
        local_data[0] = 16'b0100000000000000; // inc r0;     r0++
        local_data[1] = 16'b0100000000010000; // inc r1;     r1++
        local_data[2] = 16'b0001000000010000; // add r1, r0; r1 += r0
```

output:

```
t=5000 PC=0000 INSTR=4000 | R0=0000 R1=0000 R2=0000 R3=0000
t=25000 PC=0001 INSTR=4010 | R0=0001 R1=0000 R2=0000 R3=0000
t=35000 PC=0002 INSTR=1010 | R0=0001 R1=0001 R2=0000 R3=0000
```