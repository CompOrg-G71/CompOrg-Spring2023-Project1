
module part1 (input [1:0] FunSel, input [3:0] data_in, input enable, output reg [3:0] data_out);

    always @(FunSel or data_in or enable)
    begin
        if (enable == 0)
            data_out <= data_out;
        else
            case (FunSel)
                2'b00: data_out <= 4'b0000;
                2'b01: data_out <= data_in;
                2'b10: data_out <= data_out - 1;
                2'b11: data_out <= data_out + 1;
            endcase
    end

endmodule

