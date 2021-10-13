`timescale 1ns / 1ps


module ALUControl(Opcode, funct, I21,I6, ALUOp);
    input [5:0] Opcode;
    input [5:0] funct; 
    input I21, I6;                                     
    output reg [3:0] ALUOp;
    always @(*) begin
    //first check for the special cases
         if (Opcode ==6'b0 && funct == 6'b000010) begin //it's a rotate or shift
             case (I21)
                1'b0: ALUOp = 5'b00101;//shift right
                1'b1: ALUOp = 5'b01001; //rotate right
             endcase
         end
         else if () begin
         end
        if (Opcode == 6'b0) begin
                case (funct)//which R-type?
                     6'b100100: ALUOp = 5'b00001; //or corresponds to or
                     6'b100111: ALUOp = 5'b00111; //not corresponds to nor
                     6'b100110: ALUOp = 5'b00011; //xor corresponds to xor
                     6'b000000: ALUOp = 5'b00100; //shift left corresponds to sll
                     
                     6'b000100: ALUOp = 5'b00100;//shift left corresponds to sllv
                     6'b000110: ALUOp = 5'b00101; // shift right corresponds to srlv
                     6'b101010: ALUOp = 5'b00110 ;// sub corresponds to slt
                     6'b001011: ALUOp = 5'b00110; // sub corresponds to movn
                     6'b001010: ALUOp = 5'b00110; // sub corresponds to movz
                     6'b000011: ALUOp = 5'b00100; // shift right corresponds to sra
                     6'b000111: ALUOp = 5'b00100; // shift right corresponds to srav
                     6'b101001: ALUOp = 5'b00110; //sub corresponds to sltu
                     6'b100011: ALUOp = 5'b00010; // add corresponds to lw
                     6'b101011: ALUOp = 5'b00010; // add corresponds to sw
                     6'b101000: ALUOp = 5'b00010; // add corresponds to sb
                     6'b100001: ALUOp = 5'b00010; // add corresponds to lh
                     6'b100000: ALUOp = 5'b00010; // add corresponds to lb
                     6'b101001: ALUOp = 5'b00010; // add corresponds to sh
                     6'b010001: ALUOp = 5'b00000; // or corresponds to mthi 
                     6'b010011: ALUOp = 5'b00001;// or corresponds to mtlo
                     6'b010000: ALUOp = 5'b00001;// or corresponds to mfhi
                     6'b010010: ALUOp = 5'b00001;// or corresponds to mfhi
                     6'b100000: ALUOp = 5'b00010; // add corresponds to add
                     6'b100001: ALUOp = 5'b00010; // add corresponds to addu
                     6'b100010: ALUOp = 5'b00110; //sub corresponds to sub
                     6'b000010: ALUOp = 5'b01111; //multiply corresponds to mul
                     6'b011000: ALUOp = 5'b01111; //multiply corresponds to mult
                     6'b011001: ALUOp = 5'b01111 ;//multiply corresponds to multu
                     6'b001000: ALUOp = 5'b00010 ;// add corresponds to jr
                    
                endcase //endcase for all R-TYPE instructions with opcode = 000000
             end 
             
             else begin
                 case (Opcode) 
                     6'b011111: ALUOp = 5'b00000; //both seh and sel correspond to and
                     6'b011100: ALUOp = 5'b01111;//multiply corresponds to madd and msub  
                   
                    //J-TYPE INSTRUCTIONS
                     6'b000010: ALUOp = 5'b00010; // add corresponds to jump
                     6'b000011: ALUOp = 5'b00010; // add corresponds to jal
                    
                    // I-TYPE INSTRUCTIONS
                     6'b001100: ALUOp = 5'b00000; //AND corresponds to andi
                     6'b001101: ALUOp = 5'b00001; //OR corresponds to ori
                     6'b001110: ALUOp = 5'b00011; //XOR corresponds to xori
                     6'b001010: ALUOp = 5'b00110 ;//sub corresponds to slti
                     6'b001011: ALUOp = 5'b00110 ;//sub corresponds to sltiu
                     6'b001111: ALUOp = 5'b00010 ;// add corresponds to lui
                     6'b000001: ALUOp = 5'b00110 ;//sub corresponds to bgez
                     6'b000100: ALUOp = 5'b00110; //sub corresponds to beq
                     6'b000101: ALUOp = 5'b00110; //sub corresponds to bne
                     6'b000111: ALUOp = 5'b00110; //sub corresponds to bgtz
                     6'b000110: ALUOp = 5'b00110; //sub corresponds to blez
                     6'b000001: ALUOp = 5'b00110 ;//sub corresponds to bltz
                     6'b100001: ALUOp = 5'b00010 ;// add corresponds to addiu
                     6'b001000: ALUOp = 5'b00010; // add corresponds to addi
                 endcase
             end 
    end 
endmodule
