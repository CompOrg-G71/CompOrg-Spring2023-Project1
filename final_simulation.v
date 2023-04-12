`timescale 1ns/1ns
`include "part1.v"

module part1_tb();

parameter n = 4;
reg [1:0] FunSel;
reg [n-1:0] data_in;
reg enable;
reg clk;
wire [n-1:0] data_out;

part1 #(n) part1_inst (clk, FunSel, data_in, enable, data_out);

always begin

    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    $dumpfile("part1_tb.vcd");
    $dumpvars(0, part1_tb);

    FunSel = 2'b00;
    data_in = 4'b0010;
    enable = 0;
    #10;

    FunSel = 2'b00;
    data_in = 4'b0010;
    enable = 1;
    #10;

    FunSel = 2'b01;
    data_in = 4'b0010;
    enable = 1;
    #10;

    FunSel = 2'b10;
    data_in = 4'b0010;
    enable = 1;
    #10;

    FunSel = 2'b11;
    data_in = 4'b0110;
    enable = 1;
    #10;

    FunSel = 2'b01;
    data_in = 4'b0110;
    enable = 0;
    #10;

    FunSel = 2'b00;
    data_in = 4'b0010;
    enable = 1;
    #10;
    
    $finish;

end

endmodule


`timescale 1ns/1ns
`include "part2a.v"


module part2a_tb();

reg clk;
reg [7:0] I;
reg [1:0] FunSel;
reg LH;
reg enable;
wire [15:0] data_out;

part2a part2a_inst (clk, I, FunSel, LH, enable, data_out);


initial begin 
    clk = 1;
    forever #5 clk = ~clk;
end

initial begin

    $dumpfile("part2a_tb.vcd");
    $dumpvars(0, part2a_tb);

    enable = 0;
    FunSel = 2'b0;
    I = 8'b0;
    LH = 0;
    #15 ;

    enable = 0;
    FunSel = 2'b01;
    I = 8'b10101010;
    LH = 1;
    #15;

    enable = 1;
    #15

    enable = 0;
    #15;

    enable = 1;
    FunSel = 2'b00;
    I = 8'b00000101;
    LH = 0;
    #15;

    enable = 1;
    FunSel = 2'b01;
    I = 8'b00000101;
    LH = 1;
    #15;

    enable = 1;
    FunSel = 2'b01;
    I = 8'b00000101;
    LH = 0;
    #15;

    enable = 1;
    FunSel = 2'b10;
    I = 8'b00000101;
    LH = 0;
    #15;

    enable = 1;
    FunSel = 2'b11;
    I = 8'b00000111;
    LH = 0;
    #15;

    FunSel = 2'b0;
    I = 8'b0;
    LH = 0;
    #15;

    $finish;
end

endmodule




`timescale 1ns/1ns
`include "part2b.v"


module part2b_tb();

reg clk;
reg [7:0] I;
reg [2:0] O1Sel;
reg [2:0] O2Sel;
reg [1:0] FunSel;
reg [3:0] RSel;
reg [3:0] TSel;
wire [7:0] O1, O2;


part2b uut(
    clk,
    I,
    O1Sel,
    O2Sel,
    FunSel,
    RSel,
    TSel,
    O1,
    O2
);

initial begin
    clk = 1;
    forever #5 clk = ~clk;
end

initial begin
    
    $dumpfile("part2b_tb.vcd");
    $dumpvars(0, part2b_tb);

    I = 8'b00000000;
    O1Sel = 3'b000;
    O2Sel = 3'b000;
    FunSel = 2'b00;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #15;

    I = 8'b00011000;
    O1Sel = 3'b101;
    O2Sel = 3'b011;
    FunSel = 2'b01;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #15;

    I = 8'b00011000;
    O1Sel = 3'b101;
    O2Sel = 3'b011;
    FunSel = 2'b10;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #15;
    
    I = 8'b00011000;
    O1Sel = 3'b101;
    O2Sel = 3'b011;
    FunSel = 2'b11;
    RSel = 4'b0100;
    TSel = 4'b0001;
    #15;

    I = 8'b01011110;
    O1Sel = 3'b110;
    O2Sel = 3'b011;
    FunSel = 2'b01;
    RSel = 4'b0010;
    TSel = 4'b0010;
    #15;

    #30;

    $display("Simulation Completed..");
    $finish;

end

endmodule


`timescale 1ps/1ps
`include "part2c.v"

module part2c_tb();

reg clk;
reg [7:0] I;
reg [1:0] OutASel, OutBSel, FunSel;
reg [3:0] RSel;

wire [7:0] OutA, OutB;

