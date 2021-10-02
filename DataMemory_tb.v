`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
    /* Please fill in the implementation here... */
    Address <= 32'b0;
    WriteData <= 32'b0; 
    MemWrite <= 0;
    MemRead <= 0;
	
	#2
	//write to memory
	WriteData <= 1; 
	MemWrite <= 1;
	#20
	WriteData <= 0;
	MemWrite <= 0;
	MemRead <= 1;
	#40
	MemRead <= 0;
	
	//write to memory
	#10 
	Address <= 4;
	WriteData <= 2;
	MemWrite <= 1;
	#20
	//read from memory
	MemWrite <= 0;
    MemRead <= 1;
    #20
    MemRead <= 0;
    
	end

endmodule
