`timescale 1ns / 1ps


module bcd_actual(
    output reg[7:0] ani,
    output bcdVal,
    output refresh,
    input [3:0] bit0,bit1,bit2,bit3,bit4,bit5,bit6,bit7,
    input clk
    );
    
    reg[3:0] bcdVal;
    reg[2:0] refresh;
    
    always @(posedge clk)
            begin
            
            if(refresh == 3'b000)
                begin
                ani <= 8'b11111110;
                bcdVal <= bit0;
                refresh <= 3'b001;
                end
           if(refresh == 3'b001)
                begin
                ani <= 8'b11111101;
                bcdVal <= bit1;
                refresh <= 3'b010;
                end
           if(refresh == 3'b010)
                begin
                ani <= 8'b11111011;
                bcdVal <= bit2;
                refresh <= 3'b011;
                end
           if(refresh == 3'b011)
                begin
                ani <= 8'b11110111;
                bcdVal <= bit3;
                refresh <= 3'b100;
                end
           if(refresh == 3'b100)
                begin
                ani <= 8'b11101111;
                bcdVal <= bit4;
                refresh <= 3'b101;
                end
           if(refresh == 3'b101)
                begin
                ani <= 8'b11011111;
                bcdVal <= bit5;
                refresh <= 3'b110;
                end
           if(refresh == 3'b110)
                begin
                ani <= 8'b10111111;
                bcdVal <= bit6;
                refresh <= 3'b111;
                end
           if(refresh == 3'b111)
                begin
                ani <= 8'b01111111;
                bcdVal <= bit7;
                refresh <= 3'b000;
                end
           end
endmodule
