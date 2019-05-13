`timescale 1ns / 1ps
module led_animator(
    input [3:0] n0, n1,
    output [15:0] led,
    input reset
    );

    wire [7:0] n;
    assign n = n1 * 10 + n0;
 
    //Down
    ranger #(1, 21) (n, led[15],reset);
    ranger #(5, 26) (n, led[14],reset);
    ranger #(10, 31) (n, led[13],reset);
    ranger #(15, 36) (n, led[12],reset);
    ranger #(20, 41) (n, led[11],reset);
    ranger #(25, 46) (n, led[10],reset);
    ranger #(30, 51) (n, led[9],reset);
    ranger #(35, 56) (n, led[8],reset);
    
    ranger #(35, 56) (n, led[7],reset);
    ranger #(30, 51) (n, led[6],reset);
    ranger #(25, 46) (n, led[5],reset);
    ranger #(20, 41) (n, led[4],reset);
    ranger #(15, 36)  (n, led[3],reset);
    ranger #(10, 31) (n, led[2],reset);
    ranger #(5, 26) (n, led[1],reset);
    ranger #(1, 21) (n, led[0],reset);
    
endmodule
    /*ranger #(31, 51) (n, led[9],reset);
    ranger #(36, 56) (n, led[8],reset);
    ranger #(41, 61) (n, led[7],reset);
    ranger #(46, 66) (n, led[6],reset);
    ranger #(51, 71) (n, led[5],reset);
    ranger #(56, 76) (n, led[4],reset);
    ranger #(61, 81) (n, led[3],reset);
    ranger #(66, 86) (n, led[2],reset);
    //ranger #(71, 91) (n, led[1]);
    //ranger #(76, 96) (n, led[0]);
//endmodule
*/
