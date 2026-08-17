module alu16 (
    input wire [15:0] a,
    input wire [15:0] b,
    input wire        c_in,
    input wire [3:0]  sel,

    output reg [15:0] result,
    output reg [3:0]  flags
);

    wire [15:0] sum_r;
    wire        sum_c;
    wire [15:0] xor_r;
    wire [15:0] xnor_r;

    ripple_adder16 alu_ripple_adder (
        .a(a),
        .b(b),
        .c_in(c_in),
        .c_out(sum_c),
        .sum(sum_r)
    );

    xor16 alu_xor (
        .a(a),
        .b(b),
        .r(xor_r)
    );

    xnor16 alu_xnor4 (
        .a(a),
        .b(b),
        .r(xnor_r)
    );

    always @(*) begin
        result = 16'b0;
        flags = 4'b0;

        if (sel == 4'b0001) begin
            result = sum_r;
            flags[0] = sum_c;
        end
        else if (sel == 4'b0010) begin
            result = xor_r;
        end
        else if (sel == 4'b0011) begin
            result = xnor_r;
        end
    end
endmodule

