`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2019 06:55:07 PM
// Design Name: 
// Module Name: encoder_add_sub
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


module encoder_add_sub(input clk,
input enc_a,
input enc_b,
input enc_sw,
input enc_btn,
input enc_b_db,
input enc_a_db,
input enc_a_rise,
output reg [3:0] enc_byte
);
    
        always @(posedge clk)
        begin
            if (enc_a_rise);
            if (!enc_b_db)
                begin
                enc_byte <= enc_byte-1;
                /*if(enc_byte[11:0] == 12'b000000000000) enc_byte <= enc_byte-12'b011010100111;
                else if(enc_byte[7:0] == 8'b00000000) enc_byte <= enc_byte-8'b10100111;
                else if(enc_byte[3:0] == 4'b0000) enc_byte <= enc_byte-4'b0111;*/
                if(enc_byte==4'b0000) enc_byte<=4'b1001;
                end
            else
                begin
                enc_byte <= enc_byte+1;
                /*if(enc_byte[11:0] == 12'b100101011001) enc_byte <= enc_byte+12'b011010100111; 
                else if(enc_byte[7:0] == 8'b01011001) enc_byte <= enc_byte+8'b10100111;
                else if(enc_byte[3:0] == 4'b1001) enc_byte <= enc_byte+3'b111;*/
                if(enc_byte==4'b1001) enc_byte<=4'b0000;
                end    
        end
endmodule
