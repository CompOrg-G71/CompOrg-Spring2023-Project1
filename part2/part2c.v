
//Address Register File
module part2c_ARF(
    input clk,
    input [7:0] I,
    input [1:0] OutASel,
    input [1:0] OutBSel,
    input [1:0] FunSel,
    input [2:0] RSel,
    output reg [7:0] OutA,
    output reg [7:0] OutB
);

reg [7:0] PC;
reg [7:0] AR;
reg [7:0] SP;
reg [7:0] PCPast;


always @ (posedge clk) begin

    PCPast <= PC;

    case (FunSel)
        2'b00:
        begin
            if(RSel[0] == 1) 
                PC <= 8'b00000000;
            if(RSel[1] == 1) 
                AR <= 8'b00000000;
            if(RSel[2] == 1) 
                SP <= 8'b00000000;
        end
        2'b01:
        begin
            if(RSel[0] == 1) 
                PC <= I;
            if(RSel[1] == 1) 
                AR <= I;
            if(RSel[2] == 1) 
                SP <= I;
        end
        2'b10:
        begin
            if(RSel[2] == 1) 
                PC <= PC + 1;
            if(RSel[1] == 1) 
                AR <= AR + 1;
            if(RSel[0] == 1) 
                SP <= SP + 1;
        end
        2'b11:
        begin
            if(RSel[2] == 1) 
                PC <= PC - 1;
            if(RSel[1] == 1) 
                AR <= AR - 1;
            if(RSel[0] == 1) 
                SP <= SP - 1;
        end
    endcase


    case (OutASel)
        2'b00: OutA <= AR;
        2'b01: OutA <= SP;
        2'b10: OutA <= PCPast;
        2'b11: OutA <= PC;
    endcase

    case (OutBSel)
        2'b00: OutB <= AR;
        2'b01: OutB <= SP;
        2'b10: OutB <= PCPast;
        2'b11: OutB <= PC;
    endcase

end

endmodule