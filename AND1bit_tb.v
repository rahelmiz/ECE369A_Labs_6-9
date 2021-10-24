`timescale 1ns / 1ps

module AND1bit_tb(    );
    reg A, B;
    wire Out;
    
    AND1bit a1(A, B, Out);
    
    initial
    begin
        A <= 0; B <= 0;
        #10;
        A <= 1; B <= 0;
        #10;
        A <= 0; B <= 1;
        #10;
        A <= 1; B <= 1;
        #10;
    end
endmodule
