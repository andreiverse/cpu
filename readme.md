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
       ├── [7:4]   → Rd | or [7:0] address 
       └── [3:0]   → Rs |
```

### instructions

```

0001 0000 [ 4 bit rd ][ 4 bit rs ] - sum 2 registers
0010 0000 [ 4 bit rd ][ 4 bit rs ] - xor 2 registers
0011 0000 [ 4 bit rd ][ 4 bit rs ] - xnor 2 registers
0100 0000 [ 4 bit rd ]        0000 - increment a register
1100 0000 [     8 bit address    ] - jmp to an address
```

## example program

```
        local_data[0] = 16'b0100000000000000; // inc r0;     r0++
        local_data[1] = 16'b0100000000010000; // inc r1;     r1++
        local_data[2] = 16'b0001000000010000; // add r1, r0; r1 += r0
        local_data[3] = 16'b1100000000000000; // jmp 0x0 ; jmps to start, looping
```

output:

```
t=5000 PC=0000 INSTR=4000 | R0=0000 R1=0000 R2=0000 R3=0000
t=25000 PC=0001 INSTR=4010 | R0=0001 R1=0000 R2=0000 R3=0000
t=35000 PC=0002 INSTR=1010 | R0=0001 R1=0001 R2=0000 R3=0000
t=45000 PC=0003 INSTR=c000 | R0=0001 R1=0002 R2=0000 R3=0000
t=55000 PC=0000 INSTR=4000 | R0=0001 R1=0002 R2=0000 R3=0000
t=65000 PC=0001 INSTR=4010 | R0=0002 R1=0002 R2=0000 R3=0000
t=75000 PC=0002 INSTR=1010 | R0=0002 R1=0003 R2=0000 R3=0000
t=85000 PC=0003 INSTR=c000 | R0=0002 R1=0005 R2=0000 R3=0000
t=95000 PC=0000 INSTR=4000 | R0=0002 R1=0005 R2=0000 R3=0000
t=105000 PC=0001 INSTR=4010 | R0=0003 R1=0005 R2=0000 R3=0000
t=115000 PC=0002 INSTR=1010 | R0=0003 R1=0006 R2=0000 R3=0000
t=125000 PC=0003 INSTR=c000 | R0=0003 R1=0009 R2=0000 R3=0000
t=135000 PC=0000 INSTR=4000 | R0=0003 R1=0009 R2=0000 R3=0000
t=145000 PC=0001 INSTR=4010 | R0=0004 R1=0009 R2=0000 R3=0000
t=155000 PC=0002 INSTR=1010 | R0=0004 R1=000a R2=0000 R3=0000
t=165000 PC=0003 INSTR=c000 | R0=0004 R1=000e R2=0000 R3=0000
t=175000 PC=0000 INSTR=4000 | R0=0004 R1=000e R2=0000 R3=0000
t=185000 PC=0001 INSTR=4010 | R0=0005 R1=000e R2=0000 R3=0000
t=195000 PC=0002 INSTR=1010 | R0=0005 R1=000f R2=0000 R3=0000
t=205000 PC=0003 INSTR=c000 | R0=0005 R1=0014 R2=0000 R3=0000
t=215000 PC=0000 INSTR=4000 | R0=0005 R1=0014 R2=0000 R3=0000
```