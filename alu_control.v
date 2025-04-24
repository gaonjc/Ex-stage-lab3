`timescale 1ns / 1ps
// alu_control.v - ALU control unit
// Based on Figure 3.4 in the lab manual

module alu_control(
    input [1:0] alu_op,
    input [5:0] funct,
    output reg [2:0] select
);
    always @(*) begin
        case(alu_op)
            2'b00: select = 3'b010; // add for lw/sw
            2'b01: select = 3'b110; // subtract for beq
            2'b10: begin
                case(funct)
                    6'b100000: select = 3'b010; // add
                    6'b100010: select = 3'b110; // subtract
                    6'b100100: select = 3'b000; // and
                    6'b100101: select = 3'b001; // or
                    6'b101010: select = 3'b111; // slt
                    default:   select = 3'bxxx;
                endcase
            end
            default: select = 3'bxxx;
        endcase
    end
endmodule