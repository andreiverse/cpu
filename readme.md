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

### running programs

- fibb.asm calculates fibb numbers indefinetely
- counting.asm counts to 10

```
python assembler.py fibb.asm
.\run.ps1
```

### instructions

```
    OPCD
    0000 0000         0000        0000 - NOP
  OPERATIONS
    0001         0000 [ 4 bit rd ][ 4 bit rs ] - NOP
    0001         0001 [ 4 bit rd ][ 4 bit rs ] - sum 2 registers (sets C flag)
    0001         0010 [ 4 bit rd ][ 4 bit rs ] - sub 2 registers (sets Z, N, C, V flags)
    0001         0011 [ 4 bit rd ][ 4 bit rs ] - xor 2 registers
    0001         0100 [ 4 bit rd ][ 4 bit rs ] - xnor 2 registers
    0001         0101 [ 4 bit rd ][ 4 bit rs ] - rd = rs, used for moving
    0001         1000 [ 4 bit rd ]        0000 - inc register (sets C flag)
    0001         1111 [ 4 bit rd ][ 4 bit rs ] - cmp 2 registers, same as sub but doesnt write to rd
  JUMPS
    0010         0000 [     8 bit address    ] - jmp to an address 
    0010         0001 [     8 bit address    ] - jz to an address 
    0010         0010 [     8 bit address    ] - jn to an address 
    0010         0011 [     8 bit address    ] - jc to an address 
    0010         0100 [     8 bit address    ] - jv to an address 
    0010         0101 [     8 bit address    ] - jnz to an address 
    0010         0110 [     8 bit address    ] - jnn to an address 
    0010         0111 [     8 bit address    ] - jnc to an address 
    0010         1000 [     8 bit address    ] - jnv to an address 
  MOVS
    0011 [ 4 bit rd ] [    8 bit imm value   ] - mov to a register
```
