module alu (
    input [7:0] a,
    input [7:0] b,
    input [2:0] alu_op,
    output reg [7:0] result
);

    always @(*) begin
        case (alu_op)
            3'b000: result = a + b;   // ADD
            3'b001: result = a - b;   // SUB
            3'b010: result = a & b;   // AND
            default: result = 8'd0;   // 0
        endcase
    end
endmodule
