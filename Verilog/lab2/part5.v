module part5 (SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	input [8:0] SW;
	output [8:0] LEDR;
	output [6:0] HEX0, HEX1, HEX3, HEX5;

	wire [3:0] A,B,S0,S1;
	wire [4:0] T0;
	wire c1;
	reg [4:0] Z0;
	reg c0;

	assign LEDR = SW;
	assign A = SW[7:4];
	assign B = SW[3:0];
	assign c1 = SW[8];

	assign T0 = A + B + c1;

	always @ (T0)
		begin
			if (T0 > 9)
				begin
					Z0 = 5'd10;			//or 5'b01010
					c0 = 1'd1;						//or 1'b1
				end
			else
				begin
					Z0 = 5'd0;			//or 5'b00000
					c0 = 1'd0;						//or 1'b0
				end
		end

	assign S0 = T0 - Z0;
	assign S1 = c0;


	b2d_7seg ssd0 (.X(S0),.SSD(HEX0));
	b2d_7seg ssd1 (.X(S1),.SSD(HEX1));
	b2d_7seg ssd2 (.X(B),.SSD(HEX3));
	b2d_7seg ssd3 (.X(A),.SSD(HEX5));

endmodule

module b2d_7seg (X, SSD);
  input [3:0] X;
  output [6:0] SSD;

assign  SSD[0] = (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0])|(~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  ~X[2] & ~X[1] & X[0]) ;
assign  SSD[1] = (~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);
assign  SSD[2] =  (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0])|(~X[3] & ~X[2] &  X[1] & ~X[0]);
assign  SSD[3] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);
assign  SSD[4] = ~((~X[2] & ~X[0]) | (X[1] & ~X[0]));
assign  SSD[5] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);
assign  SSD[6] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);

endmodule
