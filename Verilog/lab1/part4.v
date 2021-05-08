module part4 (SW, HEX0);
    input [1:0] SW;
    output reg [6:0] HEX0;

    always @(SW)
        case (SW[1:0])
            2'b00: HEX0 = 7'b0100001;
            2'b01: HEX0 = 7'b0000110;
            2'b10: HEX0 = 7'b1111001;
            2'b11: HEX0 = 7'b1000000;
        endcase
endmodule
