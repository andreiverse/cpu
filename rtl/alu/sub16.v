module sub16(
    input wire [15:0] a,
    input wire [15:0] b,
    output wire [15:0] res,
    output wire carry_out
);
    assign {carry_out, res} = a + ~b + 16'b1;
endmodule