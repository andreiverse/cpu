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