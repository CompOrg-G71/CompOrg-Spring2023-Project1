module mux_2to1(
    input clk,
    input sel,
    input [7:0] in0,
    input [7:0] in1,
    output reg [7:0] out
);

    always @(posedge clk) begin
        case(sel)
            1'b0: out = in0;
            1'b1: out = in1;
        endcase
    end

endmodule
