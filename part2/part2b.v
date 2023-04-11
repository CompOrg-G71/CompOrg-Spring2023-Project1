module part2b (
    input clk,
    input [7:0] I,
    input [2:0] O1Sel,
    input [2:0] O2Sel,
    input [1:0] FunSel,
    input [3:0] RSel,
    input [3:0] TSel,
    output reg [7:0] O1,
    O2
);

    reg [7:0] R1;
    reg [7:0] R2;
    reg [7:0] R3;
    reg [7:0] R4;
    
    reg [7:0] T1;
    reg [7:0] T2;
    reg [7:0] T3;
    reg [7:0] T4;
 
    always @ (posedge clk) begin

        if(FunSel == 2'b00) begin
            if(RSel[0] == 1) 
                 R4 <= 8'b00000000;
            if(RSel[1] == 1) 
                 R3 <= 8'b00000000;
            if(RSel[2] == 1) 
                 R2 <= 8'b00000000;
            if(RSel[3] == 1) 
                 R1 <= 8'b00000000;
            if(TSel[0] == 1) 
                 T4 <= 8'b00000000;
            if(TSel[1] == 1) 
                 T3 <= 8'b00000000;
            if(TSel[2] == 1) 
                 T2 <= 8'b00000000;
            if(TSel[3] == 1) 
                 T1 <= 8'b00000000;
        end
        else if(FunSel == 2'b01) begin
            if(RSel[0])  R4 <= I;
            if(RSel[1])  R3 <= I;
            if(RSel[2])  R2 <= I;
            if(RSel[3])  R1 <= I;
            if(TSel[0])  T4 <= I;
            if(TSel[1])  T3 <= I;
            if(TSel[2])  T2 <= I;
            if(TSel[3])  T1 <= I;
        end
        else if(FunSel == 2'b10) begin
            if(RSel[0])  R4 <= R4 - 1;
            if(RSel[1])  R3 <= R3 - 1;
            if(RSel[2])  R2 <= R2 - 1;
            if(RSel[3])  R1 <= R1 - 1;
            if(TSel[0])  T4 <= T4 - 1;
            if(TSel[1])  T3 <= T3 - 1;
            if(TSel[2])  T2 <= T2 - 1;
            if(TSel[3])  T1 <= T1 - 1;
        end
        else if(FunSel == 2'b11) begin
            if(RSel[0])  R4 <= R4 + 1;
            if(RSel[1])  R3 <= R3 + 1;
            if(RSel[2])  R2 <= R2 + 1;
            if(RSel[3])  R1 <= R1 + 1;
            if(TSel[0])  T4 <= T4 + 1;
            if(TSel[1])  T3 <= T3 + 1;
            if(TSel[2])  T2 <= T2 + 1;
            if(TSel[3])  T1 <= T1 + 1;
        end
                
        if( O1Sel == 3'b000)  O1 <= T1;
        else if( O1Sel == 3'b001)  O1 <= T2;
        else if( O1Sel == 3'b010)  O1 <= T3;
        else if( O1Sel == 3'b011)  O1 <= T4;
        else if( O1Sel == 3'b100)  O1 <= R1;
        else if( O1Sel == 3'b101)  O1 <= R2;
        else if( O1Sel == 3'b110)  O1 <= R3;
        else if( O1Sel == 3'b111)  O1 <= R4;


        if( O2Sel == 3'b000)  O2 <= T1;
        else if( O2Sel == 3'b001)  O2 <= T2;
        else if( O2Sel == 3'b010)  O2 <= T3;
        else if( O2Sel == 3'b011)  O2 <= T4;
        else if( O2Sel == 3'b100)  O2 <= R1;
        else if( O2Sel == 3'b101)  O2 <= R2;
        else if( O2Sel == 3'b110)  O2 <= R3;
        else if( O2Sel == 3'b111)  O2 <= R4;

    end 
endmodule