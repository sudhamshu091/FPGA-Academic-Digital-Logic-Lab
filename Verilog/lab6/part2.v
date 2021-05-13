module part2 (SW, LEDR, KEY, HEX3, HEX2, HEX1, HEX0);
  input [7:0] SW;
  input [2:0] KEY;
  output [9:0] LEDR;
  output [6:0] HEX3, HEX2, HEX1, HEX0;

  wire [7:0] wireS, C;

  reg [7:0] A, S;
  reg overflow;
  reg carry;

  always @ (negedge KEY[1] or negedge KEY[0]) begin
    if (KEY[1] == 0) begin
      A = SW[7:0];
      S = wireS;
      overflow = C[7] ^ C[6];
      carry = C[7];

    end
    if (KEY[0] == 0) begin
      A = 8'b00000000;
      S = 8'b00000000;
      overflow = 0;
      carry = 0;
    end
  end

  fulladder_8bit FA (A, S^{8{KEY[2]}}, 1'b0, wireS, C);

  assign LEDR[7:0] = wireS[7:0];
  assign LEDR[8] = carry;
  assign LEDR[9] = overflow;

  hex_ssd H3 (A[7:4], HEX3);
  hex_ssd H2 (A[3:0], HEX2);
  hex_ssd H1 (wireS[7:4], HEX1);
  hex_ssd H0 (wireS[3:0], HEX0);

endmodule

module fulladder (a, b, ci, s, co);
  input a, b, ci;
  output co, s;

  wire d;

  assign d = a ^ b;
  assign s = d ^ ci;
  assign co = (b & ~d) | (d & ci);
endmodule

module fulladder_8bit (A,B, ci, S, CO);
  input [7:0] A, B;
  input ci;
  output [7:0] S;
  output [8:1] CO;

  fulladder A0 (A[0], B[0], ci, S[0], CO[1]);
  fulladder A1 (A[1], B[1], CO[1], S[1], CO[2]);
  fulladder A2 (A[2], B[2], CO[2], S[2], CO[3]);
  fulladder A3 (A[3], B[3], CO[3], S[3], CO[4]);
  fulladder A4 (A[4], B[4], CO[4], S[4], CO[5]);
  fulladder A5 (A[5], B[5], CO[5], S[5], CO[6]);
  fulladder A6 (A[6], B[6], CO[6], S[6], CO[7]);
  fulladder A7 (A[7], B[7], CO[7], S[7], CO[8]);

endmodule

module hex_ssd (X, SSD);
  input [3:0] X;
  output [6:0] SSD;

  assign SSD[0] = (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  ~X[2] & ~X[1] & X[0]) ;
  assign SSD[1] = (~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & X[1] & X[0]);
  assign SSD[2] =  (~X[3] & ~X[2] &  X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & X[1] & X[0]);
  assign SSD[3] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]) | (X[3] &  ~X[2] & X[1] & ~X[0]) | (X[3] & X[2] & X[1] & X[0]);
  assign SSD[4] = (X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & X[2] & X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & ~X[1] & X[0]);
  assign SSD[5] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]);
  assign SSD[6] = (~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & X[0]);
endmodule
