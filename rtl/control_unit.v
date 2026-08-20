module control_unit (
    input wire [3:0] opcode,
    input wire [15:0] flags,
    output wire [3:0] alu_sel,
    output wire write_enable,
    output wire jmp_enable
);
    assign jmp_enable = (opcode == 4'b1100) || (opcode == 4'b1101 && flags[1] == 1);
    assign alu_sel = opcode;
    assign write_enable = (opcode == 4'b1100 || opcode == 4'b0101 || opcode == 4'b1101) ? 1'b0 : 1'b1;
endmodule