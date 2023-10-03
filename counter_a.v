module counter_a (
    input clk_100MHz,
    input rst,      // Active low reset
    input cnt_en,   // Counter enable
    output [5:0] cnt  // 6-bit counter output
);

// Internal registers
reg [5:0] cnt_reg = 6'b000001;  // 6-bit counter
reg [26:0] div_counter = 0;     // 27-bit divider for 100MHz to 1Hz conversion
wire slow_tick;                 // Signal that indicates the slower tick for the main counter

// Clock divider
always @(posedge clk_100MHz) begin
    if (div_counter == 100_000_000/2 - 1) begin
        div_counter <= 0;
        slow_tick <= ~slow_tick;
    end else begin
        div_counter <= div_counter + 1'b1;
    end
end

// Counter logic
always @(posedge clk_100MHz or negedge rst) begin
    if (!rst) begin
        cnt_reg <= 6'b000001;  // Reset to 1
    end else if (cnt_en && slow_tick) begin
        // If enabled and on a slow tick, increment the counter
        cnt_reg <= cnt_reg + 1'b1;
    end
end

// Assign the output
assign cnt = cnt_reg;

endmodule
