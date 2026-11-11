module PC_ff (input logic clk,
				  input logic rst, 
				  input logic[31:0] PC_p,
              output logic[31:0] PC_out);
    always_ff @(posedge clk) begin
	     PC_out <= rst ? 32'h0 : PC_p;
    end
endmodule