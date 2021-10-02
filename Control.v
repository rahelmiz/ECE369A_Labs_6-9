`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// DESCRIPTION
//////////////////////////////////////////////////////////////////////////////////

module Control(Op, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite );
input [5:0] Op;
output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite ;
output [1:0] ALUOp;

always @(Op) begin
    if (Op >= 3) begin //then it's an I-Type
        //ALUOp = ; Need to determine encoding for shift operation.
    end
endmodule
