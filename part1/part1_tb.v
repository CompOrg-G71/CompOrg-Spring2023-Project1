`timescale 1ns/1ns
`include "part1.v"

module part1_tb();

reg [1:0] FunSel;
reg [3:0] data_in;
reg enable;
wire [3:0] data_out;

part1 part1_inst (FunSel, data_in, enable, data_out);

initial begin

    $dumpfile("part1_tb.vcd");
    $dumpvars(0, part1_tb);

    FunSel = 2'b00;
    data_in = 4'b0010;
    enable = 0;
    #10;

    FunSel = 2'b00;
    data_in = 4'b0010;
    enable = 1;
    #10;

    FunSel = 2'b01;
    data_in = 4'b0010;
    enable = 1;
    #10;

    FunSel = 2'b10;
    data_in = 4'b0010;
    enable = 1;
    #10;

    FunSel = 2'b11;
    data_in = 4'b0110;
    enable = 1;
    #10;

    FunSel = 2'b01;
    data_in = 4'b0110;
    enable = 0;
    #10;

    FunSel = 2'b00;
    data_in = 4'b0010;
    enable = 1;
    #10;
    
    $finish;

end

endmodule
