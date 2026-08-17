module rom(
    input wire [15:0] addr,
    output wire [15:0] data
);
    reg [15:0] local_data[0:65535];

    assign data = local_data[addr];

    initial begin
        local_data[0] = 16'h1234;
        local_data[1] = 16'h5678;
        local_data[2] = 16'hABCD;
    end
endmodule