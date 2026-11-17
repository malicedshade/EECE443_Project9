module InstructionFetch (input logic clk, 
						 input logic rst, 
						 input logic[31:0] br_addr, 
						 input logic PC_src,
                   output logic[31:0] instr,
                   output logic[31:0] PC_plus4);
    logic[31:0] pc_next;
    logic[31:0] pc_o;

    PC_ff          PC    (.clk(clk),    .rst(rst),      .PC_p(pc_next), .PC_out(pc_o));
    Mux32_2x1      mux   (.a(br_addr),  .b(PC_plus4),   .sel(PC_src),   .out(pc_next));
    Adder32        adder (.incr(32'd4), .addr_in(pc_o), .addr_out(PC_plus4));
    InstructionMem imem  (.a(pc_o), .rd(instr));
endmodule