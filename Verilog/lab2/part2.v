module part2 (SW, HEX0, HEX1);
  input [9:0] SW;
  output [6:0] HEX0, HEX1;

  wire z;
  wire [3:0] M, A;
  assign A[3] = 0;

  comparator C0 (SW[3:0], z);
  circuitA A0 (SW[3:0], A[2:0]);
  mux_4bit_2to1 M0 (z, SW[3:0], A, M);
  circuitB B0 (z, HEX1);
  b2d_7seg S0 (M, HEX0);
endmodule

module b2d_7seg (X, SSD);
  input [3:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  ~X[2] & ~X[1] & X[0]) ;
         assign SSD[1] = (~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]);
         assign SSD[2] =  (~X[3] & ~X[2] &  X[1] & ~X[0]);
         assign SSD[3] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]);
         assign SSD[4] = ~((~X[2] & ~X[0]) | (X[1] & ~X[0]));
         assign SSD[5] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]);
         assign SSD[6] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]);
endmodule

module comparator (V, z);
  input [3:0] V;
  output z;

  assign z = (V[3] & (V[2] | V[1]));
endmodule

module circuitA (V, A);
  input [2:0] V;
  output [2:0] A;

  assign A[0] = V[0];
  assign A[1] = ~V[1];
  assign A[2] = (V[2] & V[1]);
endmodule

module circuitB (z, SSD);
  input z;
  output [6:0] SSD;

  assign SSD[0] = z;
  assign SSD[2:1] = 2'b00;
  assign SSD[5:3] = {3{z}};
  assign SSD[6] = 1;
endmodule

module mux_4bit_2to1 (S, U, V, M);
  input S;
  input [3:0] U, V;
  output [3:0] M;

  assign M = ({4{~S}} & U) | ({4{S}} & V);
endmodule
