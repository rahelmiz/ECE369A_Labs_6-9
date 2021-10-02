`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 05:13:48 PM
// Design Name: 
// Module Name: Control
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


module Control(Op, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite );
input [5:0] Op;
output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite ;
output [1:0] ALUOp;

always @(Op) begin
    if (Op >= 3) begin //then it's an I-Type
        //ALUOp = ; Need to determine encoding for shift operation.
    end
endmodule
