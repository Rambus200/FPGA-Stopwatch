`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 12:02:28 PM
// Design Name: 
// Module Name: clock_divider2
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


module clock_divider2(clock_in,clock_out,enable);
input clock_in,enable; // input clock on FPGA
output clock_out; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
reg clock_out;
parameter DIVISOR = 28'd1250;//use to be 2

always @(posedge clock_in)
begin
if(enable)
    begin
    counter <= counter + 1;
    if(counter == DIVISOR) 
        begin
        counter <= 0;
        clock_out <= ~clock_out;
        end
  end
end

endmodule
