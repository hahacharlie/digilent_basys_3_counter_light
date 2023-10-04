module counter_a_clk_dvd (
    input clk,
    input rst,          // Active low reset
    input cnt_en,       // Counter enable
    output [5:0] cnt    // 6-bit counter output
);

// Internal registers
reg [5:0] cnt_reg = 6'b000000;                              // 6-bit counter
reg [27:0] clk_slow = 28'b0000000000000000000000000000;     // 28-bit slow clock counter

// Counter logic
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        cnt_reg <= 6'b000001;                           // Reset to 1
        clk_slow <= 28'b0000000000000000000000000000;   // Reset to 0
    end else if (cnt_en && clk) begin
        // If enabled and on a slow tick, increment the counter
        if (clk_slow == 100_000_000) begin              // 1Hz
            clk_slow <= 28'b0000000000000000000000000000;
            cnt_reg <= cnt_reg + 1'b1;
        end else begin
            clk_slow <= clk_slow + 1'b1;
        end
    end
end

// Assign the output
assign cnt = cnt_reg;

endmodule
