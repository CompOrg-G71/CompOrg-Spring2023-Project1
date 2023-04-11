`timescale 1ns/1ns
`include "part2a.v"


module part2a_tb();

reg clk;
reg [7:0] I;
reg [1:0] FunSel;
reg LH;
reg enable;
wire [15:0] data_out;

part2a part2a_inst (clk, I, FunSel, LH, enable, data_out);


initial begin 
    clk = 1;
    forever #5 clk = ~clk;
end

initial begin

    $dumpfile("part2a_tb.vcd");
    $dumpvars(0, part2a_tb);

    enable = 0;
    FunSel = 2'b0;
    I = 8'b0;
    LH = 0;
    #15 ;

    enable = 0;
    FunSel = 2'b01;
    I = 8'b10101010;
    LH = 1;
    #15;

    enable = 1;
    #15

    enable = 0;
    #15;

    enable = 1;
    FunSel = 2'b00;
    I = 8'b00000101;
    LH = 0;
    #15;

    enable = 1;
    FunSel = 2'b01;
    I = 8'b00000101;
    LH = 1;
    #15;

    enable = 1;
    FunSel = 2'b01;
    I = 8'b00000101;
    LH = 0;
    #15;

    enable = 1;
    FunSel = 2'b10;
    I = 8'b00000101;
    LH = 0;
    #15;

    enable = 1;
    FunSel = 2'b11;
    I = 8'b00000111;
    LH = 0;
    #15;

    FunSel = 2'b0;
    I = 8'b0;
    LH = 0;
    #15;

    $finish;
end

endmodule




