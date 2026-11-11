module InstructionMem (input logic [31:0] a,
                       output logic [31:0] rd);
    logic[31:0] mem[0:255];

    initial begin
        mem[0] = 32'hE04F000F;
        mem[1] = 32'hE280300A;
    end

    assign rd = mem[a[9:2]];
endmodule