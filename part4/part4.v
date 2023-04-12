//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2023 12:25:11 PM
// Design Name: 
// Module Name: Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module part1 #(parameter n = 4) (input clk, input [1:0] FunSel, input [n-1:0] data_in, input enable, output reg [n-1:0] data_out);

    wire [n-1:0] zero = 0;
    always @(posedge clk)
    begin
        if (enable == 0)
            data_out = data_out;
        else
            case (FunSel)
                2'b00: data_out = zero;
                2'b01: data_out = data_in;
                2'b10: data_out = data_out - 1;
                2'b11: data_out = data_out + 1;
            endcase
    end
endmodule

module part2a_IRreg(input clk, input[7:0] I, input [1:0] FunSel, input LH, input enable, output reg [15:0] data_out);

    always @(posedge clk)
    begin
        if (enable == 0)
            data_out = data_out;
        else
            if(FunSel == 2'b00) data_out = 16'b000000000000000;
            else if(FunSel == 2'b01) begin
                if(LH == 0) data_out[7:0] = I;
                else if(LH == 1) data_out[15:8] = I;
            end
            else if(FunSel == 2'b10) data_out = data_out - 1;
            else if(FunSel == 2'b11) data_out = data_out + 1;
    end

endmodule

module part2b_RF (
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
                 R4 = 8'b00000000;
            if(RSel[1] == 1) 
                 R3 = 8'b00000000;
            if(RSel[2] == 1) 
                 R2 = 8'b00000000;
            if(RSel[3] == 1) 
                 R1 = 8'b00000000;
            if(TSel[0] == 1) 
                 T4 = 8'b00000000;
            if(TSel[1] == 1) 
                 T3 = 8'b00000000;
            if(TSel[2] == 1) 
                 T2 = 8'b00000000;
            if(TSel[3] == 1) 
                 T1 = 8'b00000000;
        end
        else if(FunSel == 2'b01) begin
            if(RSel[0])  R4 = I;
            if(RSel[1])  R3 = I;
            if(RSel[2])  R2 = I;
            if(RSel[3])  R1 = I;
            if(TSel[0])  T4 = I;
            if(TSel[1])  T3 = I;
            if(TSel[2])  T2 = I;
            if(TSel[3])  T1 = I;
        end
        else if(FunSel == 2'b10) begin
            if(RSel[0])  R4 = R4 - 1;
            if(RSel[1])  R3 = R3 - 1;
            if(RSel[2])  R2 = R2 - 1;
            if(RSel[3])  R1 = R1 - 1;
            if(TSel[0])  T4 = T4 - 1;
            if(TSel[1])  T3 = T3 - 1;
            if(TSel[2])  T2 = T2 - 1;
            if(TSel[3])  T1 = T1 - 1;
        end
        else if(FunSel == 2'b11) begin
            if(RSel[0])  R4 = R4 + 1;
            if(RSel[1])  R3 = R3 + 1;
            if(RSel[2])  R2 = R2 + 1;
            if(RSel[3])  R1 = R1 + 1;
            if(TSel[0])  T4 = T4 + 1;
            if(TSel[1])  T3 = T3 + 1;
            if(TSel[2])  T2 = T2 + 1;
            if(TSel[3])  T1 = T1 + 1;
        end
                
        if( O1Sel == 3'b000)  O1 = T1;
        else if( O1Sel == 3'b001)  O1 = T2;
        else if( O1Sel == 3'b010)  O1 = T3;
        else if( O1Sel == 3'b011)  O1 = T4;
        else if( O1Sel == 3'b100)  O1 = R1;
        else if( O1Sel == 3'b101)  O1 = R2;
        else if( O1Sel == 3'b110)  O1 = R3;
        else if( O1Sel == 3'b111)  O1 = R4;


        if( O2Sel == 3'b000)  O2 = T1;
        else if( O2Sel == 3'b001)  O2 = T2;
        else if( O2Sel == 3'b010)  O2 = T3;
        else if( O2Sel == 3'b011)  O2 = T4;
        else if( O2Sel == 3'b100)  O2 = R1;
        else if( O2Sel == 3'b101)  O2 = R2;
        else if( O2Sel == 3'b110)  O2 = R3;
        else if( O2Sel == 3'b111)  O2 = R4;

    end 
endmodule


//Address Register File
module part2c_ARF(
    input clk,
    input [7:0] I,
    input [1:0] OutASel,
    input [1:0] OutBSel,
    input [1:0] FunSel,
    input [3:0] RSel,
    output reg [7:0] OutA,
    output reg [7:0] OutB
);

reg [7:0] PC;
reg [7:0] AR;
reg [7:0] SP;
reg [7:0] PCPast;


always @ (posedge clk) begin

    if(FunSel == 2'b00)
    begin
        if(RSel[3] == 1) 
            PC = 8'b00000000;
        if(RSel[2] == 1) 
            AR = 8'b00000000;
        if(RSel[1] == 1) 
            SP = 8'b00000000;
        if(RSel[0] == 1) 
            PCPast = 8'b00000000;
    end
    else if(FunSel == 2'b01)
    begin
        if(RSel[3] == 1) 
            PC = I;
        if(RSel[2] == 1) 
            AR = I;
        if(RSel[1] == 1) 
            SP = I;
        if(RSel[0] == 1)
            PCPast = I;
    end
    else if(FunSel == 2'b10)
    begin
        if(RSel[3] == 1) 
            PC = PC + 1;
        if(RSel[2] == 1) 
            AR = AR + 1;
        if(RSel[1] == 1) 
            SP = SP + 1;
        if(RSel[0] == 1)
            PCPast = PCPast + 1;
    end
    else if(FunSel == 2'b11)
    begin
        if(RSel[3] == 1) 
            PC = PC - 1;
        if(RSel[2] == 1) 
            AR = AR - 1;
        if(RSel[1] == 1) 
            SP = SP - 1;
        if(RSel[0] == 1)
            PCPast = PCPast - 1;
    end


    if(OutASel == 2'b00) OutA = AR;
    else if(OutASel == 2'b01) OutA = SP;
    else if(OutASel == 2'b10) OutA = PCPast;
    else if(OutASel == 2'b11) OutA = PC;

    if(OutBSel == 2'b00) OutB = AR;
    else if(OutBSel == 2'b01) OutB = SP;
    else if(OutBSel == 2'b10) OutB = PCPast;
    else if(OutBSel == 2'b11) OutB = PC;

end

endmodule


module part3_ALU (input clk, input [7:0] A, input [7:0] B, input [3:0] FunSel, output reg [7:0] OutALU, output reg [3:0] Flags);

    reg [7:0] B_neg;
    reg cout;

    always @(posedge clk) begin
        B_neg = (~B) + 8'b00000001; // 2's complement of B
        cout = Flags[2];

        if(FunSel == 4'b0000)
            OutALU = A;
        else if(FunSel == 4'b0001)
            OutALU = B;
        else if(FunSel == 4'b0010)
            OutALU = ~A;
        else if(FunSel == 4'b0011)
            OutALU = ~B;
        else if(FunSel == 4'b0100) begin // A+B
            {cout, OutALU} = {1'b0, A} + {1'b0, B};
            if(cout == 1) Flags[0] = 1;
            else Flags[0] = 0;
        end
        else if(FunSel == 4'b0101)begin
            {cout, OutALU} = {1'b0, A} + {1'b0, B_neg}; // TODO: check if this is correct
            if(cout !== OutALU[7]) Flags[0] = 1; //Overflow
            else Flags[0] = 0;
        end
        else if(FunSel == 4'b0110)
            begin
                if(A > B) OutALU = A;
                else OutALU = 0;
            end
        else if(FunSel == 4'b0111)
            OutALU = A & B;
        else if(FunSel == 4'b1000)
            OutALU = A | B;
        else if(FunSel == 4'b1001)
            OutALU = ~(A & B);
        else if(FunSel == 4'b1010)
            OutALU = (~A & B) | (A & ~B);
        else if(FunSel == 4'b1011) begin // LSL
            cout = A[7];
            OutALU = A << 1;
        end
        else if (FunSel == 4'b1100) begin //LSR
            cout = A[0];
            OutALU = A >> 1;
        end
        else if (FunSel == 4'b1101) //ASL
            OutALU = A << 1;
        else if (FunSel == 4'b1110)
            OutALU = {A[7], A[7:1]}; 
        else if (FunSel == 4'b1111) begin //CSR
            cout = A[0];
            OutALU = {Flags[2], A[7:1]};
        end

        // Set flags

        if (OutALU == 8'b00000000) Flags[3] = 1; // Z Flag
        else Flags[3] = 0;

        Flags[2] = cout; // C Flag

        if (OutALU[7] == 1) Flags[1] = 1; // N Flag
        else Flags[1] = 0;

    end
endmodule

module Memory(
    input  clock,
    input [7:0] address,
    input [7:0] data,
    input  wr, //Read = 0, Write = 1
    input  cs, //Chip is enable when cs = 0
    output reg[7:0] o // Output
);
    //Declaration of the RAM Area
    reg[7:0] RAM_DATA[0:255];
    //Read Ram data from the file
    initial $readmemh("RAM.mem", RAM_DATA);
    //Read the selected data from RAM
    always @(*) begin
        o = ~wr && ~cs ? RAM_DATA[address] : 8'hZ;
    end
    
    //Write the data to RAM
    always @(posedge clock) begin
        if (wr && ~cs) begin
            RAM_DATA[address] = data; 
        end
    end
endmodule

module mux_2to1(
    input clk,
    input sel,
    input [7:0] in0,
    input [7:0] in1,
    output reg [7:0] out
);

    always @(posedge clk) begin
        if(1'b0) out = in0;
        if(1'b1) out = in1;
    end

endmodule

module mux_4to1(
    input clk,
    input [1:0] sel,
    input [7:0] in0,
    input [7:0] in1,
    input [7:0] in2,
    input [7:0] in3,
    output reg [7:0] out
);

    always @(posedge clk) begin
        if(sel == 2'b00) out = in0;
        if(sel == 2'b01) out = in1;
        if(sel == 2'b10) out = in2;
        if(sel == 2'b11) out = in3;
    end

endmodule

module ALUSystem(
input[2:0] RF_O1Sel, 
input[2:0] RF_O2Sel, 
input[1:0] RF_FunSel,
input[3:0] RF_RSel,
input[3:0] RF_TSel,
input[3:0] ALU_FunSel,
input[1:0] ARF_OutASel, 
input[1:0] ARF_OutBSel,
input[1:0] ARF_FunSel,
input[3:0] ARF_RSel,
input      IR_LH,
input      IR_Enable,
input[1:0] IR_FunSel,
input      Mem_WR,
input      Mem_CS,
input[1:0] MuxASel,
input[1:0] MuxBSel,
input      MuxCSel,
input      Clock
);

    wire [7:0] MemOut;
    wire [7:0] RF_O1,RF_O2;
    wire [7:0] MuxAOut, MuxBOut, MuxCOut;
    wire [3:0] ALU_FlagOut;
    wire [7:0] ALU_Out;
    wire [7:0] ARF_OutA, ARF_OutB;
    wire [15:0] IR_Out;
    wire [7:0] temp;
    
    part2c_ARF ARF(Clock, MuxBOut, ARF_OutASel, ARF_OutBSel, ARF_FunSel, ARF_RSel, ARF_OutA, ARF_OutB);

    part2b_RF RF(Clock, MuxAOut, RF_O1Sel, RF_O2Sel, RF_FunSel, RF_RSel, RF_TSel, RF_O1, RF_O2);

    mux_2to1 MuxC(Clock, MuxCSel, RF_O1, ARF_OutA, MuxCOut);

    part3_ALU ALU(Clock, MuxCOut, RF_O2, ALU_FunSel, ALU_Out, ALU_FlagOut);

    Memory Mem(Clock, ARF_OutB, ALU_Out, Mem_WR, Mem_CS, MemOut);

    part2a_IRreg IR(Clock, MemOut, IR_FunSel, IR_LH, IR_Enable, IR_Out);

    assign temp = IR_Out[7:0];

    mux_4to1 MuxA(Clock, MuxASel, ALU_Out, MemOut, temp, ARF_OutA, MuxAOut);

    mux_4to1 MuxB(Clock, MuxBSel, ALU_Out, MemOut, temp, ARF_OutA, MuxBOut);



endmodule
