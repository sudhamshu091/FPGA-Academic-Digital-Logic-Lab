module part6(SW,HEX5 ,HEX4,HEX3,HEX2,HEX1,HEX0);
input [9:0] SW; 
output [6:0]HEX5 ,HEX4,HEX3,HEX2,HEX1,HEX0;
wire [2:0] M5,M4,M3,M2,M1,M0;

mux_3bit_6to1  m5(SW[9:7],3'd0,3'd1,3'd2,3'd3,3'd4,3'd5,M5);
mux_3bit_6to1  m4(SW[9:7],3'd1,3'd2,3'd3,3'd4,3'd5,3'd0,M4);
mux_3bit_6to1  m3(SW[9:7],3'd2,3'd3,3'd4,3'd5,3'd0,3'd1,M3);
mux_3bit_6to1  m2(SW[9:7],3'd3,3'd4,3'd5,3'd0,3'd1,3'd2,M2);
mux_3bit_6to1  m1(SW[9:7],3'd4,3'd5,3'd0,3'd1,3'd2,3'd3,M1);
mux_3bit_6to1  m0(SW[9:7],3'd5,3'd0,3'd1,3'd2,3'd3,3'd4,M0);
char_7seg   h5(M5, HEX5);
char_7seg   h4(M4, HEX4);
char_7seg   h3(M3, HEX3);
char_7seg   h2(M2, HEX2);
char_7seg   h1(M1, HEX1);
char_7seg   h0(M0, HEX0);
endmodule

module char_7seg(sw,hex);
input [2:0]sw;
output [6:0]hex;

assign hex= (sw[2:0] == 3'b000 )? 7'b1111111:(sw[2:0]  == 3'b001 )?7'b1111111:(sw[2:0]  == 3'b010 )?7'b0100001:(sw[2:0]  == 3'b011 )?7'b0000110:(sw[2:0] == 3'b100) ?7'b1111001:7'b1000000;
endmodule

module mux_3bit_6to1(S, U, V, W, X, Y, Z, M);
input [2:0] S, U, V, W, X, Y,Z;
output [2:0] M;
assign M = (S== 3'b000 )? U:
           (S == 3'b001 )? V:
           (S == 3'b010 )? W:
           (S == 3'b011 )? X:
           (S == 3'b100 )? Y:Z;
endmodule
