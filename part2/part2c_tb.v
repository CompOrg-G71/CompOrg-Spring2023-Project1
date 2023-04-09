`timescale 1ps/1ps
`include "part2c.v"

module part2c_tb();

reg clk;
reg [7:0] I;
reg [1:0] OutASel, OutBSel, FunSel;
reg [2:0] RSel;

wire [7:0] OutA, OutB;

part2c_ARF part2c_ARF(
    clk,
    I,
    OutASel,
    OutBSel,
    FunSel,
    RSel,
    OutA,
    OutB
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("part2c_tb.vcd");
    $dumpvars(0, part2c_tb);

    #50

    I = 8'b00000100;
    OutASel = 2'b00;
    OutBSel = 2'b11;
    FunSel = 2'b01;
    RSel = 3'b011;
    #50

    I = 8'b00000110;
    OutASel = 2'b10;
    OutBSel = 2'b11;
    FunSel = 2'b01;
    RSel = 3'b011;
    #50

    I = 8'b00000000;
    OutASel = 2'b10;
    OutBSel = 2'b11;
    FunSel = 2'b00;
    RSel = 3'b011;
    #50

    $display("Simulation Complete..");
    $finish;
end

endmodule