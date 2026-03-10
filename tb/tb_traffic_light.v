`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 09:53:39 PM
// Design Name: 
// Module Name: tb_traffic_light
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_traffic_light;

    // Inputs
    reg clk;
    reg btnR;
    reg btnL;
    reg btnC;
    reg rst;
    reg [3:0] sw;

    // Outputs
    wire red;
    wire green;
    wire yellow;
    wire red2;
    wire green2;
    wire yellow2;
    wire [3:0] bcd1;
    wire [3:0] bcd2;
    wire [3:0] fsm_counter1;
    wire [3:0] fsm_counter2;

    // Instantiate the Unit Under Test (UUT)
    traffic_light_top uut (
        .clk(clk), 
        .btnR(btnR), 
        .btnL(btnL), 
        .btnC(btnC), 
        .rst(rst), 
        .sw(sw), 
        .red(red), 
        .green(green), 
        .yellow(yellow), 
        .red2(red2), 
        .green2(green2), 
        .yellow2(yellow2), 
        .bcd1(bcd1),
        .bcd2(bcd2),
        .fsm_counter1(fsm_counter1),
        .fsm_counter2(fsm_counter2)
    );

    // Clock generation (assuming 100 MHz clock, period 10 ns)
    always #0.1 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        btnR = 0;
        btnL = 0;
        btnC = 0;
        rst = 1;
        sw = 4'b0000;

        // Reset the system
        
        rst = 0;
        #4;

        // Note: The design uses large counters (e.g., 100_000_000 for 1 Hz timing at 100 MHz clock).
        // Simulating full seconds would require billions of cycles, which is impractical.
        // For simulation purposes, consider overriding parameters or reducing constants.
        // Here, we'll simulate basic reset, button presses, and short-term behavior.
        // To test timing, modify the design's hardcoded counters (e.g., clk_1hz_counter limit) to smaller values like 10 for fast simulation.

        // Test 1: Automatic mode after init (assuming default config: red=5, green=3, yellow=2)
        // Wait for some cycles to observe init to RED1_GREEN2_STATE
        #5;

        // Simulate button press to enter RED_MAN (right button)
        btnR = 1;
        #1;  // Button down
        btnR = 0;
        #1;  // Wait past debounce (500_000 cycles + margin, but shortened for sim)

        // In RED_MAN, set sw to new red time, e.g., 8
        sw = 4'b1000;
        #1;

        // Press center to confirm config
        btnC = 1;
        #1;
        btnC = 0;
        #1;  // Debounce

        // Press right to go to GREEN_MAN
        btnR = 1;
        #1;
        btnR = 0;
        #1;

        // Set sw to new green time, e.g., 4
        sw = 4'b0101;
        #1;

        // Confirm with center
        btnC = 1;
        #1;
        btnC = 0;
        #1;

        // Press right to go to YELLOW_MAN
        btnR = 1;
        #1;
        btnR = 0;
        #1;

        // Set sw to new yellow time, e.g., 1
        sw = 4'b0011;
        #1;

        // Confirm
        btnC = 1;
        #1;
        btnC = 0;
        #1;

        // Press right to return to INIT
        btnR = 1;
        #1;
        btnR = 0;
        #1;

        
        // End simulation after some time
        #1000;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | State=%d | Counter1=%d | Counter2=%d | Lights: RGY=%b%b%b R2G2Y2=%b%b%b",
                 $time, uut.controller.state, uut.controller.counter, uut.controller.counter2,
                 red, green, yellow, red2, green2, yellow2);
    end

endmodule

