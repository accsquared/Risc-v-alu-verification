module alu(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [2:0] alu_control,
    output logic [31:0] result
);
    always_comb begin
        case (alu_control)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a & b;
            3'b011: result = a | b;
            default: result = 32'hDEADBEEF;
        endcase
    end
endmodule
