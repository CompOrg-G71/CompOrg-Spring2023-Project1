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