module part4 (CLOCK_50,HEX3,HEX2,HEX1,HEX0);
  input CLOCK_50;
  output [6:0] HEX3,HEX2,HEX1,HEX0;

  wire [25:0] Q;
  wire [1:0] Q2;
  reg Clr, Clr2;

  counter_26bit C0 (CLOCK_50, Clr, Q);
  counter_4bit DISPLAY (Clr, Clr2, Q2);

  always @ (posedge CLOCK_50) begin
    Clr = (Q[25]&Q[24]&Q[23]&Q[22]&Q[21]&Q[20]&Q[19]&Q[18]&Q[17]&Q[16]&Q[15]&Q[14]&Q[13]&Q[12]&Q[11]&Q[10]&Q[9]&Q[8]&Q[7]&Q[6]&Q[5]&Q[4]&Q[3]&Q[2]&Q[1]&Q[0]);
  end

  always @ (posedge Clr) begin
    Clr2 = (Q[1]&~Q[0]);
  end

  b2d_ssd0 H0 (Q2[1:0], HEX0); // To visualize properly change Q2[1:0] to Q[15:14]
  b2d_ssd1 H1 (Q2[1:0], HEX1);
  b2d_ssd2 H2 (Q2[1:0], HEX2);
  b2d_ssd3 H3 (Q2[1:0], HEX3);

endmodule

module counter_26bit(clk, en, Q);
input clk,en;
output [25:0] Q;
reg [25:0] Qs;

always @(posedge clk)
begin
if(en)
 Qs = 0;
else if(~en)
 Qs = Qs + 1;
else
 Qs = 1;
end
assign Q = Qs;
endmodule

module counter_4bit(clk, en, Q);
input clk,en;
output [3:0] Q;
reg [3:0] Qs;

always @(posedge clk)
begin
if(en)
 Qs = 0;
else if (~en)
 Qs = Qs + 1;
else
 Qs = 1;
end
assign Q = Qs;
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
