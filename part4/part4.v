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


module part2a_IRreg(input clk, input[7:0] I, input [1:0] FunSel, input LH, input enable, output reg [15:0] data_out);

    always @(posedge clk)
    begin
        if (enable == 0)
            data_out <= data_out;
        else
            case (FunSel)
                2'b00: data_out <= 16'b000000000000000;
                2'b01: 
                case (LH)
                    0: data_out[7:0] <= I;
                    1: data_out[15:8] <= I;
                endcase
                2'b10: data_out <= data_out - 1;
                2'b11: data_out <= data_out + 1;
            endcase
    end

endmodule

module part2b_RF ( input clk, input [7:0] I, input [2:0] O1Sel, input [2:0] O2Sel, input [1:0] FunSel, input [3:0] RSel, input [3:0] TSel, output reg [7:0] O1, O2 );

    reg [7:0] R1;
    reg [7:0] R2;
    reg [7:0] R3;
    reg [7:0] R4;
    
    reg [7:0] T1;
    reg [7:0] T2;
    reg [7:0] T3;
    reg [7:0] T4;

    always @ (posedge clk) begin

        case (FunSel)
            2'b00: begin
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
            2'b01: begin
                if(RSel[0]) R4 <= I;
                if(RSel[1]) R3 <= I;
                if(RSel[2]) R2 <= I;
                if(RSel[3]) R1 <= I;
                if(TSel[0]) T4 <= I;
                if(TSel[1]) T3 <= I;
                if(TSel[2]) T2 <= I;
                if(TSel[3]) T1 <= I;
            end
            2'b10: begin
                if(RSel[0]) R4 <= R4 - 1;
                if(RSel[1]) R3 <= R3 - 1;
                if(RSel[2]) R2 <= R2 - 1;
                if(RSel[3]) R1 <= R1 - 1;
                if(TSel[0]) T4 <= T4 - 1;
                if(TSel[1]) T3 <= T3 - 1;
                if(TSel[2]) T2 <= T2 - 1;
                if(TSel[3]) T1 <= T1 - 1;
            end
            2'b11: begin
                if(RSel[0]) R4 <= R4 + 1;
                if(RSel[1]) R3 <= R3 + 1;
                if(RSel[2]) R2 <= R2 + 1;
                if(RSel[3]) R1 <= R1 + 1;
                if(TSel[0]) T4 <= T4 + 1;
                if(TSel[1]) T3 <= T3 + 1;
                if(TSel[2]) T2 <= T2 + 1;
                if(TSel[3]) T1 <= T1 + 1;
            end
        endcase
                
        case (O1Sel)
            3'b000: O1 <= T1;
            3'b001: O1 <= T2;
            3'b010: O1 <= T3;
            3'b011: O1 <= T4;
            3'b100: O1 <= R1;
            3'b101: O1 <= R2;
            3'b110: O1 <= R3;
            3'b111: O1 <= R4;
        endcase
        case (O2Sel)
            3'b000: O2 <= T1;
            3'b001: O2 <= T2;
            3'b010: O2 <= T3;
            3'b011: O2 <= T4;
            3'b100: O2 <= R1;
            3'b101: O2 <= R2;
            3'b110: O2 <= R3;
            3'b111: O2 <= R4;
        endcase

    end 
endmodule


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

    PCPast <= PC;

    case (FunSel)
        2'b00:
        begin
            if(RSel[0] == 1) 
                PCPast <= 8'b00000000;
            if(RSel[1] == 1) 
                SP <= 8'b00000000;
            if(RSel[2] == 1) 
                AR <= 8'b00000000;
            if(RSel[3] == 1) 
                PC <= 8'b00000000;
        end
        2'b01:
        begin
            if(RSel[0] == 1) 
                PCPast <= I;
            if(RSel[1] == 1) 
                SP <= I;
            if(RSel[2] == 1) 
                AR <= I;
            if(RSel[3] == 1) 
                PC <= I;
        end
        2'b10:
        begin
            if(RSel[0] == 1) 
                PCPast <= PCPast + 1;
            if(RSel[1] == 1) 
                SP <= SP + 1;
            if(RSel[2] == 1) 
                AR <= AR + 1;
            if(RSel[3] == 1) 
                PC <= PC + 1;
        end
        2'b11:
        begin
            if(RSel[0] == 1) 
                PCPast <= PCPast - 1;
            if(RSel[1] == 1) 
                SP <= SP - 1;
            if(RSel[2] == 1) 
                AR <= AR - 1;
            if(RSel[3] == 1) 
                PC <= PC - 1;
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

