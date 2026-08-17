module pc_tb;
    reg clk;
    reg rst;

    wire [15:0] addr;

    always #5 clk = ~clk;

    pc16 pc (
      .clk(clk),
      .rst(rst),
      .addr(addr)  
    );

    initial begin
        $monitor(
            "time=%0t rst=%b addr=%b (%d)",
            $time,
            rst,
            addr,
            addr
        );

        rst = 1;
        clk = 0;

        #10;

        rst = 0;
        
        #20;

        rst = 1;

        #10;

        rst = 0;

        #30;

        $finish;
    end
endmodule