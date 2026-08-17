# ALU
iverilog -o alu_sim -s alu_tb `
    .\tb\alu_tb.v `
    .\rtl\alu\alu16.v `
    .\rtl\alu\ripple_adder16.v `
    .\rtl\alu\xor16.v `
    .\rtl\alu\xnor16.v

vvp .\alu_sim

# Register file
iverilog -o regfile_sim -s regfile_tb `
    .\tb\regfile_tb.v `
    .\rtl\reg\regfile16x16.v `
    .\rtl\reg\reg16.v

vvp .\regfile_sim

#pc
iverilog -o pc_sim -s pc_tb `
    .\tb\pc_tb.v `
    .\rtl\pc16.v

vvp .\pc_sim