module part3_ALU (input clk, input [7:0] A, input [7:0] B, input [3:0] FunSel, output reg [7:0] OutALU, output reg [3:0] Flags);

    reg [8:0] temp_result;
    reg [7:0] B_neg;

    always @(posedge clk) begin
        B_neg = (~B) + 8'b00000001; // 2's complement of B

        case (FunSel)
          4'b0000: begin // A
                OutALU <= A;
                Flags[0] <= (A == 8'b0); // Z flag
                Flags[2] <= A[7]; // N flag
            end
            4'b0001: begin // B
                OutALU <= B;
                Flags[0] <= (B == 8'b0); // Z flag
                Flags[2] <= B[7]; // N flag
            end
            4'b0010: begin // NOT A
                OutALU <= ~A;
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[2] <= OutALU[7]; // N flag
            end
            4'b0011: begin // NOT B
                OutALU <= ~B;
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[2] <= OutALU[7]; // N flag
            end
            4'b0100: begin // Addition
                temp_result = A + B;
                OutALU <= temp_result[7:0];
                Flags[0] <= (temp_result == 9'b0); // Z flag
                Flags[1] <= temp_result[8]; // C flag
                Flags[2] <= temp_result[7]; // N flag
                Flags[3] <= (A[7] & B[7] & ~temp_result[7]) | (~(A[7] | B[7]) & temp_result[7]); // O flag
            end
            4'b0101: begin // Subtraction
                temp_result = A + B_neg; // Perform subtraction using 2's complement addition
                OutALU <= temp_result[7:0];
                Flags[0] <= (temp_result == 9'b0); // Z flag
                Flags[1] <= (~A[7] & B[7]) | (B[7] & temp_result[7]) | (temp_result[7] & ~A[7]); // C flag
                Flags[2] <= temp_result[7]; // N flag
                Flags[3] <= Flags[3] <= (A[7] & ~B[7] & ~temp_result[7]) | (~A[7] & B[7] & temp_result[7]); // O flag
            end
            4'b0110: begin // Compare A, B
                if (A == B) begin
                    OutALU <= 8'b0;
                    Flags <= 4'b0001; // Z flag
                end else if (A[7] == 0 && B[7] == 1) begin
                    OutALU <= A;
                    Flags <= 4'b0000; 
                end else if (A[7] == 1 && B[7] == 0) begin
                    OutALU <= 8'b0;
                    Flags <= 4'b0100; // N flag
                end else if (A > B) begin
                    OutALU <= A;
                    Flags <= 4'b0000; 
                end else begin
                    OutALU <= 8'b0;
                    Flags <= 4'b0100; // N flag
                end
            end
            4'b0111: begin // A AND B
                OutALU <= A & B;
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[2] <= OutALU[7]; // N flag
            end
            4'b1000: begin // A OR B
                OutALU <= A | B;
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[2] <= OutALU[7]; // N flag
            end
            4'b1001: begin // A NAND B
                OutALU <= ~(A & B);
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[2] <= OutALU[7]; // N flag
            end
            4'b1010: begin // A XOR B
                OutALU <= A ^ B;
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[2] <= OutALU[7]; // N flag
            end
             4'b1011: begin // LSL A
                OutALU <= {A[6:0], 1'b0};
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[1] <= A[7]; // C flag
                Flags[2] <= OutALU[7]; // N flag
            end
            4'b1100: begin // LSR A
                OutALU <= {1'b0, A[7:1]};
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[1] <= A[0]; // C flag
                Flags[2] <= OutALU[7]; // N flag
            end
           4'b1101: begin // ASL A
                OutALU <= {A[6:0], 1'b0};
                Flags[0] <= (OutALU == 8'b0); // Z flag
                Flags[2] <= OutALU[7]; // N flag
                Flags[3] <= (A[7] == 1'b1 && OutALU[7] == 1'b0) ? 1'b1 : 1'b0; // O flag
            end
            4'b1110: begin // ASR A
                OutALU <= {A[7], A[7:1]};
                Flags[0] <= (OutALU == 8'b0); // Z flag
            end
           4'b1111: begin // CSR A
            OutALU <= {A[0], A[7:1]};
            Flags[0] <= (OutALU == 8'b0); // Z flag
            Flags[1] <= A[0]; // C flag
            Flags[2] <= OutALU[7]; // N flag
        end
        endcase
    end
endmodule


module Memory(
    input wire clock,
    input wire[7:0] address,
    input wire[7:0] data,
    input wire wr, //Read = 0, Write = 1
    input wire cs, //Chip is enable when cs = 0
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
            RAM_DATA[address] <= data; 
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
        case(sel)
            1'b0: out = in0;
            1'b1: out = in1;
        endcase
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
        case(sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
        endcase
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
input[1:0] IR_Funsel,
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
    
    Memory Mem(Clock, ARF_OutB, ALU_Out, Mem_WR, Mem_CS, MemOut);

    mux_4to1 MuxA(Clock, MuxASel, ALU_Out, MemOut, IR_Out[7:0], ARF_OutA, MuxAOut);

    part2b_RF RF(Clock, MuxAOut, RF_O1Sel, RF_O2Sel, RF_FunSel, RF_RSel, RF_TSel, RF_O1, RF_O2);

    mux_2to1 MuxC(Clock, MuxCSel, RF_O1, ARF_OutA, MuxCOut);

    mux_4to1 MuxB(Clock, MuxBSel, ALU_Out, MemOut, IR_Out[7:0], ARF_OutA, MuxBOut);

    part3_ALU ALU(Clock, MuxCOut, RF_O2, ALU_FunSel, ALU_Out, ALU_FlagOut);

    part2c_ARF ARF(Clock, MuxBOut, ARF_OutASel, ARF_OutBSel, ARF_FunSel, ARF_RSel, ARF_OutA, ARF_OutB);

    part2a_IRreg IR(Clock, MemOut, IR_Funsel, IR_LH, IR_Enable, IR_Out);


endmodule
