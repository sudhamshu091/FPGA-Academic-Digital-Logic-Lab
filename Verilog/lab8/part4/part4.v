module part4 (SW, KEY,CLOCK_50, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
  input [9:0] SW;
  input CLOCK_50;
  input [0:0] KEY;
  output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

  wire [3:0] data, q;
  wire rst;
  wire [4:0] rdaddress, wraddress;
  wire wren, clock;

  assign data = SW[3:0];
  assign wren = SW[9];
  assign rst = KEY[0];
  assign wraddress = SW[8:4];

  counter_modk c1(CLOCK_50, KEY[0], rdaddress);
  defparam c1.n = 15;
  defparam c1.k = 99;
  ram32x4 R0 (CLOCK_50, data, rdaddress, wraddress, wren, q);

  hex_ssd H5 ({1'b0,1'b0,1'b0,wraddress[4]}, HEX5);
  hex_ssd H4 (wraddress[3:0], HEX4);
  hex_ssd H3 ({1'b0,1'b0,1'b0,rdaddress[4]}, HEX3);
  hex_ssd H2 (rdaddress[3:0], HEX2);
  hex_ssd H1 (data[3:0], HEX1);
endmodule

module counter_modk(clock, reset, Q);
  parameter n;
  parameter k;

  input clock, reset;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  always @(posedge clock)
  begin
    if (~reset)
      Q = 0;
    else begin
      Q = Q + 1;
      if (Q == k-1)
        Q = 0;
    end
  end
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
