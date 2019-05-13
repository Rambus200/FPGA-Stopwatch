`timescale 1ns / 1ps

module Stopwatch
#(
    parameter default_ms_limit = 100000,
    parameter ms_limit = default_ms_limit
    )
(
    input clk, reset, modeSelect, Start, Stop,
    output reg ready, mode, 
    output wire[6:0] seg,
    output reg [7:0] an,
    input enc_a,
    input enc_b,
    input enc_sw,
    input enc_btn,
    input SelectFast,
    output [15:2] LED
    );
    
    debounce
        #(
          .width(17),
          .bounce_limit(ms_limit*3)
          )
      debounce
        (
         .clk(clk),
         .switch_in({enc_a,enc_b,enc_sw,enc_btn,
             btn,switch}),
         .switch_out({enc_a_db,enc_b_db,enc_sw_db,enc_btn_db,
              btn_db,switch_db}),
         .switch_rise({enc_a_rise,enc_b_rise,enc_sw_rise,enc_btn_rise,
               btn_rise,switch_rise}),
         .switch_fall({enc_a_fall,enc_b_fall,enc_sw_fall,enc_btn_fall,
               btn_fall,switch_fall})
         );
         
    //reg [3:0] enc_byte = 0;
    //Mark Place
    
   
    always@(posedge clk)
    begin
        
    end
    
    wire[3:0] bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7;
    reg enable;
    reg[3:0] bit0rst, bit1rst, bit2rst, bit3rst, bit4rst, bit5rst, bit6rst, bit7rst;
    reg[3:0] bcdVal;
    reg[2:0] refresh;
    reg [3:0] enc_byte;
    wire clk10kHz_innovation,clk50kHz;
    
    clk_wiz_0 cntrlClk(clk25MHz, 0, clk);
    clock_divider clkDiv(clk25MHz, clk1Hz, 1);
    clock_divider1 RefclkDiv(clk25MHz, clk500Hz, 1);
    clock_divider2 sourceClk(clk25MHz, clk10kHz, 1);
    clock_divider3 switchClk(clk25MHz, clk50kHz, 1);
    
    assign clk10kHz_innovation = (clk10kHz & ~SelectFast) | (clk50kHz & SelectFast);

    //counters     
    down_counter down7(clk10kHz_innovation, enable&dn1&dn2&dn3&dn4&dn5&dn6&dn7, reset, mode, bit7rst, bit7, dn8);
    down_counter down6(clk10kHz_innovation, enable&dn1&dn2&dn3&dn4&dn5&dn6, reset, mode, bit6rst, bit6, dn7);
    minuteCounter down5(clk10kHz_innovation, enable&dn1&dn2&dn3&dn4&dn5, reset, mode, bit5rst, bit5, dn6);
    down_counter down4(clk10kHz_innovation, enable&dn1&dn2&dn3&dn4, reset, mode, bit4rst, bit4, dn5);
    down_counter down3(clk10kHz_innovation, enable&dn1&dn2&dn3, reset, mode, bit3rst, bit3, dn4);
    down_counter down2(clk10kHz_innovation, enable&dn1&dn2, reset, mode, bit2rst, bit2, dn3);
    down_counter down1(clk10kHz_innovation, enable&dn1, reset, mode, bit1rst, bit1, dn2);
    down_counter down0(clk10kHz_innovation, enable, reset, mode, bit0rst, bit0, dn1);
    led_animator (bit2,bit3,LED,reset);
    
    encoder_add_sub(clk, enc_a, enc_b, enc_sw, enc_btn, enc_b_db, enc_a_db, enc_a_rise, enc_byte);
    
    
    //ready light
    always @(posedge clk1Hz)
    begin
    if(~enable) ready <= ~ready;
    else ready <= 1'b0;
    end
    
    //mode selection
    parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7;
    reg [3:0] state,nxtstate;
    always @(posedge clk25MHz)
    begin
    if(reset) enable = 1'b0;
    mode <= modeSelect;
    if(mode)//MODE True (countup) set bcd to 00000000
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
           
    else//MODE false (countdwn) enable encoder
        begin
        if(Stop) enable = 1'b0;
        else if(Start) enable = 1'b1;
                if(enc_sw)
                begin
                case(state)
                s0:nxtstate<=s1;
                s1:nxtstate<=s2;
                s2:nxtstate<=s3;
                s3:nxtstate<=s4;
                s4:nxtstate<=s5;
                s5:nxtstate<=s6;
                s6:nxtstate<=s7;
                s7:nxtstate<=s0;
                default:nxtstate<=s0;
                endcase
                end
        end
    end
    
    //Registar Definition
    always@(posedge clk) begin
    if(enc_btn) state<=nxtstate;
    end
    
    //Ouput
    always@(state) begin
    case(state)
    s0: bit0rst <= enc_byte;
    s1: bit1rst <= enc_byte;
    s2: bit2rst <= enc_byte;
    s3: bit3rst <= enc_byte;
    s4: bit4rst <= enc_byte;
    s5: bit5rst <= enc_byte;
    s6: bit6rst <= enc_byte;
    s7: bit7rst <= enc_byte;
     endcase         
    end   
    //refresh 7 segment display
    bcdto7segment(bcdVal[3:0], seg[6:0]);
    //bcd_actual(bcdVal,refresh,bit0,bit1,bit2,bit3,bit4,bit5,bit5,bit6,bit7,clk_select);
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
