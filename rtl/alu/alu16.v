module alu16 (
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [15:0] flags_in,
    input wire [3:0]  sel,

    output reg [15:0] result,
    output reg [15:0]  flags
);

    wire [15:0] sum_r;
    wire        sum_c;
    wire [15:0] xor_r;
    wire [15:0] xnor_r;
    wire [15:0] inc_r;
    wire        inc_c;
    wire [15:0] sub_r;
    wire        sub_c;

    ripple_adder16 alu_incrementer (
        .a(a),
        .b(16'b1),
        .c_in(1'b0),
        .c_out(inc_c),
        .sum(inc_r)
    );

    ripple_adder16 alu_ripple_adder (
        .a(a),
        .b(b),
        .c_in(1'b0),
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

    sub16 alu_sub (
        .a(a),
        .b(b),
        .res(sub_r),
        .carry_out(sub_c)
    );

    always @(*) begin
        result = 16'b0;
        flags = flags_in;

        case (sel)
            4'b0001: begin
                result   = sum_r; 
                flags[2] = sum_c;
            end
            4'b0010: begin
                result   = sub_r;
                flags[0] = (sub_r == 16'b0);                         // Z flag
                flags[1] = (sub_r[15]);                              // N flag
                flags[2] = sub_c;                                    // C flag
                flags[3] = (a[15] != b[15]) && (sub_r[15] != a[15]); // V flag
            end
            4'b0011:
                result = xor_r;
            4'b0100:
                result = xnor_r;
            4'b0101: // used for mov
                result = b; 
            4'b1000: begin
                result   = inc_r;
                flags[2] = inc_c;
            end
        endcase
    end
endmodule