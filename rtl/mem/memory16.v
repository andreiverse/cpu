module memory16(
    input clk,
    input rst,

    input [7:0] read_addr,

    input [7:0]    write_addr,
    input           write_enable,
    input [15:0]    write_data,

    output wire [15:0] read_data
);
    wire [15:0] reg_data [0:255];

    genvar i;

    generate
        for (i = 0; i < 256; i = i + 1) begin : regs
            reg16 r (
                .clk(clk),
                .rst(rst),
                .write_enable(write_enable && write_addr == i[7:0]),
                .write_data(write_data),
                .read_data(reg_data[i])
            );
        end
    endgenerate

    assign read_data = reg_data[read_addr];
endmodule