part2c_ARF part2c_ARF(
    clk,
    I,
    OutASel,
    OutBSel,
    FunSel,
    RSel,
    OutA,
    OutB
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("part2c_tb.vcd");
    $dumpvars(0, part2c_tb);

    I = 8'b00001000;
    FunSel = 2'b00;
    RSel = 4'b1111;
    OutASel = 2'b00;
    OutBSel = 2'b00;
    #15;

    I = 8'b00001000;
    FunSel = 2'b01;
    RSel = 4'b1001;
    OutASel = 2'b10;
    OutBSel = 2'b11;
    #15;

    I = 8'b00011000;
    FunSel = 2'b10;
    RSel = 4'b1001;
    OutASel = 2'b10;
    OutBSel = 2'b11;
    #15;

    I = 8'b00011000;
    FunSel = 2'b11;
    RSel = 4'b1001;
    OutASel = 2'b10;
    OutBSel = 2'b11;
    #15;

    I = 8'b00011000;
    FunSel = 2'b01;
    RSel = 4'b0110;
    OutASel = 2'b00;
    OutBSel = 2'b01;
    #15;

    I = 8'b00011000;
    FunSel = 2'b00;
    RSel = 4'b0110;
    OutASel = 2'b00;
    OutBSel = 2'b01;
    #15;


    $display("Simulation Complete..");
    $finish;
end

endmodule


`timescale 1ns / 1ps
`include "ALU.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2023 02:33:06
// Design Name: 
// Module Name: alu_tb
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


module ALU_tb;

    reg [7:0] A_tb;
    reg [7:0] B_tb;
    reg [3:0] FunSel_tb;
    reg clk_tb;

    wire [7:0] OutALU_tb;
    wire [3:0] Flags_tb;

    part3_ALU ALU_inst (
        .A(A_tb),
        .B(B_tb),
        .FunSel(FunSel_tb),
        .clk(clk_tb),
        .OutALU(OutALU_tb),
        .Flags(Flags_tb)
    );

    always #5 clk_tb = ~clk_tb;

    initial begin

        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);

        A_tb = 8'b00000001;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b0000;
        clk_tb = 1'b0;
        #10;
        $display("FunSel 0000 OutALU: %b", OutALU_tb);
        $display("Flags: %b", Flags_tb);


        // Test ADD operation
        A_tb = 8'b00110011;
        B_tb = 8'b00001111;
        FunSel_tb = 4'b0100;
        #10;
        $display("ADD operation result: %b", OutALU_tb);
        $display("ADD operation flags: %b", Flags_tb);

        // Test SUB operation
        A_tb = 8'b00000111;
        B_tb = 8'b11111010;
        FunSel_tb = 4'b0101;
        #10;
        $display("SUB operation result: %b", OutALU_tb);
        $display("SUB operation flags: %b", Flags_tb);
        
        // Test Compare operation
        A_tb = 8'b01000000;
        B_tb = 8'b00111000;
        FunSel_tb = 4'b0110;
        #10;
        $display("Compare operation result: %b", OutALU_tb);
        $display("Compare operation flags: %b", Flags_tb);
        // Test AND operation
        A_tb = 8'b10101010;
        B_tb = 8'b11110000;
        FunSel_tb = 4'b0111;
        #10;
        $display("AND operation result: %b", OutALU_tb);
        $display("AND operation flags: %b", Flags_tb);

        // Test OR operation
        A_tb = 8'b10101010;
        B_tb = 8'b11110000;
        FunSel_tb = 4'b1000;
        #10;
        $display("OR operation result: %b", OutALU_tb);
        $display("OR operation flags: %b", Flags_tb);

        // Test XOR operation
        A_tb = 8'b10101010;
        B_tb = 8'b11110000;
        FunSel_tb = 4'b1010;
        #10;
        $display("XOR operation result: %b", OutALU_tb);
        $display("XOR operation flags: %b", Flags_tb);

        // Test LSL operation
        A_tb = 8'b00110011;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1011;
        #10;
        $display("LSL operation result: %b", OutALU_tb);
        $display("LSL operation flags: %b", Flags_tb);

        // Test LSR operation
        A_tb = 8'b00110011;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1100;
        #10;
        $display("LSR operation result: %b", OutALU_tb);
        $display("LSR operation flags: %b", Flags_tb);

        // Test ASL
        A_tb = 8'b10000000;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1101;
        #10;
        $display("ASL operation result: %b", OutALU_tb);
        $display("ASL operation flags: %b", Flags_tb);

        // Test ASR operation
        A_tb = 8'b00110011;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1110;
        #10;
        $display("ASR operation result: %b", OutALU_tb);
        $display("ASR operation flags: %b", Flags_tb);

        // Test CSR operation
        A_tb = 8'b10000000;
        B_tb = 8'b00000000;
        FunSel_tb = 4'b1111;
        #10;
        $display("CSR operation result: %b", OutALU_tb);
        $display("CSR operation flags: %b", Flags_tb);

        #50;

        // Finish simulation
        $finish;
end
endmodule


