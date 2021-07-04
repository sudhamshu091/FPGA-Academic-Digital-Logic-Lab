module part6(SW,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
input [9:0] SW;
output [6:0] HEX5,HEX4,HEX0,HEX1,HEX2,HEX3;
 
wire [2:0] D;
 
mux mux0(SW[9:7],D);
b2d_ssd0 H0(D[2:0],HEX0);
b2d_ssd1 H1(D[2:0],HEX1);
b2d_ssd2 H2(D[2:0],HEX2);
b2d_ssd3 H3(D[2:0],HEX3);
b2d_ssd4 H4(D[2:0],HEX4);
b2d_ssd5 H5(D[2:0],HEX5);

endmodule

module mux(S, D);
input [2:0] S;
output [2:0]D;
reg [2:0]D;
always @ (S)
begin
 case(S)
 3'd0: D=3'd3;
 3'd1: D=3'd1;
 3'd2: D=3'd0;
 3'd3: D=3'd5;
 3'd4: D=3'd4;
 3'd5: D=3'd2;
endcase
end
endmodule

module b2d_ssd0 (X, SSD);
  input [2:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (X[2]&~X[1]&X[0]);
         assign SSD[1] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&~X[0]);
         assign SSD[2] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&~X[0]);
         assign SSD[3] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&X[0]);
         assign SSD[4] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&X[0]);
         assign SSD[5] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]);
         assign SSD[6] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]);

endmodule

module b2d_ssd1 (X, SSD);
  input [2:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[2]&X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&~X[0]);
         assign SSD[1] = (~X[2]&X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&X[0]);
         assign SSD[2] = (~X[2]&X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&X[0]);
         assign SSD[3] = (~X[2]&X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&~X[1]&~X[0]);
         assign SSD[4] = (~X[2]&X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&~X[1]&~X[0]);
         assign SSD[5] = (~X[2]&X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&~X[0]);
         assign SSD[6] = (~X[2]&X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]);

endmodule

module b2d_ssd2 (X, SSD);
  input [2:0] X;
  output [6:0] SSD;

         assign SSD[0] = (X[2]&~X[1]&X[0]) | (X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (~X[2]&~X[1]&X[0]);
         assign SSD[1] = (X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (~X[2]&~X[1]&~X[0]);
         assign SSD[2] = (X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (~X[2]&~X[1]&~X[0]);
         assign SSD[3] = (X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (~X[2]&~X[1]&X[0]);
         assign SSD[4] = (X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (~X[2]&~X[1]&X[0]);
         assign SSD[5] = (X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (~X[2]&~X[1]&X[0]) | (X[2]&~X[1]&X[0]);
         assign SSD[6] = (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&X[1]&X[0]) | (X[2]&~X[1]&~X[0]);

endmodule

module b2d_ssd3 (X, SSD);
  input [2:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]);
         assign SSD[1] = (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&~X[1]&X[0]);
         assign SSD[2] = (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&~X[1]&X[0]);
         assign SSD[3] = (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]);
         assign SSD[4] = (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]);
         assign SSD[5] = (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&~X[1]&~X[0]);
         assign SSD[6] = (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (~X[2]&X[1]&X[0]);

endmodule

module b2d_ssd4 (X, SSD);
  input [2:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]);
         assign SSD[1] = (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]);
         assign SSD[2] = (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]);
         assign SSD[3] = (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]);
         assign SSD[4] = (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]);
         assign SSD[5] = (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]) | (~X[2]&~X[1]&X[0]);
         assign SSD[6] = (~X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]) | (X[2]&~X[1]&X[0]);

endmodule

module b2d_ssd5 (X, SSD);
  input [2:0] X;
  output [6:0] SSD;

         assign SSD[0] = (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&~X[0]) | (X[2]&~X[1]&~X[0]);
         assign SSD[1] = (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]);
         assign SSD[2] = (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]) | (~X[2]&X[1]&X[0]);
         assign SSD[3] = (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]) | (X[2]&~X[1]&~X[0]);
         assign SSD[4] = (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]) | (X[2]&~X[1]&~X[0]);
         assign SSD[5] = (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]) | (X[2]&~X[1]&~X[0]) | (~X[2]&X[1]&~X[0]);
         assign SSD[6] = (~X[2]&~X[1]&~X[0]) | (~X[2]&~X[1]&X[0]) | (X[2]&~X[1]&~X[0]) | (X[2]&~X[1]&X[0]);

endmodule
