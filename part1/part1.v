
module part1 #(parameter n = 4) (input clk, input [1:0] FunSel, input [n-1:0] data_in, input enable, output reg [n-1:0] data_out);


    wire [n-1:0] zero = 0;
    always @(posedge clk)
    begin
        if (enable == 0)
            data_out <= data_out;
        else
            case (FunSel)
                2'b00: data_out <= zero;
                2'b01: data_out <= data_in;
                2'b10: data_out <= data_out - 1;
                2'b11: data_out <= data_out + 1;
            endcase
    end

endmodule

