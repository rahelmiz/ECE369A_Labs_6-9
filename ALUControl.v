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


module ALUControl(Opcode, funct, Op);
    input [5:0] Op;
    input [5:0] funct;                                      
    output  reg [3:0] ALUOp;
    always @(*) begin
        case (Opcode):
            case 000000: //it's an R-Type
                case (func)://which R-type?
                    case 100100: Op = 0000; //AND
                    case 100100: Op = 0001; //OR
                    endcase
                
        endcase 
    end 
    
endmodule
