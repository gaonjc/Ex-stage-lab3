`timescale 1ns / 1ps

// mux_5.v - 5-bit multiplexer
// Based on Figure 3.3 in the lab manual

module mux_5(
    input [4:0] a,
    input [4:0] b,
    input sel,
    output [4:0] y
);
    assign y = sel ? a : b;
endmodule