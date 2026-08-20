module cpu(
    input wire clk,
    input wire rst
);
    wire [15:0] pc_addr;
    wire [15:0] instr;
    wire [15:0] jmp_addr;
    wire jmp_enable;

    pc16 pc(
        .clk(clk),
        .rst(rst),
        .addr(pc_addr),
        .jmp_enable(jmp_enable),
        .jmp_addr(jmp_addr)
    );

    rom instruction_memory(
        .addr(pc_addr),
        .data(instr)
    );

    wire [3:0] opcode;
    wire [3:0] rd;
    wire [3:0] rs;

    decoder dec(
        .instr(instr),
        .opcode(opcode),
        .rd(rd),
        .rs(rs),
        .jmp_addr(jmp_addr)
    );

    wire [3:0] alu_sel;
    wire write_enable;

    wire [15:0] a;
    wire [15:0] b;
    wire [15:0] write_data;
    wire [3:0] alu_flags;

    control_unit ctrl(
        .opcode(opcode),
        .alu_sel(alu_sel),
        .write_enable(write_enable),
        .jmp_enable(jmp_enable)
    );

    // todo: make it so we can read and write at the same time
    regfile16x16 regfile(
        .clk(clk),
        .rst(rst),
        .read_addr_a(rd),
        .read_addr_b(rs),

        .write_addr(rd),
        .write_enable(write_enable),
        
        .write_data(write_data),
        
        .read_data_a(a),
        .read_data_b(b)
    );

    alu16 alu(
        .a(a),
        .b(b),
        .c_in(1'b0),
        .sel(alu_sel),
        .result(write_data),
        .flags(alu_flags)
    );

endmodule