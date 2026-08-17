module decoder(
    input wire [15:0] instr,

    output wire [3:0] opcode,
    output wire [3:0] rd,
    output wire [3:0] rs
);
    assign opcode = instr[15:12];
    assign rd = instr[7:4];
    assign rs = instr[3:0];
endmodule