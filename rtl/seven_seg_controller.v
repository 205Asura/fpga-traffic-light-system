`timescale 1ns / 1ps



module seven_seg_controller(
    input clk, rst,
//    input scan_tick,          
    input [3:0] state,
    input [3:0] counter1_in,   
    input [3:0] counter2_in,    
    
    output reg [3:0] bcd1,
           reg [3:0] bcd2
);

    
//    parameter SEG_NULL = 7'b1111111;
//    parameter SEG_0 = 7'b1000000;
//    parameter SEG_1 = 7'b1111001;
//    parameter SEG_2 = 7'b0100100;
//    parameter SEG_3 = 7'b0110000;
//    parameter SEG_4 = 7'b0011001;
//    parameter SEG_5 = 7'b0010010;
//    parameter SEG_6 = 7'b0000010;
//    parameter SEG_7 = 7'b1111000;
//    parameter SEG_8 = 7'b0000000;
//    parameter SEG_9 = 7'b0010000;
    
    parameter SEG_NULL = 4'b0000;
    parameter SEG_0 = 4'b0000;
    parameter SEG_1 = 4'b0001;
    parameter SEG_2 = 4'b0010;
    parameter SEG_3 = 4'b0011;
    parameter SEG_4 = 4'b0100;
    parameter SEG_5 = 4'b0101;
    parameter SEG_6 = 4'b0110;
    parameter SEG_7 = 4'b0111;
    parameter SEG_8 = 4'b1000;
    parameter SEG_9 = 4'b1001;
    
    
   
    parameter RED_MAN = 4'd5;

   
    reg signed [4:0] counter_display = 0;

   
//    initial 
//    begin
//        an <= 4'b1110; 
//    end

   
//    always @(posedge clk or posedge rst)
//    begin 
//        if (rst)
//            an <= 4'b1110; 
//        else
//        if (scan_tick) 
//            an <= {an[2:0], an[3]};
//    end

    
    always @(*)
    begin
        
        
        if (state >= RED_MAN) 
        begin 
            bcd2 = SEG_0;
            case (counter1_in) 
            4'd0: bcd1 = SEG_0;
            4'd1: bcd1 = SEG_1;
            4'd2: bcd1 = SEG_2;
            4'd3: bcd1 = SEG_3;
            4'd4: bcd1 = SEG_4;
            4'd5: bcd1 = SEG_5;
            4'd6: bcd1 = SEG_6;
            4'd7: bcd1 = SEG_7;
            4'd8: bcd1 = SEG_8;
            4'd9: bcd1 = SEG_9;
            default: bcd1 = SEG_NULL;
            endcase
        end 
        else
        begin
            case (counter1_in) 
            4'd0: bcd1 = SEG_0;
            4'd1: bcd1 = SEG_1;
            4'd2: bcd1 = SEG_2;
            4'd3: bcd1 = SEG_3;
            4'd4: bcd1 = SEG_4;
            4'd5: bcd1 = SEG_5;
            4'd6: bcd1 = SEG_6;
            4'd7: bcd1 = SEG_7;
            4'd8: bcd1 = SEG_8;
            4'd9: bcd1 = SEG_9;
            default: bcd1 = SEG_NULL;
            endcase
            
            case (counter2_in) 
            4'd0: bcd2 = SEG_0;
            4'd1: bcd2 = SEG_1;
            4'd2: bcd2 = SEG_2;
            4'd3: bcd2 = SEG_3;
            4'd4: bcd2 = SEG_4;
            4'd5: bcd2 = SEG_5;
            4'd6: bcd2 = SEG_6;
            4'd7: bcd2 = SEG_7;
            4'd8: bcd2 = SEG_8;
            4'd9: bcd2 = SEG_9;
            default: bcd2 = SEG_NULL;
            endcase
        end
        
//        else 
//        begin
//            if (an == 4'b1110) 
//                counter_display = counter1_in % 10; 
//            else if (an == 4'b1101 && counter1_in >= 10)
//                counter_display = counter1_in / 10; 
//            else if (an == 4'b1011) 
//                counter_display = counter2_in % 10; 
//            else if (an == 4'b0111 && counter2_in >= 10) 
//                counter_display = counter2_in / 10;
//        end
        
       
        
    end

endmodule