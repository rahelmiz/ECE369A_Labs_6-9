`timescale 1ns / 1ps

module MaskLoad_tb( );
    reg [31:0] MemData;
    reg [1:0] MemAdr, Bytes2Store;
    wire [31:0] out;
    MaskLoad ml(MemAdr, MemData, Bytes2Store, out);

    initial begin
        MemData = 32'h0ACFFB19;
        Bytes2Store = 2'd0;  //testing lw
        MemAdr = 2'b0;
        #10;
        MemAdr = 2'd3;
        #10;
        Bytes2Store = 2'd2;  //testing lh
        MemAdr = 2'b0;
        #10;
        MemAdr = 2'd1;
        #10;
        MemAdr = 2'd2;
        #10;
        MemAdr = 2'd3;
        #10;
         Bytes2Store = 2'd1;  //testing lb
        MemAdr = 2'b0;
        #10;
        MemAdr = 2'd1;
        #10;
        MemAdr = 2'd2;
        #10;
        MemAdr = 2'd3;
        #10;
    end
endmodule
