`timescale 1ns / 1ps



module traffic_controller
#(
    parameter CLK_1HZ_TICK_COUNT = 32'd5
)
(
    input clk, rst,
    input btnR_tick, btnL_tick, btnU_tick, btnD_tick, btnC_tick,
    input [3:0] sw,
    
    // Outputs
    output reg red, green, yellow,
    output reg red2, green2, yellow2,
    output reg [3:0] state_out,
    output reg [3:0] counter_out,
    output reg [3:0] counter2_out
);

   
    localparam INIT = 4'd0,
              RED1_GREEN2_STATE = 4'd1,
              RED1_YELLOW2_STATE = 4'd2,
              GREEN1_RED2_STATE = 4'd3,
              YELLOW1_RED2_STATE = 4'd4,
              RED_MAN = 4'd5,
              GREEN_MAN = 4'd6,
              YELLOW_MAN = 4'd7,
              ERROR_STATE = 4'd8;
    
   
    localparam DEFAULT_RED_TIME = 5,
              DEFAULT_GREEN_TIME = 3,
              DEFAULT_YELLOW_TIME = 2;

   
    reg [3:0] state = INIT, next_state = INIT;
    reg [3:0] counter = 0, counter2 = 0;
    
    
    reg [31:0] clk_1hz_counter = 0;

   
    reg [3:0] red_time_config = DEFAULT_RED_TIME;
    reg [3:0] green_time_config = DEFAULT_GREEN_TIME;
    reg [3:0] yellow_time_config = DEFAULT_YELLOW_TIME;
    reg [3:0] temp_red_time = DEFAULT_RED_TIME;
    reg [3:0] temp_green_time = DEFAULT_GREEN_TIME;
    reg [3:0] temp_yellow_time = DEFAULT_YELLOW_TIME;
    reg config_pending = 0;

    
    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            temp_red_time <= DEFAULT_RED_TIME;
            temp_green_time <= DEFAULT_GREEN_TIME;
            temp_yellow_time <= DEFAULT_YELLOW_TIME;
            config_pending <= 0;
            red_time_config <= DEFAULT_RED_TIME;
            green_time_config <= DEFAULT_GREEN_TIME;
            yellow_time_config <= DEFAULT_YELLOW_TIME;
        end
        else begin
            if (state >= RED_MAN) begin
                case (state)
                    RED_MAN: begin
                        config_pending <= 1;
                        temp_red_time <= (sw[3:0] == 0) ? 1 : sw[3:0]; 
                    end
                    GREEN_MAN: begin
                        config_pending <= 1;
                        temp_green_time <= (sw[3:0] == 0) ? 1 : sw[3:0]; 
                    end
                    YELLOW_MAN: begin
                        config_pending <= 1;
                        temp_yellow_time <= (sw[3:0] == 0) ? 1 : sw[3:0]; 
                    end
                endcase
            end
            
            
            if (btnC_tick && config_pending) begin 
                red_time_config <= temp_red_time;
                green_time_config <= temp_green_time;
                yellow_time_config <= temp_yellow_time;
                config_pending <= 0;
            end
            
            
            if ((btnR_tick || btnL_tick) && state >= RED_MAN && config_pending) begin 
                config_pending <= 0;
                temp_red_time <= red_time_config;
                temp_green_time <= green_time_config;
                temp_yellow_time <= yellow_time_config;
            end
        end
    end

    
    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            state <= INIT;
            counter <= 0;
            counter2 <= 0;
            clk_1hz_counter <= 0;
        end
        else begin
            state <= next_state;
            
            case (next_state)
            RED_MAN: {counter, counter2} <= {red_time_config, 4'd0};
            GREEN_MAN: {counter, counter2} <= {green_time_config, 4'd0};
            YELLOW_MAN: {counter, counter2} <= {yellow_time_config, 4'd0};
            endcase
            
            if (state != next_state) begin
                case (next_state)
                RED1_GREEN2_STATE: {counter, counter2} <= {red_time_config, green_time_config};
                RED1_YELLOW2_STATE: {counter, counter2} <= {yellow_time_config, yellow_time_config};
                GREEN1_RED2_STATE: {counter, counter2} <= {green_time_config, red_time_config};
                YELLOW1_RED2_STATE: {counter, counter2} <= {yellow_time_config, yellow_time_config};
                ERROR_STATE: counter <= 0;
                default: counter <= counter;
                endcase
            end
            
           
            if (state < RED_MAN)
            begin
                clk_1hz_counter <= clk_1hz_counter + 1;
                if (clk_1hz_counter == CLK_1HZ_TICK_COUNT - 1) begin
                    if (counter > 0)
                        counter <= counter - 1;
                    if (counter2 > 0)
                        counter2 <= counter2 - 1;
                    clk_1hz_counter <= 0;
                end
            end
            else 
                clk_1hz_counter <= 0;
        end
    end
    
   
    always @(*)
    begin
        case (state)
            ERROR_STATE: {red, green, yellow, red2, green2, yellow2} = 6'b111111;
            RED1_GREEN2_STATE: {red, green, yellow, red2, green2, yellow2} = 6'b100010;
            RED1_YELLOW2_STATE: {red, green, yellow, red2, green2, yellow2} = 6'b100001;
            GREEN1_RED2_STATE: {red, green, yellow, red2, green2, yellow2} = 6'b010100;
            YELLOW1_RED2_STATE: {red, green, yellow, red2, green2, yellow2} = 6'b001100;
            RED_MAN: {red, green, yellow, red2, green2, yellow2} = 6'b100100;
            GREEN_MAN: {red, green, yellow, red2, green2, yellow2} = 6'b010010;
            YELLOW_MAN: {red, green, yellow, red2, green2, yellow2} = 6'b001001;
            default: {red, green, yellow, red2, green2, yellow2} = 6'b111111;
        endcase
    end

   
    always @(*)
    begin
        next_state = state;
        case (state)
            INIT:
                if (red_time_config != green_time_config + yellow_time_config)
                    next_state = ERROR_STATE; 
                else
                    next_state = RED1_GREEN2_STATE; 
            ERROR_STATE:
                if (btnR_tick) next_state = RED_MAN; 
                else if (btnL_tick) next_state = YELLOW_MAN; 
            RED1_GREEN2_STATE: 
                if (btnR_tick) next_state = RED_MAN; 
                else if (btnL_tick) next_state = YELLOW_MAN; 
                else if (counter == yellow_time_config) next_state = RED1_YELLOW2_STATE; 
            RED1_YELLOW2_STATE: 
                if (btnR_tick) next_state = RED_MAN; 
                else if (btnL_tick) next_state = YELLOW_MAN; 
                else if (counter == 0) next_state = GREEN1_RED2_STATE; 
            GREEN1_RED2_STATE: 
                if (btnR_tick) next_state = RED_MAN; 
                else if (btnL_tick) next_state = YELLOW_MAN; 
                else if (counter == 0) next_state = YELLOW1_RED2_STATE; 
            YELLOW1_RED2_STATE: 
                if (btnR_tick) next_state = RED_MAN; 
                else if (btnL_tick) next_state = YELLOW_MAN; 
                else if (counter == 0) next_state = RED1_GREEN2_STATE; 
            RED_MAN:
                if (btnR_tick) next_state = GREEN_MAN; 
                else if (btnL_tick) next_state = INIT; 
            GREEN_MAN:
                if (btnR_tick) next_state = YELLOW_MAN; 
                else if (btnL_tick) next_state = RED_MAN;
            YELLOW_MAN:
                if (btnR_tick) next_state = INIT;
                else if (btnL_tick) next_state = GREEN_MAN; 
            default:
                next_state = INIT;
        endcase
    end
    
   
    always @(*)
    begin
        state_out = state;
        counter_out = counter;
        counter2_out = counter2;
    end

endmodule