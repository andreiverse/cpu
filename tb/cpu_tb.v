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

    
    initial begin
        $monitor(
            "t=%0t PC=%h INSTR=%h | R0=%h R1=%h R2=%h R3=%h (Flags: %b) (DW: %d) (alu: %b) (je: %b)",
            $time,
            uut.pc_addr,
            uut.instr,
            uut.regfile.reg_data[0],
            uut.regfile.reg_data[1],
            uut.regfile.reg_data[2],
            uut.regfile.reg_data[3],
            uut.alu_flags_read,
            uut.data_writer,
            uut.alu_sel,
            uut.jmp_enable
        );
    end

endmodule