`timescale 1ns / 1ps

module mux5bits_3x1_tb(   );
    reg [4:0] A, B, C;
    reg [1:0] signal;
    wire [4:0] Out;
    
    mux5bits_3x1 muxTB(signal, A, B, C, Out);
    
    initial
    begin
        //set values
        A <= 5'd5;
        B <= 5'd7;
        C <= 5'd9;
        //test each signal
        signal <= 2'd0;
        #10;
        signal <= 2'd1;
        #10;
        signal <= 2'd2;
        #10;
        signal <= 2'd3;
        #10;
    end
endmodule
