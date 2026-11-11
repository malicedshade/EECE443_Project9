/*
    InstructionDecoder

    InstrRd is the instruction from the InstructionFetch.

*/
module InstructionDecoder (
    input logic clk,
    input logic[31:0] InstrRd,
    input logic PC_plus4,
    input logic[1:0] RegSrc,
    input logic RegWrite,
    input logic ImmSrc,
    input logic ALUSrc,
    output logic SrcA,
    output logic SrcB,
    output logic WriteData
);
    /// TODO: Hook up.
    wire pc_plus8;
    wire RD2_out;

    Mux4_2x1 instr19_16_15 (.a(InstrRd[19:16]), .b(4'hF), 
                            .sel(RegSrc[0]), 
                            .out(/* RA1 */));
    Mux4_2x1 instr3_0_15_12 (.a(InstrRd[3:0]), .b(InstrRd[15:12]), 
                            .sel(RegSrc[1]), 
                            .out(/* RA2 */));
    MemAdder pc_adder    (.incr(32'h4), 
                          .addr_in(PC_plus4), 
                          .addr_out(pc_plus8));

    RegisterFile rf (.clk(clk),
                     .RA1(),
                     .RA2(),
                     .R15(),
                     .RegWrite(),
                     .A3(),
                     .WD3(),
                     .RD1(),
                     .RD2(RD2_out));
    SignExtend extend (.Instr(),
                       .ImmSrc(),
                       .Extlmm());
    
    // FIXME: Don't think we use the flags yet so the adder has extra stuff.
    // I stole it from earlier project may need to simplify it.
    ALU adder (/* RD2_out*/);
endmodule