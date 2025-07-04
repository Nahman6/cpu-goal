module cpu_core_tb;
    reg [15:0] instruction;
    reg clk;
    wire [7:0] result_out;
wire [2:0] rs, rt, alu_op;
wire [7:0] data1, data2;

cpu_core uut (
    .instruction(instruction),
    .clk(clk),
    .result_out(result_out),
    .dbg_rs(rs),
    .dbg_rt(rt),
    .dbg_data1(data1),
    .dbg_data2(data2),
    .dbg_alu_op(alu_op)
);
    always #5 clk = ~clk;

    initial begin
        $display("Time |     Instruction     |  Result");
        $display("--------------------------------------");

        clk = 0;
        #20;

        instruction = 16'b000000_010_011_001_0; // ADD R1, R2, R3
        #15;
        $display("%4t | %b | %d", $time, instruction, result_out);

        instruction = 16'b000001_011_010_100_0; // SUB R4, R3, R2
        #20;
        $display("%4t | %b | %d", $time, instruction, result_out);

        instruction = 16'b000010_010_011_101_0; // AND R5, R2, R3
        #20;
        $display("%4t | %b | %d", $time, instruction, result_out);


        $finish;

        $display("rs = %d, rt = %d, rd = %d", uut.rs, uut.rt, uut.rd);
        $display("reg_data1 = %d, reg_data2 = %d", uut.reg_data1, uut.reg_data2);
        $display("alu_op = %b, alu_result = %d", uut.alu_op, uut.result_out);

    end
endmodule