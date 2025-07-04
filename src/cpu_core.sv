// === ALU MODULE ===
module alu (
    input [7:0] a,
    input [7:0] b,
    input [2:0] alu_op,
    output reg [7:0] result
);
    always @(*) begin
        case (alu_op)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a & b;
            default: result = 8'd0;
        endcase
    end
endmodule

// === CONTROL UNIT ===
module control_unit (
    input [5:0] opcode,
    output reg alu_src,
    output reg reg_write_en,
    output reg mem_read,
    output reg mem_write,
    output reg [2:0] alu_op
);
    always @(*) begin
        alu_src = 0;
        reg_write_en = 0;
        mem_read = 0;
        mem_write = 0;
        alu_op = 3'b000;

        case (opcode)
            6'b000000: begin alu_src = 0; reg_write_en = 1; alu_op = 3'b000; end
            6'b000001: begin alu_src = 0; reg_write_en = 1; alu_op = 3'b001; end
            6'b000010: begin alu_src = 0; reg_write_en = 1; alu_op = 3'b010; end
            default:   begin alu_src = 0; reg_write_en = 0; alu_op = 3'b000; end
        endcase
    end
endmodule

// === REGISTER FILE ===
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
    reg [7:0] registers [0:7];

initial begin
    registers[0] = 8'd0;
    registers[1] = 8'd0;
    registers[2] = 8'd5;
    registers[3] = 8'd7;
    registers[4] = 8'd0;
    registers[5] = 8'd0;
    registers[6] = 8'd0;
    registers[7] = 8'd0;
end


    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];


always @(*) begin
    $display("Reading: R%0d = %d, R%0d = %d", read_reg1, read_data1, read_reg2, read_data2);
end

  
    always @(posedge clk) begin
        if (reg_write_en)
            registers[write_reg] <= write_data;
    end
endmodule

// === CPU CORE ===
module cpu_core (
    input [15:0] instruction,
    input clk,
    output [7:0] result_out,
    output [2:0] dbg_rs,
    output [2:0] dbg_rt,
    output [7:0] dbg_data1,
    output [7:0] dbg_data2,
    output [2:0] dbg_alu_op
);

    wire [5:0] opcode = instruction[15:10];
    wire [2:0] rs = instruction[9:7];
    wire [2:0] rt = instruction[6:4];
    wire [2:0] rd = instruction[3:1];

    wire [2:0] alu_op;
    wire alu_src, reg_write_en, mem_read, mem_write;
    wire [7:0] reg_data1, reg_data2, alu_result;
    wire [7:0] alu_in_b = alu_src ? 8'd0 : reg_data2;


    control_unit CU (
        .opcode(opcode),
        .alu_src(alu_src),
        .reg_write_en(reg_write_en),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_op(alu_op)
    );

    register_file RF (
        .clk(clk),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(rd),
        .write_data(alu_result),
        .reg_write_en(reg_write_en),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    alu ALU (
        .a(reg_data1),
        .b(alu_in_b),
        .alu_op(alu_op),
        .result(alu_result)
    );

    assign result_out = alu_result;
  assign dbg_rs = rs;
assign dbg_rt = rt;
assign dbg_data1 = reg_data1;
assign dbg_data2 = reg_data2;
assign dbg_alu_op = alu_op;

endmodule


