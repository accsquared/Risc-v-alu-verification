module regfil (
    input  logic  clk,
    input  logic  we,
    input  logic [4:0] rs1_addr,
    input  logic [4:0] rs2_addr,
    input  logic [4:0] rd_addr,
    input  logic [31:0] rd_data,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);

    logic [31:0] regs [31:0];

    // reading logic
    assign rs1_data = (rs1_addr == 5'd0) ? 32'd0 : regs[rs1_addr];
    assign rs2_data = (rs2_addr == 5'd0) ? 32'd0 : regs[rs2_addr];

    // writting logic
    always_ff @(posedge clk) begin
        if (we && rd_addr != 5'd0)
            regs[rd_addr] <= rd_data;

    end 

endmodule