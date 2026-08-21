module control_unit (
    input wire [15:0] instr,
    input wire [15:0] flags,
    output reg [3:0] alu_sel,
    output reg [3:0] rd,
    output reg [3:0] rs,
    output reg jmp_enable,
    output reg [15:0] jmp_addr,
    output reg [15:0] write_data,
    output reg [15:0] data_writer
);
    always @(*) begin
        alu_sel      = 4'b0000;
        rd           = 4'b0000;
        rs           = 4'b0000;
        jmp_enable   = 1'b0;
        jmp_addr     = 16'b0000_0000_0000_0000;
        write_data   = 16'b0000_0000_0000_0000;
        data_writer  = 16'b0000_0000_0000_0000;

        case (instr[15:12])
            // ALU instruction group
            4'b0001: begin
                if (instr[11:8] != 4'b1111) begin
                    alu_sel      = instr[11:8];
                    data_writer = 16'd2;
                end
                else begin // overwrite cmp with sub, but dw=0;
                    alu_sel      = 4'b0010; 
                    // write_enable = 1'b0;
                end
                rd           = instr[7:4];
                rs           = instr[3:0];
            end
            // JMP instruction group
            4'b0010: begin
                jmp_enable = 
                    (instr[11:8] == 4'b0000) ||                         // jmp
                    (instr[11:8] == 4'b0001 && flags[0] == 1'b1) ||     // jz
                    (instr[11:8] == 4'b0010 && flags[1] == 1'b1) ||     // jn
                    (instr[11:8] == 4'b0011 && flags[2] == 1'b1) ||     // jc
                    (instr[11:8] == 4'b0100 && flags[3] == 1'b1) ||     // jv
                    (instr[11:8] == 4'b0101 && flags[0] == 1'b0) ||     // jnz
                    (instr[11:8] == 4'b0110 && flags[1] == 1'b0) ||     // jnn
                    (instr[11:8] == 4'b0111 && flags[2] == 1'b0) ||     // jnc
                    (instr[11:8] == 4'b1000 && flags[3] == 1'b0);       // jnv
                jmp_addr[7:0] = instr[7:0];
            end
            // MOV instruction
            4'b0011: begin
                data_writer     = 16'd1;
                rd              = instr[11:8];
                write_data[7:0] = instr[7:0];
            end
        endcase
    end
endmodule