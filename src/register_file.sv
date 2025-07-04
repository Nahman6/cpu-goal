module register_file (
    input clk,
    input [2:0] read_reg1,
    input [2:0] read_reg2,
    input [2:0] write_reg,
    input [7:0] write_data,
    input reg_write_en,
    output [7:0] read_data1,
    output [7:0] read_data2
);

    reg [7:0] registers [7:0]; // 8 registers (R0–R7)

    initial begin
        registers[2] = 8'd5;   // R2 = 5
        registers[3] = 8'd7;   // R3 = 7
    end

    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    always @(posedge clk) begin
        if (reg_write_en)
            registers[write_reg] <= write_data;
    end
endmodule
