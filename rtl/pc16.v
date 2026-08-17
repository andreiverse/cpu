module pc16(
    input wire clk,
    input wire rst,

    output wire [15:0] addr 
);
    reg [15:0] data;

    always @(posedge clk) begin
        if (rst) data <= 0;
        else data <= data + 1;
    end

    assign addr = data;
endmodule