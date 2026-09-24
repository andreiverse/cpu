module rom(
    input wire [15:0] addr,
    output wire [15:0] data,
    output wire [15:0] data_next
);
    reg [15:0] local_data[0:65535];

    assign data = local_data[addr];
    assign data_next = local_data[addr + 1];

    initial begin
        $readmemh("program.hex", local_data, 0, 65535);
    end
endmodule