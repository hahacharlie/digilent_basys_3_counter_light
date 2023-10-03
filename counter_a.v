module counter (
    input clk,
    input rst,      // Active low reset
    input cnt_en,   // Counter enable
    output [5:0] cnt  // 6-bit counter output
);

// Internal register to hold the count value
reg [5:0] cnt_reg = 6'b0;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        cnt_reg <= 6'b000001;  // Reset to 1
    end else if (cnt_en) begin
        // If enabled, increment the counter
        cnt_reg <= cnt_reg + 1'b1;
    end
end

// Assign the output
assign cnt = cnt_reg;

endmodule
