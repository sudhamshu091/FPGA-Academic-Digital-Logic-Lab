//Not working
module part2(KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [0:0] KEY;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;

wire [15:0] hundredth_second;
wire [22:0] second;
wire [28:0] minute;

wire [6:0] count_hundredth_second;
wire [5:0] count_second;
wire [5:0] count_minute;

  counter_modk C1 (CLOCK_50, KEY[0], hundredth_second);
  defparam C1.n =16;
  defparam C1.k = 50000;

reg clr1;
always @(posedge CLOCK_50) begin
clr1 = (hundredth_second[15]&hundredth_second[14]&~hundredth_second[13]&~hundredth_second[12]&~hundredth_second[11]&~hundredth_second[10]&hundredth_second[9]&hundredth_second[8]&~hundredth_second[7]&hundredth_second[6]&~hundredth_second[5]&~hundredth_second[4]&hundredth_second[3]&hundredth_second[2]&hundredth_second[1]&hundredth_second[0]);
end

counter_modk0 C4 (clr1,KEY[0],count_hundredth_second);
defparam C4.n = 7;
defparam C4.k = 100;

  counter_modk C2 (CLOCK_50, KEY[0], second);
  defparam C2.n = 23;
  defparam C2.k = 5000000;

reg clr2;
always @(posedge CLOCK_50) begin
clr2 = (second[22]&~second[21]&~second[20]&second[19]&second[18]&~second[17]&~second[16]&~second[15]&second[14]&~second[13]&~second[12]&second[11]&~second[10]&second[9]&second[8]&~second[7]&second[6]&~second[5]&~second[4]&~second[3]&~second[2]&~second[1]&~second[0]);
end
counter_modk0 C5 (clr2,KEY[0],count_second);
defparam C5.n = 6;
defparam C5.k = 60;

  counter_modk C3 (CLOCK_50, KEY[0], minute);
  defparam C3.n = 29;
  defparam C3.k = 300000000;

reg clr3;
always @(posedge CLOCK_50) begin
clr3 = (minute[28]&~minute[27]&~minute[26]&~minute[25]&minute[24]&minute[23]&minute[22]&minute[21]&~minute[20]&~minute[19]&~minute[18]&~minute[17]&minute[16]&minute[15]&~minute[14]&minute[13]&~minute[12]&~minute[11]&~minute[10]&minute[9]&minute[8]&~minute[7]&~minute[6]&~minute[5]&~minute[4]&~minute[3]&~minute[2]&~minute[1]&~minute[0]);
end
counter_modk0 C6 (CLOCK_50,KEY[0],count_minute);
defparam C6.n = 6;
defparam C6.k = 60;

wire [7:0] bcd1;
wire [6:0] bcd2;
wire [6:0] bcd3;
wire [7:0] bcd4;
wire [7:0] bcd5;

  bin2bcd0 B1(count_hundredth_second[6:0],bcd1);

  bin2bcd1 B2(count_second[5:0],bcd2);

  bin2bcd2 B3(count_minute[5:0],bcd3);



  assign bcd4[7:0] = {1'b0,bcd2};
  assign bcd5[7:0] = {1'b0,bcd3};

b2d_7seg H0(bcd1[3:0],HEX0);
b2d_7seg H1(bcd1[7:4],HEX1);
b2d_7seg H2(bcd2[3:0],HEX2);
b2d_7seg H3(bcd4[7:4],HEX3);
b2d_7seg H4(bcd3[3:0],HEX4);
b2d_7seg H5(bcd5[7:4],HEX5);

endmodule

module counter_modk(clock, reset, Q);
  parameter n;
  parameter k;

  input clock, reset;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  always @(posedge clock or negedge reset)
  begin
    if (~reset)
      Q <= 1'd0;
    else begin
      Q <= Q + 1'b1;
      if (Q == k-1)
        Q <= 1'd0;
    end
  end
endmodule

module counter_modk0(clock, reset, Q);
  parameter n;
  parameter k;

  input clock, reset;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  always @(posedge clock)
  begin
    if (~reset)
      Q = 0;
    else if (reset) begin
      Q = Q + 1;
      if (Q == k-1)
        Q = 0;
    end
    else
    Q = 1;
  end
endmodule


module bin2bcd0(binary,bcd);
    parameter l = 7;
    input [l-1:0] binary;
    output reg [l+(l-4)/3:0] bcd;

  integer i,j;

  always @(binary)
  begin
    for(i = 0; i <= l+(l-4)/3; i = i+1)
    bcd[i] = 0;
    bcd[l-1:0] = binary;
    for(i = 0; i <= l-4; i = i+1)
      for(j = 0; j <= i/3; j = j+1)
        if (bcd[l-i+4*j -: 4] > 4)
          bcd[l-i+4*j -: 4] = bcd[l-i+4*j -: 4] + 4'd3;
  end
endmodule

module bin2bcd1(binary,bcd);
    parameter l = 6;
    input [l-1:0] binary;
    output reg [l+(l-4)/3:0] bcd;

  integer i,j;

  always @(binary)
  begin
    for(i = 0; i <= l+(l-4)/3; i = i+1)
    bcd[i] = 0;
    bcd[l-1:0] = binary;
    for(i = 0; i <= l-4; i = i+1)
      for(j = 0; j <= i/3; j = j+1)
        if (bcd[l-i+4*j -: 4] > 4)
          bcd[l-i+4*j -: 4] = bcd[l-i+4*j -: 4] + 4'd3;
  end
endmodule

module bin2bcd2(binary,bcd);
    parameter l = 6;
    input [l-1:0] binary;
    output reg [l+(l-4)/3:0] bcd;

  integer i,j;

  always @(binary)
  begin
    for(i = 0; i <= l+(l-4)/3; i = i+1)
    bcd[i] = 0;
    bcd[l-1:0] = binary;
    for(i = 0; i <= l-4; i = i+1)
      for(j = 0; j <= i/3; j = j+1)
        if (bcd[l-i+4*j -: 4] > 4)
          bcd[l-i+4*j -: 4] = bcd[l-i+4*j -: 4] + 4'd3;
  end
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
