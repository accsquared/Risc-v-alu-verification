module top (
    input logic clk,
    input logic reset
);
    //   Counter 
    logic [31:0] pc, next_pc;
    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc_out(pc)
    );

    //  Instruction Memory 
    logic [31:0] instr;
    instr_mem imem (
        .addr(pc),
        .instr(instr)
    );

    //  Instruction Fields 
    logic [6:0]  opcode   = instr[6:0];
    logic [4:0]  rd       = instr[11:7];
    logic [2:0]  funct3   = instr[14:12];
    logic [4:0]  rs1      = instr[19:15];
    logic [4:0]  rs2      = instr[24:20];
    logic [6:0]  funct7   = instr[31:25];

    //  Control Signals 
    logic reg_write, alu_src, mem_to_reg, mem_read, mem_write, branch;
    logic [1:0] alu_op;

    control control_unit (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op)
    );

    //  Immediate Generation 
    logic [31:0] imm_out;
    imm_gen imm_gen_inst (
        .instr(instr),
        .imm(imm_out)
    );

    //  Register File 
    logic [31:0] rs1_data, rs2_data, write_data;
    regfile rf (
        .clk(clk),
        .we(reg_write),
        .rs1_addr(rs1),
        .rs2_addr(rs2),
        .rd_addr(rd),
        .rd_data(write_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

        //  The ALU 
    logic [31:0] alu_in2, alu_result;
    logic [3:0] alu_control;

    // Control
    alu_control alu_ctl (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)
    );

    assign alu_in2 = alu_src ? imm_out : rs2_data;

    alu alu_inst (
        .a(rs1_data),
        .b(alu_in2),
        .alu_control(alu_control),
        .result(alu_result)
    );


    // Updated Logic 
    logic pc_src;
    assign pc_src = branch && (alu_result == 0);
    assign next_pc = pc_src ? (pc + imm_out) : (pc + 4);

    // Write Back
    assign write_data = alu_result; // later add mem_to_reg logic if you add data_mem
endmodule
