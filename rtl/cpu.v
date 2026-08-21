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

    wire alu_flags_we;
    wire [15:0] alu_flags_write;
    wire [15:0] alu_flags_read;

    // 0 Z = Zero
    // 1 N = Negative
    // 2 C = Carry / Borrow
    // 3 V = Overflow

    reg16 alu_flags_reg(
        .clk(clk),
        .rst(rst),
        .write_enable(alu_flags_we),
        .write_data(alu_flags_write),
        .read_data(alu_flags_read)
    );

    wire [3:0] alu_sel;

    wire [3:0] rd;
    wire [3:0] rs;

    wire [15:0] a;
    wire [15:0] b;

    wire [15:0] ctrl_write_data;
    
    wire [15:0] data_writer; // 0 = nobody, 1 = ctrl_unit, 2 = alu
    
    control_unit ctrl(
        .instr(instr),
        .alu_sel(alu_sel),
        .flags(alu_flags_read),
        .jmp_enable(jmp_enable),
        .jmp_addr(jmp_addr),
        .rd(rd),
        .rs(rs),
        .write_data(ctrl_write_data),
        .data_writer(data_writer)
    );

    wire [15:0] alu_write_data;
    
    regfile16x16 regfile(
        .clk(clk),
        .rst(rst),
        .read_addr_a(rd),
        .read_addr_b(rs),

        .write_addr(rd),
        .write_enable(data_writer == 16'b0 ? 1'b0 : 1'b1),
        
        .write_data(data_writer == 16'd2 ? alu_write_data : ctrl_write_data),
        
        .read_data_a(a),
        .read_data_b(b)
    );
    
    assign alu_flags_we = alu_sel != 4'b0;


    alu16 alu(
        .a(a),
        .b(b),
        .flags_in(alu_flags_read),
        .sel(alu_sel),
        .result(alu_write_data),
        .flags(alu_flags_write)
    );

endmodule