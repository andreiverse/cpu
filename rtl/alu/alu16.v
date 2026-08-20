module alu16 (
    input wire [15:0] a,
    input wire [15:0] b,
    input wire        c_in,
    input wire [3:0]  sel,

    output reg [15:0] result,
    output reg [15:0]  flags,
    output reg flags_we
);

    wire [15:0] sum_r;
    wire        sum_c;
    wire [15:0] xor_r;
    wire [15:0] xnor_r;
    wire [15:0] inc_r;
    wire        inc_c;

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
        flags = 16'b0;
        flags_we = 0;
        if (sel == 4'b0001) begin
            result = sum_r;
            flags[0] = 1;
            flags_we = 1;
        end
        else if (sel == 4'b0010) begin
            result = xor_r;
            flags_we = 1;
        end
        else if (sel == 4'b0011) begin
            result = xnor_r;
            flags_we = 1;
        end
        else if (sel == 4'b0100) begin // inc
            result = inc_r;
            flags[0] = inc_c;
            flags_we = 1;
        end
        else if (sel == 4'b0101) begin // cmp
            if (a == b) flags[1] = 1; // Zflag
            if (a < b) flags[2] = 1; // Nflag !Pflag
            flags_we = 1;
        end
    end
endmodule

