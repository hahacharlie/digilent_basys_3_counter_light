module tb_counter_a_clk_dvd();

    reg clk;
    reg rst;
    reg cnt_en;
    wire [5:0] cnt;

    // Instantiate the counter module
    counter_a_clk_dvd u0 (
        .clk(clk),
        .rst(rst),
        .cnt_en(cnt_en),
        .cnt(cnt)
    );

    // Clock generator
    always begin
        #5 clk = ~clk;          // Assuming you're simulating at the real-time 100MHz clock rate
    end

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;                // Start with an active-low reset
        cnt_en = 0;

        #10 rst = 1;            // De-assert reset
        #10 cnt_en = 1;         // Enable counting
        #400000000 cnt_en = 0;  // counting up 4 times with 1Hz clock
        #50 cnt_en = 1;         // Enable counting
        #400000000 cnt_en = 0;  // counting up 4 times with 1Hz clock
        #10 rst = 0;            // Assert reset
        #10 rst = 1;            // De-assert reset
        #400000000 $finish;     // Give an additional 4 seconds for observation before ending the simulation
    end

endmodule
