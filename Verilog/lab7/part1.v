module part1(SW, KEY, LEDR);

	input [1:0] KEY, SW;
	output [9:0] LEDR;

	reg  z;
	reg [3:0] shifter;
	reg [8:0] Y, State;

	always @(posedge KEY[0] or posedge SW[0]) begin
		if (SW[0]) begin
			z <= 1'b0;
			shifter <= 4'b0101;
		end
		else begin
			if ((shifter == 4'b0000)|(shifter == 4'b1111))
				z <= 1'b1;
			else
				z <= 1'b0;
			shifter[3:0] <= { shifter[2:0] , SW[1] };
		end
	end

	parameter A=0, B=1, C=2, D=3, E=4, F=5, G=6, H=7, I=8;
	always @ (State) begin
		case(State)
			A: Y = 9'b000000001;
			B: Y = 9'b000000010;
			C: Y = 9'b000000100;
			D: Y = 9'b000001000;
			E: Y = 9'b000010000;
			F: Y = 9'b000100000;
			G: Y = 9'b001000000;
			H: Y = 9'b010000000;
			I: Y = 9'b100000000;
			default: Y = 9'b000000000;
		endcase
	end

	always @(posedge KEY[0] or posedge SW[0]) begin
		if (SW[0]) begin
			State = A;
		end
		else begin
			case(State)
				A:
					if (SW[1])
						State = F;
					else
						State = B;
				B:
					if (SW[1])
						State = F;
					else
						State = C;
				C:
					if (SW[1])
						State = F;
					else
						State = D;
				D:
					if (SW[1])
						State = F;
					else
						State = E;
				E:
					if (SW[1])
						State = F;
					else
						State = E;
				F:
					if (SW[1])
						State = G;
					else
						State = B;
				G:
					if (SW[1])
						State = H;
					else
						State = B;
				H:
					if (SW[1])
						State = I;
					else
						State = B;
				I:
					if (SW[1])
						State = I;
					else
						State = B;
			endcase
		end
	end

	assign LEDR[9] = z;
	assign LEDR[8:0] = Y;
endmodule
