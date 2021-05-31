// Not complete
module part1(SW, KEY, LEDR);
	input [1:0] KEY, SW;
	output [9:0] LEDR;

	reg  z;
	reg [3:0] shifter;
	reg [3:0] State;
	wire [8:0] Y;

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

 state s1(State[3:0], Y);


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

module state (State, Y);
  input [3:0] State;
  output [8:0] Y;

	assign Y[0] = ~(~State[3] | ~State[2] |~State[1] |~State[0]);
	assign Y[1] = ~(~State[3] | ~State[2] |~State[1] |State[0]) ;
	assign Y[2] = ~(~State[3] | ~State[2] |State[1] |~State[0]) ;
	assign Y[3] = ~(~State[3] | ~State[2] |State[1] |State[0]) ;
	assign Y[4] = ~(~State[3] | State[2] |~State[1] |~State[0]) ;
	assign Y[5] = ~(~State[3] | State[2] |~State[1] |State[0]) ;
	assign Y[6] = ~(~State[3] | State[2] |State[1] |~State[0]) ;
	assign Y[7] = ~(~State[3] | State[2] |State[1] |State[0]) ;
	assign Y[8] = ~(State[3] | ~State[2] |~State[1] |~State[0]) ;
	endmodule
