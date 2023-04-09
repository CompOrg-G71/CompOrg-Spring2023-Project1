`timescale 1ns/1ns
`include "part2b.v"


module part2b_tb();

reg [7:0] I;
reg [2:0] O1Sel;
reg [2:0] O2Sel;
reg [1:0] FunSel;
reg [3:0] RSel;
reg [3:0] TSel;
wire [7:0] O1, O2;


part2b uut(
    I,
    O1Sel,
    O2Sel,
    FunSel,
    RSel,
    TSel,
    O1,
    O2
);

initial begin
    
    $dumpfile("part2b_tb.vcd");
    $dumpvars(0, part2b_tb);

    I = 8'b00000000;
    O1Sel = 3'b000;
    O2Sel = 3'b000;
    FunSel = 2'b00;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #10;

    I = 8'b00011000;
    O1Sel = 3'b101;
    O2Sel = 3'b011;
    FunSel = 2'b01;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #10;

    I = 8'b00011000;
    O1Sel = 3'b101;
    O2Sel = 3'b011;
    FunSel = 2'b10;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #10;
    
    I = 8'b00011000;
    O1Sel = 3'b101;
    O2Sel = 3'b011;
    FunSel = 2'b11;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #10;

    I = 8'b01011110;
    O1Sel = 3'b110;
    O2Sel = 3'b011;
    FunSel = 2'b01;
    RSel = 4'b0010;
    TSel = 4'b0010;
    #10;    

    $display("Simulation Completed..");
    $finish;

end

endmodule