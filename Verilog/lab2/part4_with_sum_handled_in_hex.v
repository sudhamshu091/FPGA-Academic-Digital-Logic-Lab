module part4 (SW, LEDR, HEX3, HEX2, HEX1, HEX0);
  input [8:0] SW;
  output [4:0] LEDR;
  output [6:0] HEX3, HEX2, HEX1, HEX0;
  wire s1, s2;

  b2d_7seg C0 (SW[3:0], HEX3);
  b2d_7seg C1 (SW[7:4], HEX2);

  wire c1, c2, c3;
  wire [4:0] S;

  fulladder A0 (SW[0], SW[4], SW[8], S[0], c1);
  fulladder A1 (SW[1], SW[5], c1, S[1], c2);
  fulladder A2 (SW[2], SW[6], c2, S[2], c3);
  fulladder A3 (SW[3], SW[7], c3, S[3], S[4]);

  assign LEDR[4:0] = S[4:0];

  wire z,en;
  wire [3:0] A, M;

  comparator9 C2 (S[4:0], z);
  circuitA A4 (S[3:0], A);
  mux_4bit_2to1 M0 (z, S[3:0], A, M);
  comparator19 comp19 (S[4:0], en);
  circuitB B0 (en, z, HEX1);
  b2d_7seg0 S0 (~en, M, HEX0);

endmodule

module b2d_7seg0 (en,X, SSD);
  input [3:0] X;
  output [6:0] SSD;
  reg [6:0] SSD;
  input en;

always @ (*)
if (en) begin
  SSD[0] = (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0])|(~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  ~X[2] & ~X[1] & X[0]) ;
  SSD[1] = (~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);
  SSD[2] =  (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0])|(~X[3] & ~X[2] &  X[1] & ~X[0]);
  SSD[3] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);
  SSD[4] = ~((~X[2] & ~X[0]) | (X[1] & ~X[0]));
  SSD[5] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);
  SSD[6] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] &  ~X[2] & X[1] & X[0]) | (X[3] &  X[2] & ~X[1] & ~X[0]) | (X[3] &  X[2] & ~X[1] & X[0]) | (X[3] &  X[2] & X[1] & ~X[0]) | (X[3] &  X[2] & X[1] & X[0]);
end
else begin
SSD[6:0] = 7'b1000000;
end

endmodule

module comparator9 (V, A);
  input [4:0] V;
  output A;

  assign A = V[4] | ((V[3] & V[2]) | (V[3] & V[1]));
endmodule

module circuitA (V, A);
  input [3:0] V;
  output [3:0] A;

  assign A[0] = V[0];
  assign A[1] = ~V[1];
  assign A[2] = (~V[3] & ~V[1]) | (V[2] & V[1]);
  assign A[3] = (~V[3] & V[1]);
endmodule

module circuitB (en,z, SSD);
  input z,en;
  output [6:0] SSD;
  reg [6:0] SSD;

always @(*)
if (~en & z) begin
SSD[6:0] = 7'b1111001;
end
else begin
SSD[6:0] = 7'b1000000;
end
endmodule

module mux_4bit_2to1 (S, U, V, M);
  input S;
  input [3:0] U, V;
  output [3:0] M;

  assign M = ({4{~S}} & U) | ({4{S}} & V);
endmodule

module fulladder (a, b, cin, s, cout);
  input a, b, cin;
  output cout, s;

  wire d;

  assign d = a ^ b;
  assign s = d ^ cin;
  assign cout = (b & ~d) | (d & cin);
endmodule

module comparator19(V,A);
input [4:0]V;
output A;

assign A = (V[4]&(V[3]|V[2]));
endmodule

