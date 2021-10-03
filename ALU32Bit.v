`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0

    /* Please fill in the implementation here... */
    assign Zero = (ALUResult==0); //zero is true if ALUResult is zero
    always @(ALUControl, A, B) begin
        case (ALUControl)
            0: ALUResult <= A & B; //and
            1: ALUResult <= A | B; //or
            2: ALUResult <= A + B; //add
            3: ALUResult <= A; //xor FIXME
            4: ALUResult <= A & B; //sll FIXME
            5: ALUResult <= A & B; //srl FIXME
            6: ALUResult <= A - B; //subtract
            7: ALUResult <= A < B ? 1 : 0; //slt
            8: ALUResult <= A & B; //rotate left FIXME
            9: ALUResult <= A & B; //rotate right FIXME
            12: ALUResult <= ~(A | B); //nor
            14: ALUResult <= -1; //error ?FIXME?
            15: ALUResult <= A * B; //multiply
            default: ALUResult <= 0;
        endcase
    end

endmodule