`timescale 1ns / 1ps
`include "part4.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2023 01:16:48 AM
// Design Name: 
// Module Name: TestBench
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
module Project1Test();
    //Input Registers of ALUSystem
    reg[2:0] RF_O1Sel; 
    reg[2:0] RF_O2Sel; 
    reg[1:0] RF_FunSel;
    reg[3:0] RF_RSel;
    reg[3:0] RF_TSel;
    reg[3:0] ALU_FunSel;
    reg[1:0] ARF_OutASel; 
    reg[1:0] ARF_OutBSel; 
    reg[1:0] ARF_FunSel;
    reg[3:0] ARF_RSel;
    reg      IR_LH;
    reg      IR_Enable;
    reg[1:0]      IR_FunSel;
    reg      Mem_WR;
    reg      Mem_CS;
    reg[1:0] MuxASel;
    reg[1:0] MuxBSel;
    reg MuxCSel;
    reg      Clock;
    
    //Test Bench Connection of ALU System
    ALUSystem _ALUSystem(
    .RF_O1Sel(RF_O1Sel), 
    .RF_O2Sel(RF_O2Sel), 
    .RF_FunSel(RF_FunSel),
    .RF_RSel(RF_RSel),
    .RF_TSel(RF_TSel),
    .ALU_FunSel(ALU_FunSel),
    .ARF_OutASel(ARF_OutASel), 
    .ARF_OutBSel(ARF_OutBSel), 
    .ARF_FunSel(ARF_FunSel),
    .ARF_RSel(ARF_RSel),
    .IR_LH(IR_LH),
    .IR_Enable(IR_Enable),
    .IR_FunSel(IR_FunSel),
    .Mem_WR(Mem_WR),
    .Mem_CS(Mem_CS),
    .MuxASel(MuxASel),
    .MuxBSel(MuxBSel),
    .MuxCSel(MuxCSel),
    .Clock(Clock)
    );
    
    //Test Vector Variables
    reg [41:0] VectorNum, Errors, TotalLine; 
    reg [41:0] TestVectors[999:0];
    reg Reset, Operation;
    initial begin
        Reset = 0;
    end
    //Clock Signal Generation
    always 
    begin
        Clock = 1; #5; Clock = 0; #5; // 10ns period
    end
    
    //Read Test Bench Values
    initial begin
        $readmemb("TestBench.mem", TestVectors); // Read vectors
        VectorNum = 0; Errors = 0; TotalLine=0; Reset=0;// Initialize
    end
    
    // Apply test vectors on rising edge of clock
    always @(posedge Clock)
    begin
        {Operation, RF_O1Sel, RF_O2Sel, RF_FunSel, 
        RF_RSel, RF_TSel, ALU_FunSel, ARF_OutASel, ARF_OutBSel, 
        ARF_FunSel, ARF_RSel, IR_LH, IR_Enable, IR_FunSel, 
        Mem_WR, Mem_CS, MuxASel, MuxBSel, MuxCSel} = TestVectors[VectorNum];
    end
    
    // Check results on falling edge of clk
    always @(negedge Clock)
        if (~Reset) // skip during reset
        begin
            $display("Input Values:");
            $display("Operation: %d", Operation);
            $display("Register File: O1Sel: %d, O2Sel: %d, FunSel: %d, RSel: %d, TSel: %d", RF_O1Sel, RF_O2Sel, RF_FunSel, RF_RSel, RF_TSel);            
            $display("ALU FunSel: %d", ALU_FunSel);
            $display("Addres Register File: OutASel: %d, OutBSel: %d, FunSel: %d, Regsel: %d", ARF_OutASel, ARF_OutBSel, ARF_FunSel, ARF_RSel);            
            $display("Instruction Register: LH: %d, Enable: %d, FunSel: %d", IR_LH, IR_Enable, IR_FunSel);            
            $display("Memory: WR: %d, CS: %d", Mem_WR, Mem_CS);
            $display("MuxASel: %d, MuxBSel: %d, MuxCSel: %d", MuxASel, MuxBSel, MuxCSel);
            
            $display("");
            $display("Output Values:");
            $display("Register File: AOut: %d, BOut: %d", _ALUSystem.RF_O1, _ALUSystem.RF_O2);            
            $display("ALUOut: %d, ALUOutFlag: %d, ALUOutFlags: Z:%d, C:%d, N:%d, O:%d,", _ALUSystem.ALU_Out, _ALUSystem.ALU_FlagOut, _ALUSystem.ALU_FlagOut[3],_ALUSystem.ALU_FlagOut[2],_ALUSystem.ALU_FlagOut[1],_ALUSystem.ALU_FlagOut[0]);
            $display("Address Register File: AOut: %d, BOut (Address): %d", _ALUSystem.ARF_OutA, _ALUSystem.ARF_OutB);            
            $display("Memory Out: %d", _ALUSystem.MemOut);            
            $display("Instruction Register: IROut: %d", _ALUSystem.IR_Out);            
            $display("MuxAOut: %d, MuxBOut: %d, MuxCOut: %d", _ALUSystem.MuxAOut, _ALUSystem.MuxBOut, _ALUSystem.MuxCOut);

            $display("\n--------------------------------------------\n");
            
            // increment array index and read next testvector
            VectorNum = VectorNum + 1;
            if (TestVectors[VectorNum] === 42'bx)
            begin
                $display("%d tests completed.",
                VectorNum);
                $finish; // End simulation
            end
        end
endmodule

