`timescale 1ns/1ps

module tb_SignExtend;

    logic [23:0] Instr;
    logic [1:0] ImmSrc;
    logic [31:0] ExtImm;

    SignExtend uut (.Instr(Instr), .ImmSrc(ImmSrc), .ExtImm(ExtImm));

    initial begin
        Instr = 24'h0000A5;
        ImmSrc = 2'b00;
        #10;

        Instr = 24'h000ABC;
        ImmSrc = 2'b01;
        #10;

        Instr = 24'hFFFFFF;
        ImmSrc = 2'b10;
        #10;

        $stop;
    end

endmodule
