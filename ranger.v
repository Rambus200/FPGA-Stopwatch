`timescale 1ns / 1ps

module ranger (//, WIDTH = 8)(
    input [8 - 1:0] n,
    output bool,
    input reset
    );
    parameter lower = 0, higher = 1;
    assign bool = (n >= lower) && (n < higher) && ~reset;
endmodule