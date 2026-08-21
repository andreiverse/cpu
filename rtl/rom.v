module rom(
    input wire [15:0] addr,
    output wire [15:0] data
);
    reg [15:0] local_data[0:65535];

    assign data = local_data[addr];

    initial begin
        $readmemh("program.hex", local_data, 0, 65535);
    end
endmodule