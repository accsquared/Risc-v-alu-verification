module control (
    input  logic [6:0] opcode,
    output logic       reg_write,
    output logic       alu_src,
    output logic       mem_to_reg,
    output logic       mem_read,
    output logic       mem_write,
    output logic       branch,
    output logic [1:0] alu_op
);
    always_comb begin
        case (opcode)
            7'b0110011: begin 
                reg_write   = 1;
                alu_src     = 0;
                mem_to_reg  = 0;
                mem_read    = 0;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 2; 
            end
            7'b0010011: begin 
                reg_write   = 1;
                alu_src     = 1;
                mem_to_reg  = 0;
                mem_read    = 0;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 2;
            end
            7'b0000011: begin 
                reg_write   = 1;
                alu_src     = 1;
                mem_to_reg  = 1;
                mem_read    = 1;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 0;
            end
            7'b0100011: begin 
                reg_write   = 0;
                alu_src     = 1;
                mem_to_reg  = 0; 
                mem_read    = 0;
                mem_write   = 1;
                branch      = 0;
                alu_op      = 0;
            end
            7'b1100011: begin 
                reg_write   = 0;
                alu_src     = 0;
                mem_to_reg  = 0; 
                mem_read    = 0;
                mem_write   = 0;
                branch      = 1;
                alu_op      = 1;
            end
            default: begin
                reg_write   = 0;
                alu_src     = 0;
                mem_to_reg  = 0;
                mem_read    = 0;
                mem_write   = 0;
                branch      = 0;
                alu_op      = 0;
            end
        endcase
    end
endmodule
