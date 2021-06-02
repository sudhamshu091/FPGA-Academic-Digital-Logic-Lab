module part5(SW,HEX3,HEX2,HEX1,HEX0);
input [9:0] SW;
output [6:0] HEX0,HEX1,HEX2,HEX3;

wire [1:0] D;

mux mux0(SW[9:8],SW[7:0],D);
b2d_ssd0 H0(D[1:0],HEX0);
b2d_ssd1 H1(D[1:0],HEX1);
b2d_ssd2 H2(D[1:0],HEX2);
b2d_ssd3 H3(D[1:0],HEX3);

endmodule

module mux(S, I, D);
input [7:0] I;
input [1:0] S;
output [1:0]D;
reg [1:0]D;
 assign D[1:0] = S[1]? (S[0]? I[7:6] : I[5:4]) : (S[0] ? I[3:2] : I[1:0]);
endmodule

module b2d_ssd0 (X, SSD);
  input [1:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[1]&X[0]) | (X[1]&X[0]);
         assign SSD[1] = (X[1]&~X[0]);
         assign SSD[2] = (X[1]&~X[0]);
         assign SSD[3] = (X[1]&X[0]);
         assign SSD[4] = (X[1]&X[0]);
         assign SSD[5] = (~X[1]&X[0]) | (X[1]&X[0]);
         assign SSD[6] = (~X[1]&~X[0]) | (X[1]&X[0]);

endmodule

module b2d_ssd1 (X, SSD);
  input [1:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[1]&~X[0]) | (X[1]&~X[0]);
         assign SSD[1] = (X[1]&X[0]);
         assign SSD[2] = (X[1]&X[0]);
         assign SSD[3] = (~X[1]&~X[0]);
         assign SSD[4] = (~X[1]&~X[0]);
         assign SSD[5] = (~X[1]&~X[0]) | (X[1]&~X[0]);
         assign SSD[6] = (~X[1]&X[0]) | (~X[1]&~X[0]);

endmodule

module b2d_ssd2 (X, SSD);
  input [1:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[1]&X[0]) | (X[1]&X[0]);
         assign SSD[1] = (~X[1]&~X[0]);
         assign SSD[2] = (~X[1]&~X[0]);
         assign SSD[3] = (~X[1]&X[0]);
         assign SSD[4] = (~X[1]&X[0]);
         assign SSD[5] = (~X[1]&X[0]) | (X[1]&X[0]);
         assign SSD[6] = (~X[1]&X[0]) | (X[1]&~X[0]);

endmodule

module b2d_ssd3 (X, SSD);
  input [1:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[1]&~X[0]) | (X[1]&~X[0]);
         assign SSD[1] = (~X[1]&X[0]);
         assign SSD[2] = (~X[1]&X[0]);
         assign SSD[3] = (X[1]&~X[0]);
         assign SSD[4] = (X[1]&~X[0]);
         assign SSD[5] = (X[1]&~X[0]) | (~X[1]&~X[0]);
         assign SSD[6] = (X[1]&~X[0]) | (X[1]&X[0]);

endmodule
