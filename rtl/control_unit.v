module control_unit (
    input wire [3:0] opcode,

    output wire [3:0] alu_sel,
    output wire write_enable,
    output wire jmp_enable
);
    assign jmp_enable = (opcode == 4'b1100);
    assign alu_sel = opcode;
    assign write_enable = 1'b1;
endmodule