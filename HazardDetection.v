`timescale 1ns / 1ps
// Opcodes for
// lw  = 6'd35      lw rt, imm(rs) # rt = mem[imm + rs]
// jr = 6'd0
// beq = 6'd5

module HazardDetection(    
    IFID_Rs, IFID_Rt, //separate stages on sepeare lines , and registers are alphabetically aranged
    IDEX_Rt, IDEX_Rd, IDEX_MemRead, IDEX_RegWrite,
    EXMEM_Rd, EXMEM_Rt, EXMEM_MemRead, EX_MEM_RegWrite,
    MEMWB_Rd, MEMWB_Rt, MEMWB_MemRead,  MEMWB_RegWrite, 
    Op, jump, branch,  //inputs
    stall_IDEX, stall_EX_MEM, stall_MEMWB, //outputs
    IFID_Write, PCWrite, IF_Flush 
    );
    
    input IDEX_MemRead, IDEX_RegWrite,
    EXMEM_MemRead, EX_MEM_RegWrite,
    MEMWB_MemRead,  MEMWB_RegWrite;
    
    input [4:0] IFID_Rs, IFID_Rt,
    IDEX_Rd, IDEX_Rt, 
    EXMEM_Rd, EXMEM_Rt, 
    MEMWB_Rd, MEMWB_Rt; 
    
    
    input [5:0] Op;
    input  jump, branch;
    output reg stall_IDEX, stall_EX_MEM, stall_MEMWB; // 1 to stall/insert zeros
    output reg IFID_Write, PCWrite, IF_Flush; // 1 means to do the action implied 
    
    initial begin
    //nothin yet
    end
    
    always @(*) begin
    //fix what would normally be caught by forwarding
    //r-type followed by another r-type
    if((IDEX_RegWrite == 1) && ((IDEX_Rd == IFID_Rs) | (IDEX_Rd == IFID_Rt))) begin
        stall_IDEX = 1;
        stall_EX_MEM = 0;
        stall_MEMWB = 0;
        IFID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    if((EX_MEM_RegWrite == 1) && ((EXMEM_Rd == IFID_Rs) | (EXMEM_Rd == IFID_Rt))) begin
        stall_IDEX = 0;
        stall_EX_MEM = 1;
        stall_MEMWB = 0;
        IFID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    if((MEMWB_RegWrite == 1) && ((MEMWB_Rd == IFID_Rs) | (MEMWB_Rd == IFID_Rt))) begin
        stall_IDEX = 0;
        stall_EX_MEM = 0;
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
        stall_EX_MEM = 0;
        stall_MEMWB = 0;
        IFID_Write = 0;
        PCWrite = 0;
        IF_Flush = 0;
    end
    
   
    
    
    //RAHEL'S CASES BEGIN
    //lw followed by jump
    if (jump == 1 && IDEX_MemRead == 1 &&  IFID_Rs == IDEX_Rt) begin
        stall_IDEX = 1;
        stall_EX_MEM = 0;
        stall_MEMWB = 0;
        IFID_Write = 0; PCWrite = 0; IF_Flush = 0;
    end
    // F    EX   MEM
    //JUMP NOP   LW 
    else if (jump == 1 && EXMEM_MemRead == 1 &&  IFID_Rs == EXMEM_Rt) begin 
        stall_IDEX = 1; // DO WE ZERO THIS OUT?
        stall_EX_MEM = 1;
        stall_MEMWB = 0;
        IFID_Write = 0; PCWrite = 0; IF_Flush = 0;
    end
    
    else if (jump == 1 && MEMWB_MemRead == 1 &&  IFID_Rs == MEMWB_Rt) begin 
        stall_IDEX = 1; // DO WE ZERO THIS OUT?
        stall_EX_MEM = 1; // DO WE ZERO THIS OUT?
        stall_MEMWB = 1; 
        IFID_Write = 0; PCWrite = 0; IF_Flush = 0;
    end
        
    //RAHEL'S CASES END
    end
endmodule
