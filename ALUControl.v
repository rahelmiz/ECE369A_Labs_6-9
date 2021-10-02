`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 04:50:07 PM
// Design Name: 
// Module Name: ALUControl
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
///////////////////////2///////////////////////////////////////////////////////////


module ALUControl(Op, funct, ALUOp);
    input [5:0] Op;
    input [5:0] funct;                                      
    output  reg [3:0] ALUOp;
    always @(*) begin
        if (Op == 0) begin //it's an r-type instruction. 
            if (funct == 0) begin
                ALUOp = 1; 
            end 
            else if (funct == 1)
                ALUOp = 1; 
            end 
    end 
    
endmodule
