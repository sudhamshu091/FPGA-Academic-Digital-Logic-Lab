module part1 (SW, LEDR, KEY, HEX5,HEX4,HEX3, HEX2, HEX1, HEX0);
  input [7:0] SW;
  input [1:0] KEY;
  output [9:0] LEDR;
  output [6:0] HEX5,HEX4,HEX3, HEX2, HEX1, HEX0;

  wire [3:0] wireS, C;

  reg [3:0] A, B, S;
  reg overflow;
  reg carry;

  always @ (negedge KEY[1] or negedge KEY[0]) begin
    if (KEY[1] == 0) begin
      A = SW[7:4];
      B = SW[3:0];
      S = wireS;
      overflow = C[3] ^ C[2];
      carry = C[3];

    end
    if (KEY[0] == 0) begin
      A = 4'b0000;
      B = 4'b0000;
      S = 4'b0000;
      overflow = 0;
      carry = 0;
    end
  end

  fulladder_4bit FA (A, B, 1'b0, wireS, C);

  assign LEDR[3:0] = wireS[3:0];
  assign LEDR[8] = carry;
  assign LEDR[9] = overflow;


  hex_ssd H2 (A[3:0], HEX2);
  hex_ssd H1 (B[3:0], HEX1);
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

module fulladder_4bit (A, B, ci, S, CO);
  input [3:0] A, B;
  input ci;
  output [3:0] S;
  output [4:1] CO;

  fulladder A0 (A[0], B[0], ci, S[0], CO[1]);
  fulladder A1 (A[1], B[1], CO[1], S[1], CO[2]);
  fulladder A2 (A[2], B[2], CO[2], S[2], CO[3]);
  fulladder A3 (A[3], B[3], CO[3], S[3], CO[4]);
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
