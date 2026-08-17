module reg16 (
    input                clk, rst, write_enable,
    input [15:0]         write_data,
    output wire [15:0]   read_data
);
    reg [15:0] data;

    always @(posedge clk) begin
        if (rst) data <= 0;
        else if (write_enable) begin
            data <= write_data;
        end
    end

    assign read_data = data;
endmodule