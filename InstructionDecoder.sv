/*
    InstructionDecoder

<<<<<<< HEAD
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
=======
    ========== INPUTS ==========
    Instr is the instruction from the InstructionFetch.
    Result is the result of operations from later modules.
    PC_plus4 is the next instruction address.

    ========== CONTROLLER SIGNALS ==========
    RegSrc is the selector signal for the RA1 and RA2 signals.
    RegWrite is the register file write enable signal.
    ImmSrc tells the Extender how to operate.
    ALUSrc is the selector signal for the SrcB mux.

    ========== OUTPUTS ==========
    SrcA and SrcB feed into the ALU module.
    WriteData feeds to an output mux.
*/
module InstructionDecoder (
    input  logic       clk,
    input  logic[31:0] Instr,
    input  logic[31:0] Result,
    input  logic       PC_plus4,
    input  logic[1:0]  RegSrc,
    input  logic       RegWrite,
    input  logic[1:0]  ImmSrc,
    input  logic       ALUSrc,
    output logic       SrcA,
    output logic       SrcB,
    output logic       WriteData
);
    logic[31:0] RD1_out;
    logic[31:0] RD2_out;
    logic[31:0] PCPlus8_out;
    logic[3:0]  RA1_in;
    logic[3:0]  RA2_in;
    logic[31:0] ExtImm;

    Mux4_2x1 instr19_16x15  (.a(Instr[19:16]), .b(4'd15), 
                             .sel(RegSrc[0]), 
                             .out(RA1_in));
    Mux4_2x1 instr3_0x15_12 (.a(Instr[3:0]), .b(Instr[15:12]), 
                             .sel(RegSrc[1]), 
                             .out(RA2_in));
    Adder32 PCPlus8         (.incr(32'd4),
                             .addr_in(PC_plus4), 
                             .addr_out(PCPlus8_out));

    RegFile rf (.clk(clk),
                .RA1(RA1_in),
                .RA2(RA2_in),
                .R15(PCPlus8_out),
                .RegWrite(RegWrite),
                .A3(Instr[15:12]),
                .WD3(Result),
                .RD1(RD1_out),
                .RD2(RD2_out));
    SignExtend extend (.Instr(Instr[23:0]),
                       .ImmSrc(ImmSrc),
                       .ExtImm(ExtImm));

    assign SrcA      = RD1_out;
    assign WriteData = RD2_out;
    Mux32_2x1 srcB_m (.a(RD2_out), .b(ExtImm), 
                      .sel(ALUSrc), 
                      .out(SrcB));
>>>>>>> a252a34 (Added decoder and modified fetch modules, wired into top module Processor.)
endmodule