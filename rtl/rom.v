module rom(
    input wire [15:0] addr,
    output wire [15:0] data
);
    reg [15:0] local_data[0:65535];

    assign data = local_data[addr];

    initial begin
        local_data[0] = 16'b0100000000000000; // inc r0;     r0++
        local_data[1] = 16'b0100000000010000; // inc r1;     r1++
        local_data[2] = 16'b0001000000010000; // add r1, r0; r1 += r0
        // r1 should be 16'b11
        // r0 should be 16'b1
    end
endmodule