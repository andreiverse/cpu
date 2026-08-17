`timescale 1ns/1ps

module cpu_tb;

    reg clk;
    reg rst;

    // Instantiate CPU
    cpu uut (
        .clk(clk),
        .rst(rst)
    );

    // 100 MHz clock (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk = 0;
        rst = 1;

        // Hold reset for 20 ns
        #20;
        rst = 0;

        // Run for 200 ns
        #200;

        $finish;
    end

    // Print signals every time they change
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);
        
        $monitor("t=%0t rst=%b PC=%h INSTR=%h OPCODE=%d",
                 $time,
                 rst,
                 uut.pc_addr,
                 uut.instr,
                 uut.opcode);
    end

endmodule