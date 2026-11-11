module MemAdder (input logic[31:0] incr, input logic[31:0] addr_in, 
                 output logic[31:0] addr_out);
    assign addr_out = addr_in + incr;
endmodule