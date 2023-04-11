

module part2a(input clk, input[7:0] I, input [1:0] FunSel, input LH, input enable, output reg [15:0] data_out);

    always @(posedge clk)
    begin
        if (enable == 0)
            data_out = data_out;
        else
            case (FunSel)
                2'b00: data_out = 16'b000000000000000;
                2'b01: 
                case (LH)
                    0: data_out[7:0] = I;
                    1: data_out[15:8] = I;
                endcase
                2'b10: data_out = data_out - 1;
                2'b11: data_out = data_out + 1;
            endcase
    end

endmodule

