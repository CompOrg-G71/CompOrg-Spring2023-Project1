`timescale 1ns / 1ps
`include "ALU.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2023 02:33:06
// Design Name: 
// Module Name: alu_tb
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


module ALU_tb;

    reg [7:0] A_tb;
    reg [7:0] B_tb;
    reg [3:0] FunSel_tb;
    reg clk_tb;

    wire [7:0] OutALU_tb;
    wire [3:0] Flags_tb;

    ALU ALU_inst (
        .A(A_tb),
        .B(B_tb),
        .FunSel(FunSel_tb),
        .clk(clk_tb),
        .OutALU(OutALU_tb),
        .Flags(Flags_tb)
    );

    always #5 clk_tb = ~clk_tb;

    initial begin

        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);

        A_tb = 8'b00000001;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b0000;
        clk_tb = 1'b0;
        #10;
        $display("FunSel 0000 OutALU: %b", OutALU_tb);
        $display("Flags: %b", Flags_tb);


        // Test ADD operation
        A_tb = 8'b00110011;
        B_tb = 8'b00001111;
        FunSel_tb = 4'b0100;
        #10;
        $display("ADD operation result: %b", OutALU_tb);
        $display("ADD operation flags: %b", Flags_tb);

        // Test SUB operation
        A_tb = 8'b00000111;
        B_tb = 8'b11111010;
        FunSel_tb = 4'b0101;
        #10;
        $display("SUB operation result: %b", OutALU_tb);
        $display("SUB operation flags: %b", Flags_tb);
        
        // Test Compare operation
        A_tb = 8'b01000000;
        B_tb = 8'b00111000;
        FunSel_tb = 4'b0110;
        #10;
        $display("Compare operation result: %b", OutALU_tb);
        $display("Compare operation flags: %b", Flags_tb);
        // Test AND operation
        A_tb = 8'b10101010;
        B_tb = 8'b11110000;
        FunSel_tb = 4'b0111;
        #10;
        $display("AND operation result: %b", OutALU_tb);
        $display("AND operation flags: %b", Flags_tb);

        // Test OR operation
        A_tb = 8'b10101010;
        B_tb = 8'b11110000;
        FunSel_tb = 4'b1000;
        #10;
        $display("OR operation result: %b", OutALU_tb);
        $display("OR operation flags: %b", Flags_tb);

        // Test XOR operation
        A_tb = 8'b10101010;
        B_tb = 8'b11110000;
        FunSel_tb = 4'b1010;
        #10;
        $display("XOR operation result: %b", OutALU_tb);
        $display("XOR operation flags: %b", Flags_tb);

        // Test LSL operation
        A_tb = 8'b00110011;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1011;
        #10;
        $display("LSL operation result: %b", OutALU_tb);
        $display("LSL operation flags: %b", Flags_tb);

        // Test LSR operation
        A_tb = 8'b00110011;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1100;
        #10;
        $display("LSR operation result: %b", OutALU_tb);
        $display("LSR operation flags: %b", Flags_tb);

        // Test ASL
        A_tb = 8'b10000000;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1101;
        #10;
        $display("ASL operation result: %b", OutALU_tb);
        $display("ASL operation flags: %b", Flags_tb);

        // Test ASR operation
        A_tb = 8'b00110011;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1110;
        #10;
        $display("ASR operation result: %b", OutALU_tb);
        $display("ASR operation flags: %b", Flags_tb);

        // Test CSR operation
        A_tb = 8'b10000000;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1111;
        #10;
        $display("CSR operation result: %b", OutALU_tb);
        $display("CSR operation flags: %b", Flags_tb);

        // Finish simulation
        $finish;
        #10;
end
endmodule