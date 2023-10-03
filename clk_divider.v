module clk_divider (
    input clk,  // 100MHz input clock
    output clk_out  // Slower clock output
);

reg [26:0] div_counter = 0;

always @(posedge clk) begin
    if (div_counter == 100_000_000/2 - 1) begin
        div_counter <= 0;
        clk_out <= ~clk_out;
    end else begin
        div_counter <= div_counter + 1;
    end
end

endmodule
