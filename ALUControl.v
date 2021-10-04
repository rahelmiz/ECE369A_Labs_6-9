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
                    case 100100: ALUOp = 0001 //or corresponds to or
                    case 100111: ALUOp = 0111 //not corresponds to nor
                    case 100110: ALUOp = 0011 //xor corresponds to xor
                    case 000000: ALUOp = 0100 //shift left corresponds to sll
                    case 000010: ALUOp = 0101 // shift right corresponds to srl
                    case 000100: ALUOp = 0100 //shift left corresponds to sllv
                    case 000110: ALUOp = 0101 // shift right corresponds to srlv
                    case 101010: ALUOp = 0110 // sub corresponds to slt
                    case 001011: ALUOp = 0110 // sub corresponds to movn
                    case 001010: ALUOp = 0110 // sub corresponds to movz
                    case 000011: ALUOp = 0100 // shift right corresponds to sra
                    case 000111: ALUOp = 0100 // shift right corresponds to srav
                    case 101001: ALUOp = 0110 //sub corresponds to sltu
                    case 100011: ALUOp = 0010 // add corresponds to lw
                    case 101011: ALUOp = 0010 // add corresponds to sw
                    case 101000: ALUOp = 0010 // add corresponds to sb
                    case 100001: ALUOp = 0010 // add corresponds to lh
                    case 100000: ALUOp = 0010 // add corresponds to lb
                    case 101001: ALUOp = 0010 // add corresponds to sh
                    case 010001: ALUOp = 0000 // or corresponds to mthi 
                    case 010011: ALUOp = 0001// or corresponds to mtlo
                    case 010000: ALUOp = 0001// or corresponds to mfhi
                    case 010010: ALUOp = 0001// or corresponds to mfhi
                    case 100000: ALUOp = 0010 // add corresponds to add
                    case 100001: ALUOp = 0010 // add corresponds to addu
                    case 100010: ALUOp = 0110 //sub corresponds to sub
                    case 000010: ALUOp = 1111 //multiply corresponds to mul
                    case 011000: ALUOp = 1111 //multiply corresponds to mult
                    case 011001: ALUOp = 1111 //multiply corresponds to multu
                    endcase
                case 011111: //it's a weird R-type instruction: either seh or sel 
                  ALUOp = 0000 //both seh and sel correspond to and
                endcase 
                case 011100: //it's madd or sub
                    ALUOp = 1111//multiply 
                endcase 
        //end case for all R-type instructions. 
        endcase 
    end 
    
endmodule
