`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);
    //do a for loop, and increment address by 4 every 2 nano-seconds. 
    integer i;
    initial begin
        #2;
        Address <= 0;
        #10
        for (i = 0; i < 20; i = i + 1) begin
        Address <= Address + 4;    
		//$display("memory[i]: ", memory[i]);
	    #10;
	    end
     end 
endmodule
