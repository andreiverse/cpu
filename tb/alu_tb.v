module alu_tb;
    reg [15:0] a;
    reg [15:0] b;
    reg c_in;
    reg [3:0] sel;

    wire [15:0] result;
    wire [15:0] flags;

    alu16 dut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .sel(sel),
        .result(result),
        .flags(flags)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);
        $monitor("a=%d b=%d c_in=%b sel=%d | result=%d flags=%b",
            a, b, c_in, sel, result, flags);

        // adder logic test 
        a = 16'd3;
        b = 16'd5;
        c_in = 1;
        sel = 4'b0001;
        #10;

        // sub logic test 
        a = 16'd10;
        b = 16'd5;
        c_in = 0;
        sel = 4'b0010;
        #10;
        
        // xor logic test 
        a = 16'd3;
        b = 16'd5;
        c_in = 0;
        sel = 4'b0011;
        #10;
        
        // xnor logic test 
        a = 16'd3;
        b = 16'd5;
        c_in = 0;
        sel = 4'b0100;
        #10;
 
        // inc logic test 
        a = 16'd3;
        b = 16'd5;
        c_in = 0;
        sel = 4'b1000;
        #10;

        $finish;
    end
endmodule