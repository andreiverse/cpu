module control_unit (
    input wire [3:0] opcode,

    output wire [3:0] alu_sel,
    output wire write_enable
);
    assign alu_sel = opcode;
    assign write_enable = 1'b1;
endmodule