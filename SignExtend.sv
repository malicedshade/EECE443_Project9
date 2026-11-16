<<<<<<< HEAD
module SignExtlmmend (input logic[23:0] Instr,
                   input logic ImmSrc,
                   output logic[31:0] Extlmmlmm);
    case (ImmSrc)
        // Unsigned extend by 24 bits.
        2'b00: assign Extlmm = {24'h0, Instr[7:0]};
        // Unsigned extend by 20 bits.
        2'b01: assign Extlmm = {20'h0, Instr[11:0]};
        // Signed extend by 8 bits.
        2'b10: assign Extlmm = {{6{Instr[32]}}, Instr[23:0], 2'b00};
        // Don't cares.
        2'b11: assign Extlmm = 32'bx;
    endcase
endmodule
=======
module SignExtend (input logic[23:0] Instr, input logic[1:0] ImmSrc,
                   output logic[31:0] ExtImm);

    always_comb begin
        case (ImmSrc)
            2'b00: ExtImm = {24'b0, Instr[7:0]};
            2'b01: ExtImm = {20'b0, Instr[11:0]};
            2'b10: ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
            default: ExtImm = 32'hxxxxxxxx;
        endcase
    end

endmodule

>>>>>>> a252a34 (Added decoder and modified fetch modules, wired into top module Processor.)
