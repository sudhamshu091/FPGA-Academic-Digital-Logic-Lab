// To run this on desim make changes in lines 110,135,160
// Keep KEY[0] and KEY[1] in 0, change KEY[0] to 1 and wait till all SSD's becomes reset, then make it 0, change KEY[1] to 1, clock will start counting.
module part3(CLOCK_50,KEY,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
input [1:0] KEY;
input CLOCK_50;
output [6:0] HEX5,HEX4,HEX3,HEX2,HEX1,HEX0;

wire [0:0]cout0;
wire [0:0]cout1;
wire [0:0]cout2;
wire [6:0] Q0;
wire [5:0] Q1;
wire [5:0] Q2;
wire [7:0]bcd0;
wire [7:0]bcd1;
wire [7:0]bcd2;

counter_clock0 C0(CLOCK_50, KEY[0], cout0);
counter_clock1 C1(CLOCK_50, KEY[0], cout1);
counter_clock2 C2(CLOCK_50, KEY[0], cout2);

counter_modk C3(cout0[0], KEY[1], Q0);
defparam C3.n = 7;
defparam C3.k = 100;

counter_modk C4(cout1[0], KEY[1], Q1);
defparam C4.n = 6;
defparam C4.k = 60;

counter_modk C5(cout2[0], KEY[1], Q2);
defparam C5.n = 6;
defparam C5.k = 60;

bin2bcd0 B0(Q0[6:0],bcd0);
bin2bcd1 B1(Q1[5:0],bcd1);
bin2bcd1 B2(Q2[5:0],bcd2);

b2d_7seg H0(bcd0[3:0],HEX0);
b2d_7seg H1(bcd0[7:4],HEX1);
b2d_7seg H2(bcd1[3:0],HEX2);
b2d_7seg H3(bcd1[7:4],HEX3);
b2d_7seg H4(bcd2[3:0],HEX4);
b2d_7seg H5(bcd2[7:4],HEX5);

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


module bin2bcd0(binary,bcd);
    parameter n = 7;
    input [n-1:0] binary;
    output reg [(n-1)+(n-4)/3:0] bcd;

  integer i,j;

  always @(binary)
  begin
    for(i = 0; i <= (n-1)+(n-4)/3; i = i+1)
    bcd[i] = 0;
    bcd[n-1:0] = binary;
    for(i = 0; i <= n-4; i = i+1)
      for(j = 0; j <= i/3; j = j+1)
        if (bcd[n-i+4*j -: 4] > 4)
          bcd[n-i+4*j -: 4] = bcd[n-i+4*j -: 4] + 4'd3;
  end
endmodule

module bin2bcd1(binary,bcd);
    parameter n = 6;
    input [n-1:0] binary;
    output reg [(n+1)+(n-4)/3:0] bcd;

  integer i,j;

  always @(binary)
  begin
    for(i = 0; i <= (n+1)+(n-4)/3; i = i+1)
    bcd[i] = 0;
    bcd[n-1:0] = binary;
    for(i = 0; i <= n-4; i = i+1)
      for(j = 0; j <= i/3; j = j+1)
        if (bcd[n-i+4*j -: 4] > 4)
          bcd[n-i+4*j -: 4] = bcd[n-i+4*j -: 4] + 4'd3;
  end
endmodule

module counter_clock0(clock, reset, cout);
    input clock, reset;
    output  cout;

    reg [15:0] count;
    reg  cout;


    always @ (posedge clock)
    begin
       if (~reset) begin
           if(count== 500000) begin   // Change 500000 to 50
              count = 0;
              cout = cout + 1;
           end else begin
              count = count + 1;
              cout = cout;
           end
       end else begin
          count =0;
          cout = 0;
       end
    end
endmodule

module counter_clock1(clock, reset, cout);
    input clock, reset;
    output  cout;

    reg [24:0] count;
    reg  cout;


    always @ (posedge clock)
    begin
       if (~reset) begin
           if(count== 50000000) begin // change 50000000 to 5000
              count = 0;
              cout = cout + 1;
           end else begin
              count = count + 1;
              cout = cout;
           end
       end else begin
          count =0;
          cout = 0;
       end
    end
endmodule

module counter_clock2(clock, reset, cout);
    input clock, reset;
    output  cout;

    reg [31:0] count;
    reg  cout;


    always @ (posedge clock)
    begin
       if (~reset) begin
           if(count== 3000000000) begin // change 3000000000 to 30000
              count = 0;
              cout = cout + 1;
           end else begin
              count = count + 1;
              cout = cout;
           end
       end else begin
          count =0;
          cout = 0;
       end
    end
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
