module Mux4_2x1 (input logic[3:0] a, input logic[3:0] b, input logic sel, 
               output logic[3:0] out);
    assign out = sel ? a : b;
endmodule