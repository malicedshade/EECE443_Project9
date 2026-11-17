`timescale 1ns/1ps
module tb_InstructionDecoder;

    logic       clk, rst, PC_src, regWrite, ALUSrc;
    logic[1:0]  regSrc, immSrc;
    logic[31:0] result, writeData;

    Processor uut (.clk(clk),
                   .rst(rst),
                   .PC_src(PC_src),
                   .br_addr(result),
                   .RegSrc(regSrc),
                   .RegWrite(regWrite),
                   .ImmSrc(immSrc),
                   .ALUSrc(ALUSrc),
                   .WriteData(writeData));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        PC_src = 0;
        regWrite = 1;
        ALUSrc = 0;
        regSrc = 2'b00;
        immSrc = 2'b00;
        result = 32'h42; // Random value, it's unused.
		  
		  #10 rst = 0;
		  #100 $finish;
    end

    always @(posedge clk) begin
        $display("Time=%0t PC=%h INSTR=%h \n\tRA1_In=%d RA2_In=%d \n\tRD1_Out=%h Rd2_Out=%h \n\tWriteData=%h", 
                 $time, uut.fetcher.pc_o, uut.fetcher.instr,
                 uut.decoder.RA1_in, uut.decoder.RA2_in,
                 uut.decoder.RD1_out, uut.decoder.RD2_out, 
                 writeData);
    end

endmodule