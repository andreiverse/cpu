module decoder(
    input wire [15:0] instr,

    output wire [3:0] opcode,
    output wire [3:0] rd,
    output wire [3:0] rs,
    output wire [15:0] jmp_addr
);
    assign opcode = instr[15:12];
    assign rd = instr[7:4];
    assign rs = instr[3:0];
    assign jmp_addr = {8'b0, instr[7:0]};
endmodule