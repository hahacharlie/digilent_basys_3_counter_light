module counter_a (
    input clk,
    input rst,      // Active low reset
    input cnt_en,   // Counter enable
    output [5:0] cnt  // 6-bit counter output
);

// Internal registers
reg [5:0] cnt_reg = 6'b000000;  // 6-bit counter

// Counter logic
always @(posedge clk or negedge rst) begin
    if (!rst) begin: reset
        cnt_reg <= 6'b000001; // Reset to 1
    end else if (cnt_en) begin: counter
        cnt_reg <= cnt_reg + 1'b1; // increment the counter
    end
end

// Assign the output
assign cnt = cnt_reg;

endmodule
