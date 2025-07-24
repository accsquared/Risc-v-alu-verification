module alu_control (
    input  logic [1:0] alu_op,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] alu_control
);
    always_comb begin
        case (alu_op)
            2'b00: alu_control = 4'b0010; 
            2'b01: alu_control = 4'b0110; 
            2'b10: begin 
                case (funct3)
                    3'b000: alu_control = (funct7 == 7'b0100000) ? 4'b0110 : 4'b0010; 
                    3'b111: alu_control = 4'b0000; // and
                    3'b110: alu_control = 4'b0001; // or
                    3'b100: alu_control = 4'b0011; // xor
                    3'b010: alu_control = 4'b0100; 
                    default: alu_control = 4'b1111; 
                endcase
            end
            default: alu_control = 4'b1111; 
        endcase
    end
endmodule
