module ripple_adder16 (
    input wire [15:0] a, 
    input wire [15:0] b,
    input c_in,
    output c_out,
    output [15:0] sum
);
    assign {c_out, sum} = a + b + c_in;
endmodule

