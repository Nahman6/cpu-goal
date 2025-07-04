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
            6'b000000: begin // ADD
                alu_src = 0;
                reg_write_en = 1;
                alu_op = 3'b000;
            end
            6'b000001: begin // SUB
                alu_src = 0;
                reg_write_en = 1;
                alu_op = 3'b001;
            end
            6'b000010: begin // AND
                alu_src = 0;
                reg_write_en = 1;
                alu_op = 3'b010;
            end
            default: begin
                alu_src = 0;
                reg_write_en = 0;
                mem_read = 0;
                mem_write = 0;
                alu_op = 3'b000;
            end
        endcase
    end
endmodule
