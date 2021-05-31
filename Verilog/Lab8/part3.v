module part3 (SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
  input [9:0] SW;
  input [0:0] KEY;
  output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

  wire [3:0] data;
  wire [4:0] address;
  wire wren, clock;
  wire [3:0] q;


  assign data = SW[3:0];
  assign wren = SW[9];
  assign clock = KEY[0];
  assign address = SW[8:4];

	reg [3:0] memory_array [31:0];
  always @(posedge clock) begin
    if (wren)
      memory_array[address] = data;
  end

	assign q = memory_array[address];  // this line is not working in desim , maybe a bug.

  hex_ssd H5 ({1'b0,1'b0,1'b0,address[4]}, HEX5);
  hex_ssd H4 (address[3:0], HEX4);
  hex_ssd H3 (0, HEX3);
  hex_ssd H2 (0, HEX2);
  hex_ssd H1 (data[3:0], HEX1);
  hex_ssd H0 (q[3:0], HEX0);
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
