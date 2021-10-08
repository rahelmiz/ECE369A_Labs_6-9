`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// DESCRIPTION
//////////////////////////////////////////////////////////////////////////////////



module Control(Op, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite );
  input [5:0] Op;
  output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite ;
  output [2:0] ALUOp;

always @(Op) begin
  case (Op):
    //if opcode is any of the below, instr. is r-type
    6'b000000: Op = 2'b00;
    6'b011111: Op = 2'b00;
    6'b011100: Op = 2'b00;
    //case 2: Instr > 0; 
    
endmodule
