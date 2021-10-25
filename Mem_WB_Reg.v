`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 08:26:06 AM
// Design Name: 
// Module Name: Mem_WB_Reg
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


module MEM_WB_Reg(
    MemToRegIn, LoadDataIn, ALUResultIn, RegWriteIn,
    ALU64ResultIn,HiSrcIn,LoSrcIn,LinkIn,RegDstIn, PC4In,
    MemToRegOut, LoadDataOut, ALUResultOut, RegWriteOut,
    ALU64ResultOut,HiSrcOut,LoSrcOut,LinkOut,RegDstOut, PC4Out,
    //Clock
    Clk
    );
    //Inputs
    input[31:0] LoadDataIn,ALUResultIn, PC4In;
    input[63:0] ALU64ResultIn;
    input MemToRegIn,RegWriteIn,HiSrcIn,LoSrcIn,LinkIn;
    input [1:0] RegDstIn;
    input Clk;
    //Outputs
    output reg[31:0] LoadDataOut,ALUResultOut, PC4Out;
    output reg [63:0] ALU64ResultOut;
    output reg MemToRegOut,RegWriteOut,HiSrcOut,LoSrcOut,LinkOut;
    output reg [1:0] RegDstOut;
    //Memory declarations
    reg[31:0] LoadData, ALUResult, PC4;
    reg[63:0] ALU64Result;
    reg MemToReg,RegWrite,HiSrc,LoSrc,Link;
    reg [1:0] RegDst;
    //Write declarations
    always @(posedge Clk) begin
    LoadData <= LoadDataIn; //Comes from stage 4
    ALUResult <= ALUResultIn; //Comes from stage 3, goes thru 4
    PC4 <= PC4In; //Comes from stage 2, goes thru 3 and 4
    ALU64Result <= ALU64ResultIn; //Comes from stage 3, goes thru 4
    MemToReg <= MemToRegIn; //Comes from stage 2, goes thru 3 and 4
    RegWrite <= RegWriteIn; //Comes from stage 2, goes thru 3 and 4
    HiSrc <= HiSrcIn; //Comes from stage 2, goes thru 3 and 4
    LoSrc <= LoSrcIn; //Comes from stage 2, goes thru 3 and 4
    Link <= LinkIn; //Comes from stage 2, goes thru 3 and 4
    RegDst <= RegDstIn; //Comes from stage 2, goes thru 3 and 4
    end
    //Read declarations
    always @(*) begin
    LoadDataOut <= LoadData; //Used when loading
    ALUResultOut <= ALUResult; //Used when storing ALU Result into register
    PC4Out <= PC4; //Goes as possible input to $Ra
    ALU64ResultOut <= ALU64Result; //Used for special HiLo operations
    MemToRegOut <= MemToReg; //Chooses between ALUResult and LoadData
    RegWriteOut <= RegWrite; //Control signal for writing to register
    HiSrcOut <= HiSrc; //Chooses source for Hi input between ALU64Result and ALUResult
    LoSrcOut <= LoSrc; //Chooses source for lo input between ALU64Result and ALUResult
    LinkOut <= Link; //Chooses write data between ALU64Result and PC + 4
    RegDstOut <= RegDst; //Chooses register to store results in
    
    end
endmodule