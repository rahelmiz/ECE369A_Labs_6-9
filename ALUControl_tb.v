`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 03:51:56 PM
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
reg [5:0] Opcode, funct;
reg I21, I6, I16; 
wire [4:0] ALUOp;
integer f; 
reg [4:0] c;
ALUControl aluc(Opcode, funct, I21,I6, I16, ALUOp);
initial begin
    f = $fopen("ALUControl_tb.txt", "w+");
    $fwrite("BGEZ "); 
    I16 = 1'b1;  Opcode = 6'd1; c = 5'd18;
    if (ALUOp != c) begin //test bgtz
        $fwrite("got ALUOp = %2d\nexpected %2d", ALUOp,  c); end #5;
   
    I16 = 1'b0; c= 5'd12; 
    if (ALUOp != c) begin 
        $fwrite("got ALUOp = %2d\nexpected %2d", ALUOp,  c); end #5;
        
    
    Opcode = 6'd12; c = 6'd0; //test andi 
    if (ALUOp != c) begin 
        $fwrite("got ALUOp = %2d\nexpected %2d", ALUOp,  c); end #5;
    
    Opcode = 6'd0; funct = 6'd17; c = 5'd2; //test mthi
    if (ALUOp != c) begin 
        $fwrite("got ALUOp = %2d\nexpected %2d", ALUOp,  c); end #5;
    
    Opcode = 6'd28; funct = 6'd2; c = 5'd31; //test madd
    if (ALUOp != c) begin 
        $fwrite("got ALUOp = %2d\nexpected %2d", ALUOp,  c); end #5;
    
    Opcode = 6'b0; funct = 6'd2; I6 = 1'b1; c = 5'd9; //test rotr
      if (ALUOp != c) begin 
        $fwrite("got ALUOp = %2d\nexpected %2d", ALUOp,  c); end #5;
        
    Opcode = 6'b0; funct = 6'd6; I6 = 1'b0; c = 5'd5; //test srlv
      if (ALUOp != c) begin 
        $fwrite("got ALUOp = %2d\nexpected %2d", ALUOp,  c); end #5;
    $fclose(f);
end
endmodule
