`timescale 1ns / 1ps

module HazardDetection(    
    ID_EX_MemRead, ID_EX_RegWrite, EX_MEM_RegWrite, MEM_WB_RegWrite,
    IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, ID_EX_Rd, IF_ID_Rs, IF_ID_Rt, EX_MEM_Rd, MEM_WB_Rd,
    stall_ID_EX, stall_EX_MEM, stall_MEM_WB,
    IF_ID_Write, PCWrite, IF_Flush 
    );
    
    input ID_EX_MemRead, ID_EX_RegWrite, EX_MEM_RegWrite, MEM_WB_RegWrite;
    input [4:0] IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, ID_EX_Rd, IF_ID_Rs, IF_ID_Rt, EX_MEM_Rd, MEM_WB_Rd;
    output reg stall_ID_EX, stall_EX_MEM, stall_MEM_WB; // 1 to stall/insert zeros
    output reg IF_ID_Write, PCWrite, IF_Flush; // 1 means to do the action implied 
    
    initial begin
    //nothin yet
    end
    
    always @(*) begin
    //fix what would normally be caught by forwarding
    //r-type followed by another r-type
    if((ID_EX_RegWrite == 1) && ((ID_EX_Rd == IF_ID_Rs) | (ID_EX_Rd == IF_ID_Rt))) begin
        stall_ID_EX = 1;
        stall_EX_MEM = 0;
        stall_MEM_WB = 0;
        IF_ID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    if((EX_MEM_RegWrite == 1) && ((EX_MEM_Rd == IF_ID_Rs) | (EX_MEM_Rd == IF_ID_Rt))) begin
        stall_ID_EX = 0;
        stall_EX_MEM = 1;
        stall_MEM_WB = 0;
        IF_ID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    if((MEM_WB_RegWrite == 1) && ((MEM_WB_Rd == IF_ID_Rs) | (MEM_WB_Rd == IF_ID_Rt))) begin
        stall_ID_EX = 0;
        stall_EX_MEM = 0;
        stall_MEM_WB = 1;
        IF_ID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    //i-type followed by any other
    
    //normal hazard detection
    //lw
    if(ID_EX_MemRead==1 && ((IF_ID_Rs==ID_EX_Rt) | (IF_ID_Rt==ID_EX_Rt))) begin
        stall_ID_EX = 1;
        stall_EX_MEM = 0;
        stall_MEM_WB = 0;
        IF_ID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    
    end
endmodule
