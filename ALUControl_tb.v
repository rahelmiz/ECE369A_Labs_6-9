`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2021 07:14:57 PM
// Design Name: 
// Module Name: ALUControl_tb
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


module ALUControl_tb();
reg [5:0] Opcode_tb;
reg [5:0] funct_tb;
wire [3:0] ALUOp_tb;
ALUControl ac(.Opcode(Opcode_tb), .funct(funct_tb), .ALUOp(ALUOp_tb));

initial begin
//test when opcode = 00000
 //  @(posedge Clk)
    Opcode_tb = 6'b0; 
    funct_tb = 6'b100011;
    if (ALUOp_tb != 4'b0010)begin
        $display("expected 0010 \n got: %4b", ALUOp_tb);
    end
    #5
    
 //   @(posedge Clk)
    funct_tb = 6'b101000;
    if (ALUOp_tb != 4'b0010 )begin
        $display("expected 0010 \n got: %4b", ALUOp_tb);
    end
    #5
    //ITYPE TESTS
 //   @(posedge Clk)
    Opcode_tb = 6'b001100; funct_tb = 6'b0;
    if (ALUOp_tb != 4'b0000 ) begin
       $display("expected 0000 \n got: %4b", ALUOp_tb);
    end
    #5
    
  //  @(posedge Clk)
    Opcode_tb = 6'b000101; funct_tb = 6'b0;
    if (ALUOp_tb != 4'b0110  ) begin
        $display("expected 0110 \n got: %4b", ALUOp_tb);
    end
    
 end 
endmodule
