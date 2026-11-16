module Processor (input  logic       clk,
                  input  logic       rst,
                  input  logic       PC_src,
                  input  logic[31:0] br_addr,
                  input  logic[1:0]  RegSrc,
                  input  logic       RegWrite,
                  input  logic[1:0]  ImmSrc,
                  input  logic       ALUSrc,
                  output logic[31:0] WriteData);
    logic[31:0] PC_plus4;
    logic[31:0] instr_RD;
    logic[31:0] SrcA;
    logic[31:0] SrcB;

    InstructionFetch   fetcher (.clk(clk),
                                .rst(rst),
                                .br_addr(br_addr),
                                .PC_src(PC_src),
                                .instr(instr_RD),
                                .PC_plus4(PC_plus4));
    InstructionDecoder decoder (.clk(clk),
                                .Instr(instr_RD),
                                .Result(32'b0),
                                .PC_plus4(PC_plus4),
                                .RegSrc(RegSrc),
                                .RegWrite(RegWrite),
                                .ImmSrc(ImmSrc),
                                .ALUSrc(ALUSrc),
                                .SrcA(SrcA),
                                .SrcB(SrcB),
                                .WriteData(WriteData));
    
endmodule