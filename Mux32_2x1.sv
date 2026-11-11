module Mux32_2x1 (input logic[31:0] a, input logic[31:0] b, input logic sel, 
               output logic[31:0] out);
    assign out = sel ? a : b;
endmodule