`timescale 1ns / 1ps



module debounce #(
    parameter DEBOUNCE_COUNT = 32'd500_000 
) (
    input clk,
    input btn_in,     
    output reg btn_tick  
);

    reg [31:0] debounce_counter = 0;
    reg btn_prev = 0;
    reg btn_stable = 0;
            
    
    always @(posedge clk) begin
        
            btn_prev <= btn_stable;
            
            if (btn_in == btn_stable) begin
                debounce_counter <= 0;
            end else begin
                if (debounce_counter < DEBOUNCE_COUNT)
                    debounce_counter <= debounce_counter + 1;
                else begin
                    btn_stable <= btn_in;
                    debounce_counter <= 0;
                end
            end
            
           
            btn_tick <= (btn_stable && !btn_prev);
        
    end

endmodule