module tb_counter_a();
    reg clk;
    reg rst;
    reg cnt_en;
    wire [5:0] cnt;

    // Instantiate the counter
    counter_a u0 (
        .clk(clk),
        .rst(rst),
        .cnt_en(cnt_en),
        .cnt(cnt)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench logic
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;   // Start with an active-low reset
        cnt_en = 0;

        #10 rst = 1;  // De-assert reset
        #10 cnt_en = 1;  // Enable counting
        #200 cnt_en = 0;  // 200 units (2 seconds of real-world time with 100MHz clock)
        #50 cnt_en = 1; // Enable counting
        #200 cnt_en = 0;  // 200 units (2 seconds of real-world time with 100MHz clock)
        #10 rst = 0;  // Assert reset
        #10 rst = 1;  // De-assert reset
        #200 $finish;  // Give an additional 2 seconds for observation before ending the simulation
    end

endmodule
