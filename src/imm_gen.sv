 module imm_gen (
    input  logic [31:0] instr,
    output logic [31:0] imm
);
    logic [6:0] opcode; //extract

    assign opcode = instr[6:0];

    always_comb begin
        case (opcode)
            7'b0010011,  
            7'b0000011,  
            7'b1100111:  
                imm = {{20{instr[31]}}, instr[31:20]};

            7'b0100011: 
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            7'b1100011:  
                imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

            7'b0110111,  
            7'b0010111:  
                imm = {instr[31:12], 12'b0};

            7'b1101111:  
                imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

            default:
                imm = 32'd0; // default to zero
        endcase
    end
endmodule
