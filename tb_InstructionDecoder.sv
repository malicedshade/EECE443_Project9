`timescale 1ns/1ps
module tb_InstructionFetch;

    logic clk, rst, PC_src;
	 logic [31:0] br_addr;
    logic [31:0] instr;

    InstructionFetch uut (.clk(clk), .rst(rst), .br_addr(br_addr), .PC_src(PC_src), .instr(instr));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        PC_src = 0;
        br_addr = 32'h42;
		  
		  #10 rst = 0;
		  #100 $finish;
    end

    initial begin
        $monitor("Time=%0t PC=%h Instruction=%h", $time, uut.pc_o, instr);
    end

endmodule