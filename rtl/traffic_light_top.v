`timescale 1ns / 1ps



module traffic_light_top
#(
    parameter DEBOUNCE_COUNT = 32'd500_000
)
(
    input clk,  
    input btnR, btnL, btnC,  
    input rst,
    input [3:0] sw,  
    output red, green, yellow,  
    output red2, green2, yellow2,  
    output [3:0] bcd1,
           [3:0] bcd2
    
);

   
    wire btnR_tick, btnL_tick, btnC_tick, rst_tick;

   
    wire clk_200hz_tick;
    
    
    wire [3:0] fsm_state;
    wire [3:0] fsm_counter1;
    wire [3:0] fsm_counter2;

  
    debounce #(.DEBOUNCE_COUNT(DEBOUNCE_COUNT)) deb_R (
        .clk(clk), .btn_in(btnR), .btn_tick(btnR_tick)
    );
    debounce #(.DEBOUNCE_COUNT(DEBOUNCE_COUNT)) deb_L (
        .clk(clk), .btn_in(btnL), .btn_tick(btnL_tick)
    );
    debounce #(.DEBOUNCE_COUNT(DEBOUNCE_COUNT)) deb_C (
        .clk(clk), .btn_in(btnC), .btn_tick(btnC_tick)
    );
    
    debounce #(.DEBOUNCE_COUNT(DEBOUNCE_COUNT)) deb_Reset (
        .clk(clk), .btn_in(rst), .btn_tick(rst_tick)
    );

   
//    clk_divider #(.COUNT_TARGET(32'd500_000)) div_200hz (
//        .clk(clk), .rst(rst_tick), .tick(clk_200hz_tick)
//    );
    
   
    traffic_controller controller (
        .clk(clk), .rst(rst_tick),
        .btnR_tick(btnR_tick), .btnL_tick(btnL_tick), .btnC_tick(btnC_tick),
        .sw(sw),
        // Outputs
        .red(red), .green(green), .yellow(yellow),
        .red2(red2), .green2(green2), .yellow2(yellow2),
        .state_out(fsm_state),
        .counter_out(fsm_counter1),
        .counter2_out(fsm_counter2)
    );
    
   
    seven_seg_controller display (
        .clk(clk), .rst(rst_tick),
        .state(fsm_state),
        .counter1_in(fsm_counter1),
        .counter2_in(fsm_counter2),
        // Outputs
        .bcd1(bcd1),
        .bcd2(bcd2)
    );

endmodule