module fpga_top(
    input clk_100MHz, // Board's 100MHz system clock
    input rst_switch,
    input cnt_en_switch,
    output [5:0] LEDs
);

wire slow_clk;

clk_divider div(
    .clk(clk_100MHz),
    .clk_out(slow_clk)
);

counter cnt_module(
    .clk(slow_clk),
    .rst(rst_switch),
    .cnt_en(cnt_en_switch),
    .cnt(LEDs)
);

endmodule
