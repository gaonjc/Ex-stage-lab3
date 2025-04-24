`timescale 1ns / 1ps

// mux_32.v - 32-bit multiplexer
// Based on multiplexer in Lab 1

module mux_32(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] y
);
    assign y = sel ? a : b;
endmodule