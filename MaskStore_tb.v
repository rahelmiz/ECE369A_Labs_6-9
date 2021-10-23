`timescale 1ns / 1ps


module MaskStore_tb();
    integer f;
    reg [31:0]  MemData, RegData;
    reg [1:0] MemAdr, Bytes2Store;
    wire [31:0] out;
MaskStore ms(MemAdr, MemData, RegData , Bytes2Store, out);

initial begin
    RegData = 32'h0FFAC;
    MemData = 32'h0ACFFB19;
    f = $fopen("MaskStore_tb.txt", "w+");
     //testing default case. expect out = regdata
     Bytes2Store = 2'd3;  //test sw
         MemAdr = 2'b0; 
         if (out != RegData) begin 
                $fwrite(f, "testing sw: Bytes2Store = %2d, MemAdr =%2d \n",Bytes2Store, MemAdr ); 
                $fwrite(f,"out =     %32b \n" , out);
                $fwrite(f,"expected: %32b \n" ,RegData); 
                $fwrite("\n");
                end #5;
          MemAdr = 2'd4;
          if (out != RegData) begin 
                $fwrite(f,"testing sw: Bytes2Store = %2d, MemAdr =%2d \n",Bytes2Store, MemAdr ); 
                $fwrite(f,"out =     %32b \n" , out);
                $fwrite(f,"expected: %32b \n" ,RegData); 
                $fwrite("\n");
                end #5;
            
       Bytes2Store = 2'b1; //test sb: 
           MemAdr = 2'd0;
            if (out != {MemData[31:8],  RegData[7:0]}) begin 
               $fwrite(f,"testing sb: Bytes2Store = %2d, MemAdr =%2d\n ",Bytes2Store, MemAdr ); 
               $fwrite(f,"out =     %32b\n " , out);
               $fwrite(f,"expected: %32b\n" ,{MemData[31:8],  RegData[7:0]}); 
               $fwrite("\n");
            end #5;
            
            MemAdr = 2'd1;
            if (out != {MemData[31:16], RegData[7:0], MemData[7:0] }) begin 
               $fwrite(f,"testing sb: Bytes2Store = %2d, MemAdr =%2d \n",Bytes2Store, MemAdr );
               $fwrite(f,"out =     %32b \n" , out);
               $fwrite(f,"expected: %32b\n" ,{MemData[31:16], RegData[7:0], MemData[7:0] }); 
               $fwrite("\n");
           end #5;
           
           MemAdr = 2'd2;
            if (out != {MemData[31:16], RegData[7:0], MemData[7:0] }) begin 
               $fwrite(f,"testing sb: Bytes2Store = %2d, MemAdr =%2d \n",Bytes2Store, MemAdr );
               $fwrite(f,"out =     %32b \n" , out);
               $fwrite(f,"expected: %32b\n" ,{MemData[31:16], RegData[7:0], MemData[7:0] }); 
               $fwrite("\n");
           end #5;
           
           MemAdr= 2'd3;
            if (out != {RegData[7:0], MemData[23:0]}) begin 
               $fwrite(f,"testing sb: Bytes2Store = %2d, MemAdr =%2d \n",Bytes2Store, MemAdr ); 
               $fwrite(f,"out =     %32b \n" , out);
               $fwrite(f,"expected: %32b \n" ,{RegData[7:0], MemData[23:0]}); 
               $fwrite("\n");
           end #5;
    
     Bytes2Store = 2'd2;//test sh
     MemAdr = 2'd2;
         if (out != {RegData[15:0], MemData[15:0]}) begin 
            $fwrite(f,"testing sh: Bytes2Store = %2d, MemAdr =%2d \n",Bytes2Store, MemAdr ); 
            $fwrite(f,"out =     %32b \n" , out);
            $fwrite(f,"expected: %32b \n" ,{RegData[15:0], MemData[15:0]}); 
            $fwrite("\n");
         end  #5;
         
     
    
     MemAdr = 2'd0;
         if (out != {MemData[31:16], RegData[15:0]}) begin 
            $fwrite(f,"testing sh: Bytes2Store = %2d, MemAdr =%2d \n",Bytes2Store, MemAdr ); 
            $fwrite(f,"out =     %32b \n" , out);
            $fwrite(f,"expected: %32b \n" ,{MemData[31:16], RegData[15:0]}); 
            $fwrite("\n");
         end  #5;
        $fclose(f);
    end
endmodule
