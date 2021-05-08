//Not completed
module part2 (SW, HEX0, HEX1);
  input [9:0] SW;
  output [6:0] HEX0, HEX1;

  wire z;
  wire [3:0] M, A;
  assign A[3] = 0;

  comparator C0 (SW[5:0], z, code);
  circuitA A0 (SW[3:0], A[2:0]);
  mux_4bit_2to1 M0 (z, SW[3:0], A, M);
  circuitB B0 (code, HEX0);
  b2d_7seg S0 (M, HEX1);
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

module comparator (V, z, code);
  input [5:0] V;
  output z;
  output reg [2:0] code;

always @(V) begin
if (V[5] & V[4] & V[3] & V[2]) code = 3'd6;
else if (V[5] & V[4] & ~V[3] & ~V[2] & V[1]) code = 3'd5;
else if (V[5] & ~V[4] & V[3]) code = 3'd4;
else if (~V[5] & V[4] & V[3] & V[2] & V[1]) code = 3'd3;
else if (V[5] & ~V[4] & V[3]) code = 3'd2;
else code = 3'd1;
end

assign z = (V[3] & (V[2] | V[1]));
endmodule

module circuitA (V, A);
  input [2:0] V;
  output [2:0] A;

  assign A[0] = V[0];
  assign A[1] = ~V[1];
  assign A[2] = (V[2] & V[1]);
endmodule

module circuitB (code, SSD);
  input [2:0] code;
  output reg [6:0] SSD;

  always @(code)
  case(code)
  3'd1:begin SSD = code; end
  3'd2:begin SSD = 7'b0100100; end
  3'd3:begin SSD = 7'b0110000; end
  3'd4:begin SSD = 7'b0011001; end
  3'd5:begin SSD = 7'b0010010; end
  3'd6:begin SSD = 7'b0000010; end
  endcase
endmodule

module mux_4bit_2to1 (S, U, V, M);
  input S;
  input [3:0] U, V;
  output [3:0] M;

  assign M = ({4{~S}} & U) | ({4{S}} & V);
endmodule
