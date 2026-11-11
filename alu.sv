module ALU (input logic[31:0] a, input logic[31:0] b, input logic[3:0] ALUControl,
				output logic[31:0] result, output logic[3:0] ALUFlags);

	logic N;
	logic Z;
	logic C;
	logic V;
	logic[31:0] R;
	
	always_comb begin
		logic[32:0] adder;
		
		adder = 33'h0;
		R = 32'h0;
		C = 1'b0;
		V = 1'b0;
	
		case (ALUControl)
			4'b0000: R = a & b;
			4'b0001: R = a | b;
			4'b0010: R = a ^ b;

			4'b0011: begin
				// R = a + b;
				adder = {1'b0, a} + {1'b0, b};
				R = adder[31:0];
				C = adder[32];
				V = ~(a[31] ^ b[31]) & (a[31] ^ adder[31]); // check if the signs don't match
			end

			// Shift A left by the # created by bits 0 to 4 of B.
			4'b0100: R = a << b[4:0];

			// Shift A right by the # created by bits 0 to 4 of B.
			4'b0101: R = a >> b[4:0];

			4'b0110: begin
				R = $signed(a) >>> b[4:0];
			end

			4'b1011: begin
				adder = {1'b0, a} - {1'b0, b};
				R = adder[31:0];
				C = ~adder[32];
				V = (a[31] ^ b[31]) & (a[31] ^ adder[31]);  // check if the signs don't match
			end

			default: begin
				R = 32'bx;
				C = 1'bx;
				V = 1'bx;
			end
		endcase

		N = R[31];
		Z = ~|R;
		result = R;
		ALUFlags = {N, Z, C, V};
	end
endmodule