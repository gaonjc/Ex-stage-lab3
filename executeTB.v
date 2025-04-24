`timescale 1ns / 1ps
// executeTB.v - Updated testbench

module executeTB;
    reg clk;
    reg [1:0] ctlwb_in, ctlm_in;
    reg [31:0] npc, rdata1, rdata2, s_extend;
    reg [4:0] instr_2016, instr_1511;
    reg [1:0] alu_op;
    reg [5:0] funct;
    reg alusrc, regdst;

    wire [1:0] ctlwb_out, ctlm_out;
    wire [31:0] adder_out, alu_result_out, rdata2_out;
    wire [4:0] muxout_out;

    execute uut (
        .clk(clk),
        .ctlwb_in(ctlwb_in),
        .ctlm_in(ctlm_in),
        .npc(npc),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .s_extend(s_extend),
        .instr_2016(instr_2016),
        .instr_1511(instr_1511),
        .alu_op(alu_op),
        .funct(funct),
        .alusrc(alusrc),
        .regdst(regdst),
        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .adder_out(adder_out),
        .alu_result_out(alu_result_out),
        .rdata2_out(rdata2_out),
        .muxout_out(muxout_out)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        ctlwb_in = 2'b10; ctlm_in = 2'b01;
        npc = 32'd100; rdata1 = 32'd10; rdata2 = 32'd20; s_extend = 32'd4;
        instr_2016 = 5'd5; instr_1511 = 5'd10;
        alu_op = 2'b10; funct = 6'b100000; // ADD operation
        alusrc = 0; regdst = 1;            // Use rdata2, use instr_1511
        
        // Display heading
        $display("Time\tOP\tResult\tAdder\tReg");
        $monitor("%0t\t%b\t%0d\t%0d\t%0d", 
                $time, alu_op, alu_result_out, adder_out, muxout_out);

        // Wait for a few clock cycles
        #20;

        // Test subtraction operation
        alu_op = 2'b10; funct = 6'b100010; // SUB operation
        rdata1 = 32'd30; rdata2 = 32'd15;
        
        #10;
        
        // Test OR operation
        alu_op = 2'b10; funct = 6'b100101; // OR operation
        rdata1 = 32'd12; rdata2 = 32'd5;
        
        #10;
        
        // Test AND operation
        alu_op = 2'b10; funct = 6'b100100; // AND operation
        rdata1 = 32'd14; rdata2 = 32'd7;
        
        #10;
        
        // Test SLT operation
        alu_op = 2'b10; funct = 6'b101010; // SLT operation
        rdata1 = 32'd8; rdata2 = 32'd12;
        
        #10;
        
        // Test using sign-extended immediate
        alusrc = 1; // Use s_extend
        alu_op = 2'b00; // ADD for lw/sw
        rdata1 = 32'd100; s_extend = 32'd20;
        
        #10;
        
        // Test with different instruction fields for register destination
        regdst = 0; // Use instr_2016
        instr_2016 = 5'd15; instr_1511 = 5'd25;
        
        #10;
        
        $finish;
    end
endmodule