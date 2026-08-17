module regfile16x16 (
    input clk,
    input rst,

    input [3:0] read_addr_a,
    input [3:0] read_addr_b,

    input [3:0]     write_addr,
    input           write_enable,
    input [15:0]    write_data,

    output wire [15:0] read_data_a,
    output wire [15:0] read_data_b
);
    wire [15:0] reg_data [0:15];

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin : regs
            reg16 r (
                .clk(clk),
                .rst(rst),
                .write_enable(write_enable && write_addr == i),
                .write_data(write_data),
                .read_data(reg_data[i])
            );
        end
    endgenerate

    assign read_data_a = reg_data[read_addr_a];
    assign read_data_b = reg_data[read_addr_b];
endmodule