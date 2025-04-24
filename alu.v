`timescale 1ns / 1ps

// alu.v - ALU implementation
// Based on Figure 3.5 in the lab manual

module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] control,
    output reg [31:0] result,
    output zero
);
    always @(*) begin
        case(control)
            3'b000: result = a & b;        // AND
            3'b001: result = a | b;        // OR
            3'b010: result = a + b;        // ADD
            3'b110: result = a - b;        // SUB
            3'b111: result = (a < b) ? 1 : 0; // SLT
            default: result = 32'bx;       // Unknown operation
        endcase
    end
    
    assign zero = (result == 0);
endmodule