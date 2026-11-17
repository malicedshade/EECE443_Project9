/*
    InstructionDecoder

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
    input  logic[31:0] PC_plus4,
    input  logic[1:0]  RegSrc,
    input  logic       RegWrite,
    input  logic[1:0]  ImmSrc,
    input  logic       ALUSrc,
    output logic[31:0] SrcA,
    output logic[31:0] SrcB,
    output logic[31:0] WriteData
);
    logic[31:0] RD1_out;
    logic[31:0] RD2_out;
    logic[31:0] PCPlus8_out;
    logic[3:0]  RA1_in;
    logic[3:0]  RA2_in;
    logic[31:0] ExtImm;

    Mux4_2x1 instr19_16x15  (.a(4'd15), .b(Instr[19:16]),
                             .sel(RegSrc[0]), 
                             .out(RA1_in));
    Mux4_2x1 instr3_0x15_12 (.a(Instr[15:12]), .b(Instr[3:0]),
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
    Mux32_2x1 srcB_m (.a(ExtImm), .b(RD2_out), 
                      .sel(ALUSrc), 
                      .out(SrcB));
endmodule