module xor16 (
    input wire [15:0] a,
    input wire [15:0] b,
    output reg [15:0] r
);
    integer i;

    always @(*) begin
       for (i = 0; i < 16; i = i + 1) begin
            r[i] = a[i] ^ b[i];
       end 
    end
endmodule

