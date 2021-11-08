`timescale 1ns / 1ps

module HazardDetection(    
    IDEX_MemRead, IDEX_RegWrite, EXMEM_RegWrite, MEMWB_RegWrite,
    IFID_Rs, IFID_Rt, IDEX_Rt, IDEX_Rd, IFID_Rs, IFID_Rt, EXMEM_Rd, MEMWB_Rd,
    stall_IDEX, stall_EXMEM, stall_MEMWB,
    IFID_Write, PCWrite, IF_Flush 
    );
    
    input IDEX_MemRead, IDEX_RegWrite, EXMEM_RegWrite, MEMWB_RegWrite;
    input [4:0] IFID_Rs, IFID_Rt, IDEX_Rt, IDEX_Rd, IFID_Rs, IFID_Rt, EXMEM_Rd, MEMWB_Rd;
    output reg stall_IDEX, stall_EXMEM, stall_MEMWB; // 1 to stall/insert zeros
    output reg IFID_Write, PCWrite, IF_Flush; // 1 means to do the action implied 
    
    initial begin
    //nothin yet
    end
    
    always @(*) begin
    //fix what would normally be caught by forwarding
    //r-type followed by another r-type
    if((IDEX_RegWrite == 1) && ((IDEX_Rd == IFID_Rs) | (IDEX_Rd == IFID_Rt))) begin
        stall_IDEX = 1;
        stall_EXMEM = 0;
        stall_MEMWB = 0;
        IFID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    if((EXMEM_RegWrite == 1) && ((EXMEM_Rd == IFID_Rs) | (EXMEM_Rd == IFID_Rt))) begin
        stall_IDEX = 0;
        stall_EXMEM = 1;
        stall_MEMWB = 0;
        IFID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    if((MEMWB_RegWrite == 1) && ((MEMWB_Rd == IFID_Rs) | (MEMWB_Rd == IFID_Rt))) begin
        stall_IDEX = 0;
        stall_EXMEM = 0;
        stall_MEMWB = 1;
        IFID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    //i-type followed by any other
    
    //normal hazard detection
    //lw
    if(IDEX_MemRead==1 && ((IFID_Rs==IDEX_Rt) | (IFID_Rt==IDEX_Rt))) begin
        stall_IDEX = 1;
        stall_EXMEM = 0;
        stall_MEMWB = 0;
        IFID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    
    end
endmodule
