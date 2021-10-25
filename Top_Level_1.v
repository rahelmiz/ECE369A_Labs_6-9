`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2021 04:58:00 AM
// Design Name: 
// Module Name: Top_Level_1
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


module Top_Level_1(Clk, Rst);
    //Clock input
    input Clk;
    input Rst;
    
    
    //BEGIN STAGE 1
    //Instruction memory
    wire[31:0] PCInput; //Input to PC, will reuse in stage 3
    wire[31:0] PC4_IF; //Will contain the value of PC + 4 Adder
    wire[31:0] PCResult; //Output of PC
    wire[31:0] Instruction_IF; //Instruction from first stage
    //ProgramCounter
    ProgramCounter PCounter(.Address(PCInput), .PCResult(PCResult), .Reset(Rst), .Clk(Clk));
    //InstructionMemory
    InstructionMemory Instructions(PCResult, Instruction_IF);
    //PCAdder/ PC + 4
    PCAdder PC4Adder(.PCResult(PCResult), .PCAddResult(PC4_IF));
    
    //Instantiate Pipeline Register between IF and Decode stage
    wire [31:0] Instruction_DEC, PC4_DEC; //Instruction and PC+4 used in DECODE stage
    FE_DEC_Reg Pipeline1(.InstructionIn(Instruction_IF), .PC4In(PC4_IF),
                        .InstructionOut(Instruction_DEC), .PC4Out(PC4_DEC),
                        .Clk(Clk) );
                        
    //STAGE 2
    //RegDst Mux
    wire [1:0] RegDst_WB; //Used in stage 5
    wire [4:0] RegDstOut; //Input to register
    Mux5bits_3x1 RegDstMux(RegDst_WB, Instruction_DEC[20:16], Instruction_DEC[15:11], 5'd31, 
                            RegDstOut);
    //Link Mux
    wire [31:0] WriteData_WB; //Write data from stage 5
    wire[31:0] PC4_WB; //PC + 4 from wb stage
    wire link_WB; //Link signal from stage 5
    wire [31:0] LinkOut; //Output from link mux into write data
    Mux32bits_2x1 WriteDataMux(link_WB, WriteData_WB, PC4_DEC, LinkOut);
    
    //Call Register File
    wire RegWrite_WB; // RegWrite signal from write back stage
    wire [31:0] ReadData1_DEC, ReadData2_DEC;
    RegisterFile Registers(Instruction_DEC[25:21], Instruction_DEC[20:16], RegDstOut, LinkOut, RegWrite_WB, 
                          Clk, ReadData1_DEC, ReadData2_DEC); 
                          
    //HILO REGISTER STUFF
    wire[63:0] ALU64Result_WB; //ALU64 Result from stage 5
    wire HiSrc_WB;
    wire LoSrc_WB;
    wire HiWrite_WB;
    wire LoWrite_WB;
    wire [31:0] HiIn; //Input to high, output of HiSrc Mux
    wire [31:0] LoIn; //Input to lo registor, output of LoSrc
    wire [31:0] Hi_DEC;
    wire [31:0] Lo_DEC;
    //HiSrc
    Mux32bits_2x1 HiSrcMux(HiSrc_WB, Write_Data_WB, ALU64Result_WB[63:32], HiIn);
    //LoSrc
    Mux32bits_2x1 LoSrcMux(LoSrc_WB, Write_Data_WB, ALU64Result_WB[31:0], LoIn);
    //Instantiate HiLoRegister
    HiLoRegisters HiLoRegister(HiIn, LoIn, HiWrite_WB, LoWrite_WB, Clk, Hi_DEC, Lo_DEC);
    
    //CONTROLLER Signal
    //1 bit signals
    wire link_DEC, jrSrc_DEC, 
         jump_DEC, branch_DEC, MemRead_DEC, 
         MemtoReg_DEC, MemWrite_DEC, ALUsrc1_DEC, 
         ALUsrc2_DEC, RegWrite_DEC,	
         HiWrite_DEC, LoWrite_DEC, HiSrc_DEC,
         LoSrc_DEC,	ZeroSrc_DEC, Move_DEC,	
         MoveSrc_DEC;
     //Two bit signals
     wire[1:0] RegDst_DEC, byte2load_DEC, byte2Store_DEC;
        
    Controller ControllerModule(Instruction_DEC[31:26], Instruction_DEC[5:0], Instruction_DEC[16],
                        RegDst_DEC,	link_DEC, jrSrc_DEC, 
                        jump_DEC, branch_DEC, MemRead_DEC, 
                        MemtoReg_DEC, MemWrite_DEC, ALUsrc1_DEC, 
                        ALUsrc2_DEC, RegWrite_DEC,	
                        HiWrite_DEC, LoWrite_DEC, HiSrc_DEC,
                        LoSrc_DEC,	ZeroSrc_DEC, Move_DEC,	
                        MoveSrc_DEC, bytes2load_DEC, bytes2store_DEC
                        );
    //ALU Control
    wire [4:0] ALUOp_DEC; //ALU Op in decode stage
    ALUControl ALUController(Instruction_DEC[31:26], Instruction_DEC[5:0], 
                            Instruction_DEC[21],Instruction_DEC[6], Instruction_DEC[16], ALUOp_DEC);
    
    //SignExtend Immediate
    wire [31:0] Immediate_DEC;
    SignExtension SignExtender(Instruction_DEC[15:0], Immediate_DEC);
    
    //Jump Address Calculation
    wire [27:0] shifted_Jump; //Used to calculate jump address, will be combined with PC4 later
    TwoShift28Bit({2'b00, Instruction_DEC[25:0]}, shifted_Jump);
    
    //DECODE-EXECUTE PIPELINE
    //Stage 3 wires
    wire [31:0] Shamt_EX, ReadData1_EX, ReadData2_EX, JAddress_EX, Immediate_EX;
    wire [63:0] HiLo_EX;
    wire ALUSrc1_EX, ALUSrc2_EX,MoveSrc_EX,ZeroSrc_EX,JrSrc_EX,
    Move_EX,Branch_EX;
    wire [4:0] ALUOp_EX;
    //Stage 3 + 5
    wire [31:0] PC4_EX;
    wire RegWrite_EX;
    //STAGE 4
    wire[1:0] bytes2Load_EX, bytes2Store_EX;
    wire MemRead_EX, MemWrite_EX;
    //STAGE 5
    wire MemToReg_EX, HiSrc_EX,LoSrc_EX,Link_EX;
    wire[1:0] RegDst_EX;
    wire Jump_EX;
    
    
    DEC_EX_Reg Pipeline2(
    //Stage 3 Requirements (not used in subsequent stages)
    {27'b0,Instruction_DEC[10:6]},ReadData1_DEC,ReadData2_DEC,Immediate_DEC,{PC4_DEC[31:28], shifted_Jump},
    {Hi_DEC, Lo_DEC},
    ALUSrc1_DEC, ALUSrc2_DEC,MoveSrc_DEC,ZeroSrc_DEC,JrSrc_DEC, Jump_DEC,
    Move_DEC,Branch_DEC,
    ALUOp_DEC,
    Shamt_EX,ReadData1_EX,ReadData2_EX,Immediate_EX,JAddress_EX,
    HiLo_EX,
    ALUSrc1_EX, ALUSrc2_EX,MoveSrc_EX,ZeroSrc_EX,JrSrc_EX, Jump_EX,
    Move_EX,Branch_EX,
    ALUOp_EX,
    //Stage 3 + 5
    PC4_DEC,
    PC4_EX,
    RegWrite_DEC,
    RegWrite_EX,
    //Stage 4 Requirements (not used in subsequent stages)
    bytes2Load_DEC, bytes2Store_DEC,
    MemRead_DEC, MemWrite_DEC,
    bytes2Load_EX, bytes2Store_EX,
    MemRead_EX, MemWrite_EX,
    //Stage 5 Requirements that we need to carry through
    MemToReg_DEC,
    HiSrc_DEC,LoSrc_DEC,Link_DEC,RegDst_DEC,
    MemToReg_EX,
    HiSrc_EX,LoSrc_EX,Link_EX,RegDst_EX,
    //Clock
    Clk
    );
    
    //STAGE 3 BEGIN
    //ALU Preparation
    wire[31:0] ALUSrc1Output, ALUSrc2Output; //Mux outputs
    Mux32bits_2x1 ALUSrc1Mux(ALUSrc1_EX,ReadData1_EX,Shamt_EX,ALUSrc1Output);
    Mux32bits_2x1 ALUSrc2Mux(ALUSrc2_EX,ReadData2_EX,Immediate_EX,ALUSrc2Output);
    
    //ALU Time
    wire [31:0] ALUResult_EX;
    wire [63:0] ALU64Result_EX;
    wire Zero;
    ALU32Bit THE_ALU(ALUOp_EX, ALUSrc1Output, ALUSrc2Ouptut, HiLo_EX, ALUResult_EX, Zero, ALU64Result_EX);
    
    //Compute move condition
    //Check if GPR[rt] == 0
    wire XOROutput;
    ZeroXOR MoveCheck(ReadData2_EX, XOROutput);
    //Use mux
    wire MoveMuxOutput;
    Mux1bit_2x1 MoveMux(MoveSrc_EX,XOROutput, ~XOROutput, MoveMuxOutput);
    //ANDgate for move
    wire moveANDOutput;
    AND1bit moveCheck(Move_EX, MoveMuxOutput, moveANDOutput);
    //Or gate
    wire trueRegWrite;
    OR1bit WriteOR(moveANDOutput, RegWrite_EX, trueRegWrite); //This is what goes into further stages
    
    //Branch instruction
    wire ZeroMuxOut;
    Mux1bit_2x1 ZeroMux(ZeroSrc_EX,Zero, ~Zero, ZeroMuxOut);
    //Branch and
    wire branchANDOut;
    AND1bit branchAnd(ZeroMuxOut, Branch_EX, branchANDOut);
    
    //Set up branch address
    //Shift Immediate by two
    wire [31:0] ShiftedImmediate;
    TwoShift32Bit(Immediate_EX, ShiftedImmediate); 
    //ADD ALU
    wire [31:0] branchAddress;
    ALU32Bit BranchADD(4'd2, PC4_EX, ShiftedImmediate, 64'b0, branchAddress, dummy, dummy2);
    
    wire [31:0] branchOutput;
    Mux32bits_2x1 BranchMux(branchANDOut, PC4_IF, branchAddress, branchOutput);
    wire [31:0] JumpOutput;
    Mux32bits_2x1 JumpMux(Jump_EX, branchOutput, JAddress_EX, JumpOutput); 
    Mux32bits_2x1 JrMux(JrSrc_EX, JumpOutput, ReadData1_EX, PCResult); //Connect back to our PC
    
    //STAGE 4 PIPELINE
    //Prepare
    //Stage 4
    wire [1:0] bytes2Load_MEM, bytes2Store_MEM;
    wire MemRead_MEM, MemWrite_MEM;
    //Stage 4 + 5
    wire [31:0] ALUResult_MEM;
    wire [1:0] RegDst_MEM;
    wire MemToReg_MEM, RegWrite_MEM, HiSrc_MEM, LoSrc_MEM, Link_MEM;
    wire [31:0] PC4_MEM;
    wire [63:0] ALU64Result_MEM;
    //begin rahel's section
     //STAGE 4 (MEM) PIPELINE
    //Prepare
    //Stage 4
    wire [1:0] bytes2Load_MEM, bytes2Store_MEM;
    wire MemRead_MEM, MemWrite_MEM;
    
    //instantiations 
    //control signals
    wire [31:0] ALUResult_MEM;
    wire [1:0] RegDst_MEM;
    wire MemToReg_MEM, RegWrite_MEM, HiSrc_MEM, LoSrc_MEM, Link_MEM;
    wire [31:0] PC4_MEM
    wire [63:0] ALU64Result_MEM;
    wire [1:0] bytes2Load_EX, bytes2Store_EX;
    wire MemRead_EX, MemWrite_EX;
    //data
    wire [31:0] out_MEM, MemData_MEM, RegData_MEM;
    // DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 
    MaskStore ms_MEM(.MemAdr(ALUResult_MEM), .MemData(MemData_MEM), .Bytes2Load(bytes2Load_EX), .out(out_MEM));
    DataMemory dm_MEM(.Address(ALUResult_MEM), .WriteData(out_MEM), .Clk(Clk), .MemWrite(MemWrite_EX), .MemRead(MemRead_EX), .ReadData(RegData_MEM)); 
    MaskLoad ml_MEM
    
    //end rahel's section
    EX_MEM_Reg Pipeline3(
    //Stage 4 Requirements (not used in subsequent stages)
    bytes2Load_EX, bytes2Store_EX,
    MemRead_EX, MemWrite_EX,
    bytes2Load_MEM, bytes2Store_MEM,
    MemRead_MEM, MemWrite_MEM,
    //Stage 4 + 5 (used in both)
    ALUResult_EX,
    ALUResult_MEM,
    //Stage 5 Requirements that we need to carry through
    MemToReg_EX, RegWrite_EX,
    ALU64Result_EX,HiSrc_EX,LoSrc_EX,Link_EX,RegDst_EX, PC4_EX,
    MemToReg_MEM, RegWrite_MEM,
    ALU64Result_MEM,HiSrc_MEM,LoSrc_MEM,Link_MEM,RegDst_MEM, PC4_MEM,
    //Clock
    Clk
    );
    
endmodule
