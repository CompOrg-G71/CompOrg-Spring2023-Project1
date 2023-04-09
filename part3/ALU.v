`timescale 1ns/1ps

module ALU (
    input [7:0] A,
    input [7:0] B,
    input [3:0] FunSel,
    input clk,
    output reg [7:0] OutALU,
    output reg [3:0] Flags // ZCNO
);

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
