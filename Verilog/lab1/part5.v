module part5 (SW, HEX0,HEX1,HEX2,HEX3);
	input [9:0] SW;		// toggle switches
	output [6:0] HEX0;	// 7-seg displays
  	output [6:0] HEX1;
        output [6:0] HEX2;
        output [6:0] HEX3;

	wire  M0,M1,M2,M3;

	// module mux_2bit_4to1 (S, U, V, W, X, M);
   mux_2bit_4to1 mux3 (SW[9:8], SW[7:6], SW[5:4], SW[3:2], SW[1:0], M0);
   mux_2bit_4to1 mux2 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], SW[7:6], M1);
   mux_2bit_4to1 mux1 (SW[9:8], SW[3:2], SW[1:0], SW[7:6], SW[5:4], M2);
   mux_2bit_4to1 mux0 (SW[9:8], SW[1:0], SW[7:6], SW[5:4], SW[3:2], M3);
	// module char_7seg (C, Display);
    char_7seg H0(M0,HEX0);
    char_7seg H1(M1,HEX1);
    char_7seg H2(M2,HEX2);
    char_7seg H3(M3,HEX3);

endmodule


module mux_2bit_4to1 (S,U,V,W,X,M);
	input [1:0]S, U, V, W, X;
	output [1:0]M;
	assign M[1:0] = (~S[1] & ~S[0] & U[1:0]) | (~S[1] & S[0] & V[1:0]) | (S[1] & ~S[0] & W[1:0]) | (S[1] & S[0] & X[1:0]);
endmodule

module char_7seg (X, Display);
	input [2:0] X;
	output [6:0] Display;


       assign SSD[0] = (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  ~X[2] & ~X[1] & X[0]) ;
       assign SSD[1] = (~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]);
       assign SSD[2] =  (~X[3] & ~X[2] &  X[1] & ~X[0]);
       assign SSD[3] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]);
       assign SSD[4] = ~((~X[2] & ~X[0]) | (X[1] & ~X[0]));
       assign SSD[5] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]);
       assign SSD[6] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]);
endmodule
