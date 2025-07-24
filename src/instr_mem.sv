module instr_mem (
    input logic [31:0] addr,
    output logic [31:0] instr_mem
);

    logic [31:0] memory [0:255];

    //loading program from file
    intial begin
       $readmemh("mem/program.mem", memory);
    end 

    always_comb begin
        instr = memory[addr[9:2]];
    end
endmodule