/* 
    Register File

    Writes are clocked. But Reads happen at any time.
    RA1 is the address of the first register operand.
    RA2 is the address of the second register operand.
    RA15 is special due to being a way to read the PC.
    WD3 is the data to write to the register specified by A3.
    A3 is what register to write data to from WD3.
    RegWrite controls if we can write WD3 to the register specified by A3.
    RD1 and RD2 read the data from the registers specified by RA1 and RA2 respectively.

    What's Rn, Rd, and Rm, and so on is specified by the specific instruction.
*/
module RegFile (
    input  logic       clk,
    input  logic[3:0]  RA1,
    input  logic[3:0]  RA2,
    input  logic[31:0] R15,
    input  logic       RegWrite,
    input  logic[3:0]  A3,
    input  logic[31:0] WD3,
    output logic[31:0] RD1,
    output logic[31:0] RD2
);

// R15 special from the muxes and not stored here.
logic[31:0] registers[0:14];

assign RD1 = registers[RA1];
assign RD2 = registers[RA2];

// Writes are clocked.
always_ff @( posedge clk ) begin
    if (RegWrite)
        registers[A3] <= WD3;
end
    
endmodule