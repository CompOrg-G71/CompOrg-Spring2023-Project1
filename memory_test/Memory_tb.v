`timescale 1ps/1ps
`include "Memory.v"

module Memory_tb();

reg Clock;
reg [7:0] address;
reg [7:0] data;
reg wr;
reg cs;
wire [7:0] o;

Memory uut(
    Clock,
    address,
    data,
    wr,
    cs,
    o
);

initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
end

initial begin

    $dumpfile("Memory_tb.vcd");
    $dumpvars(0, Memory_tb);

    address = 8'b00000011;
    data = 8'b01001100;
    wr = 1;
    cs = 0;
    #20

    address = 8'b00000100;
    data = 8'b10110011;
    wr = 1;
    cs = 0;
    #20

    address = 8'b00000011;
    data = 0;
    wr = 0;
    cs = 0;
    #20

    $display("Simulation finished");
    // $finish;

end

endmodule

