`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 09:49:30 AM
// Design Name: 
// Module Name: Stopwatch
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


module Stopwatch(
    input clk, reset, modeSelect, Start, Stop,
    output reg ready, mode, 
    output wire[6:0] seg,
    output reg[7:0] an
    //inout ja_pin10_io,
    //inout ja_pin1_io,
    //inout ja_pin2_io,
    //inout ja_pin3_io,
    //inout ja_pin4_io,
    //inout ja_pin7_io,
    //inout ja_pin8_io,
    //inout ja_pin9_io,
    //input usb_uart_rxd,
    //output usb_uart_txd
    );
    
    wire[3:0] bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7;
    reg enable;
    reg[3:0] bit0rst, bit1rst, bit2rst, bit3rst, bit4rst, bit5rst, bit6rst, bit7rst;
    reg[3:0] bcdVal;
    reg[2:0] refresh;
    
    clk_wiz_0 cntrlClk(clk25MHz, 0, clk);
    clock_divider clkDiv(clk25MHz, clk1Hz, 1);
    clock_divider1 RefclkDiv(clk25MHz, clk500Hz, 1);
    clock_divider2 sourceClk(clk25MHz, clk10kHz, 1);
    
    //design_1_wrapper(ja_pin10_io, ja_pin1_io, ja_pin2_io, ja_pin3_io, ja_pin4_io, ja_pin7_io, 
    //                 ja_pin8_io, ja_pin9_io, reset, clk, usb_uart_rxd, usb_uart_txd);
    
    
    //counters    
     
    down_counter down7(clk10kHz, enable&dn1&dn2&dn3&dn4&dn5&dn6&dn7, reset, mode, bit7rst, bit7, dn8);
    down_counter down6(clk10kHz, enable&dn1&dn2&dn3&dn4&dn5&dn6, reset, mode, bit6rst, bit6, dn7);
    down_counter down5(clk10kHz, enable&dn1&dn2&dn3&dn4&dn5, reset, mode, bit5rst, bit5, dn6);
    down_counter down4(clk10kHz, enable&dn1&dn2&dn3&dn4, reset, mode, bit4rst, bit4, dn5);
    down_counter down3(clk10kHz, enable&dn1&dn2&dn3, reset, mode, bit3rst, bit3, dn4);
    down_counter down2(clk10kHz, enable&dn1&dn2, reset, mode, bit2rst, bit2, dn3);
    down_counter down1(clk10kHz, enable&dn1, reset, mode, bit1rst, bit1, dn2);
    down_counter down0(clk10kHz, enable, reset, mode, bit0rst, bit0, dn1);
    
    
    //ready light
    always @(posedge clk1Hz)
    begin
    if(~enable) ready <= ~ready;
    else ready <= 1'b0;
    end
    
    //mode selection
    always @(posedge clk25MHz)
    begin
    mode <= modeSelect;
    if(mode)
        begin
        if(Stop) enable = 1'b0;
        else if(Start) enable = 1'b1;
        bit0rst <= 4'b0000;
        bit1rst <= 4'b0000;
        bit2rst <= 4'b0000;
        bit3rst <= 4'b0000;
        bit4rst <= 4'b0000;
        bit5rst <= 4'b0000;
        bit6rst <= 4'b0000;
        bit7rst <= 4'b0000;
        end   
    else
        begin
        if(Stop) enable = 1'b0;
        else if(Start) enable = 1'b1;
        end
    end
    
    
    //refresh 7 segment display
    bcdto7segment(bcdVal[3:0], seg[6:0]);
    always @(posedge clk500Hz)
        begin
        
        if(refresh == 3'b000)
            begin
            an <= 8'b11111110;
            bcdVal <= bit0;
            refresh <= 3'b001;
            end
       if(refresh == 3'b001)
            begin
            an <= 8'b11111101;
            bcdVal <= bit1;
            refresh <= 3'b010;
            end
       if(refresh == 3'b010)
            begin
            an <= 8'b11111011;
            bcdVal <= bit2;
            refresh <= 3'b011;
            end
       if(refresh == 3'b011)
            begin
            an <= 8'b11110111;
            bcdVal <= bit3;
            refresh <= 3'b100;
            end
       if(refresh == 3'b100)
            begin
            an <= 8'b11101111;
            bcdVal <= bit4;
            refresh <= 3'b101;
            end
       if(refresh == 3'b101)
            begin
            an <= 8'b11011111;
            bcdVal <= bit5;
            refresh <= 3'b110;
            end
       if(refresh == 3'b110)
            begin
            an <= 8'b10111111;
            bcdVal <= bit6;
            refresh <= 3'b111;
            end
       if(refresh == 3'b111)
            begin
            an <= 8'b01111111;
            bcdVal <= bit7;
            refresh <= 3'b000;
            end
       end
    
    
endmodule
