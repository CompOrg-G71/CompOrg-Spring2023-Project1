`timescale 1ps/1ps
`include "mux_2to1.v"

module mux_2to1_tb();

reg clk;
reg [7:0] in0;
reg [7:0] in1;
reg sel;
wire [7:0] out;

mux_2to1 uut(
    clk,
    sel,
    in0,
    in1,
    out
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    $dumpfile("mux_2to1_tb.vcd");
    $dumpvars(0, mux_2to1_tb);

    in0 = 8'b00000010;
    in1 = 8'b00000001;
    sel = 0;
    #10;

    sel = 1;
    #10;

    $display("simulation finished");
    $finish;
end
endmodule