module regfile_tb;

    reg clk;
    reg rst;
    reg [3:0] read_addr_a;
    reg [3:0] read_addr_b;
    reg [3:0] write_addr;
    reg write_enable;
    reg [15:0] write_data;

    wire [15:0] read_data_a;
    wire [15:0] read_data_b;

    regfile16x16 dut (
        .clk(clk),
        .rst(rst),
        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),
        .write_addr(write_addr),
        .write_enable(write_enable),
        .write_data(write_data),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b)
    );

    // clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        write_enable = 0;
        write_data = 0;
        write_addr = 0;
        read_addr_a = 0;
        read_addr_b = 0;

        #10;

        rst = 0;

        // Write 10 to register 3
        write_addr = 4'd3;
        write_data = 16'd10;
        write_enable = 1;

        #10;
        
        rst = 0;

        // Write 20 to register 4
        write_addr = 4'd4;
        write_data = 16'd20;
        write_enable = 1;

        #10;


        // Stop writing
        write_enable = 0;

        // Read register 3 and 4
        read_addr_a = 4'd3;
        read_addr_b = 4'd4;

        #10;

        $finish;
    end

endmodule