`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2019 12:08:31 PM
// Design Name: 
// Module Name: bcdto7segment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcdto7segment(
    input [3:0] x,
    output [6:0] seg
    );
    
    reg [6:0] seg;
    
    always @ (x)
    begin
        
        case(x)
            4'b0000: seg = 7'b1000000;
            4'b0001: seg = 7'b1111001;
            4'b0010: seg = 7'b0100100;
            4'b0011: seg = 7'b0110000;
            4'b0100: seg = 7'b0011001;
            4'b0101: seg = 7'b0010010;
            4'b0110: seg = 7'b0000010;
            4'b0111: seg = 7'b1111000;
            4'b1000: seg = 7'b0000000;
            4'b1001: seg = 7'b0010000;
            default: seg = 7'b1000000;
        endcase
   end
   
/*input [3:0] x;
output [6:0] seg;
//output [7:0] an;

assign
    seg[0] = (~x[3]&~x[2]&~x[1]&x[0]) | (~x[3]&x[2]&~x[1]&~x[0]),
    seg[1] = (~x[3]&x[2]&~x[1]&x[0]) | (~x[3]&x[2]&x[1]&~x[0]),
    seg[2] = (~x[3]&~x[2]&x[1]&~x[0]),
    seg[3] = (~x[3]&~x[2]&~x[1]&x[0]) | (~x[3]&x[2]&~x[1]&~x[0]) | (~x[3]&x[2]&x[1]&x[0]),
    seg[4] = (~x[3]&~x[2]&~x[1]&x[0]) | (~x[3]&~x[2]&x[1]&x[0]) | (~x[3]&x[2]&~x[1]&~x[0]) | (~x[3]&x[2]&~x[1]&x[0]) | (~x[3]&x[2]&x[1]&x[0]),
    seg[5] = (~x[3]&~x[2]&~x[1]&x[0]) | (~x[3]&~x[2]&x[1]&~x[0]) | (~x[3]&~x[2]&x[1]&x[0]) | (~x[3]&x[2]&x[1]&x[0]),
    seg[6] = (~x[3]&~x[2]&~x[1]&~x[0]) | (~x[3]&~x[2]&~x[1]&x[0]) | (~x[3]&x[2]&x[1]&x[0]);
    
    //an = 8'b11111110;
  
    
    
    /*an[0] = 8'b00000000,
    an[1] = 8'b11111111,
    an[2] = 8'b11111111,
    an[3] = 8'b11111111,
    an[4] = 8'b11111111,
    an[5] = 8'b11111111,
    an[6] = 8'b11111111,
    an[7] = 8'b11111111;*/
    
endmodule

