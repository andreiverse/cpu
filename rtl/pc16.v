module pc16(
    input wire clk,
    input wire rst,
    input wire jmp_enable,
    input wire [15:0] jmp_addr,
    output wire [15:0] addr 
);

    reg [15:0] data;

    always @(posedge clk) begin
        if (rst)
            data <= 16'b0;
        else if (jmp_enable)
            data <= jmp_addr;
        else
            data <= data + 1'b1;
    end

    assign addr = data;

endmodule