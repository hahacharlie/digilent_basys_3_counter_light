module counter_tb;
    reg clk;
    reg rst;
    reg cnt_en;
    wire [5:0] cnt;

    // Instantiate the counter
    counter u0 (
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
        clk = 0;
        rst = 0;
        cnt_en = 0;
        #10 rst = 1;
        #10 cnt_en = 1;
        #50 cnt_en = 0;
        #10 rst = 0;
        #10 rst = 1;
        #50 $finish;
    end

endmodule
