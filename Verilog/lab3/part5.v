module part5(SW,KEY,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0,LEDR);
input [1:0] KEY;
input [8:0]SW;
output[6:0] HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;
output [0:0] LEDR;

reg [7:0] A;
reg [7:0] B;

wire [7:0] S;
wire C0;
 
always@(posedge KEY[1] or posedge KEY[0])
begin
if (KEY[0] == 1'b1) begin
A[7:0] = 8'b0;
B[7:0] = 8'b0;
end
else begin
if(~SW[8])
begin
A = SW[7:0];
end
else
begin
B = SW[7:0];
end
end
end

adder_8bit A0(A[7:0],B[7:0],S,C0);

hex_ssd H1(A[7:4],HEX1);
hex_ssd H0(A[3:0],HEX0);
hex_ssd H3(B[7:4],HEX3);
hex_ssd H2(B[3:0],HEX2);
hex_ssd H5(S[7:4],HEX5);
hex_ssd H4(S[3:0],HEX4);

assign LEDR[0] = C0;

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

module fulladder(X, Y, Ci, S, Co);
  input X, Y, Ci;
  output S, Co;
  wire w1,w2,w3;

  xor G1(w1, X, Y);
  xor G2(S, w1, Ci);
  and G3(w2, w1, Ci);
  and G4(w3, X, Y);
  or G5(Co, w2, w3);
endmodule

module adder_8bit(X, Y, S, Co);
 input [7:0] X, Y;
 output [7:0] S;
 output Co;
 wire w1, w2, w3, w4, w5, w6, w7;

 fulladder u1(X[0], Y[0], 1'b0, S[0], w1);
 fulladder u2(X[1], Y[1], w1, S[1], w2);
 fulladder u3(X[2], Y[2], w2, S[2], w3);
 fulladder u4(X[3], Y[3], w3, S[3], w4);
 fulladder u5(X[4], Y[4], w4, S[4], w5);
 fulladder u6(X[5], Y[5], w5, S[5], w6);
 fulladder u7(X[6], Y[6], w6, S[6], w7);
 fulladder u8(X[7], Y[7], w7, S[7], Co);
endmodule
