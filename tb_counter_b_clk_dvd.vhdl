library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_counter_b_clk_dvd is
end tb_counter_b_clk_dvd;

architecture sim of tb_counter_b_clk_dvd is
    signal clk     : STD_LOGIC := '0';
    signal rst     : STD_LOGIC := '1';  -- Initially set to inactive state
    signal cnt_en  : STD_LOGIC := '0';
    signal cnt     : STD_LOGIC_VECTOR(5 downto 0);

    constant clk_period : time := 10 ns; -- Assuming 100MHz clock rate

    component counter_b_clk_dvd
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            cnt_en  : in  STD_LOGIC;
            cnt     : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

begin
    -- Instantiate the DUT
    DUT: counter_a_clk_dvd
        port map(
            clk     => clk,
            rst     => rst,
            cnt_en  => cnt_en,
            cnt     => cnt
        );

    -- Clock process
    clk_process: process
    begin
        wait for clk_period/2;
        clk <= not clk;
    end process;

    -- Test Stimulus process
    stim_proc: process
    begin
        -- Initialize
        clk <= '0';
        rst <= '0';  -- Assert reset
        cnt_en <= '0';

        wait for clk_period;
        rst <= '1';  -- De-assert reset
        wait for clk_period;

        cnt_en <= '1';  -- Start counting
        wait for clk_period * 40000000;  -- Wait for 400 million clock cycles (4 seconds real-world time)

        cnt_en <= '0';  -- Stop counting
        wait for clk_period * 5;

        cnt_en <= '1';  -- Start counting again
        wait for clk_period * 40000000;  -- Wait for another 4 seconds

        cnt_en <= '0';  -- Stop counting
        wait for clk_period;

        rst <= '0';  -- Assert reset
        wait for clk_period;

        rst <= '1';  -- De-assert reset
        wait for clk_period * 40000000;  -- Wait for 4 seconds to observe post-reset behavior

        wait;
    end process;

end sim;
