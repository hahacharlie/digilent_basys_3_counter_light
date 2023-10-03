library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_tb is
end counter_tb;

architecture sim of counter_tb is
    signal clk: STD_LOGIC := '0';
    signal rst: STD_LOGIC := '0';
    signal cnt_en: STD_LOGIC := '0';
    signal cnt: STD_LOGIC_VECTOR(5 downto 0);

begin
    -- Instantiate the counter
    UUT: entity work.counter
    port map(
        clk => clk,
        rst => rst,
        cnt_en => cnt_en,
        cnt => cnt
    );

    -- Clock generation
    clk_process: process
    begin
        wait for 5 ns;
        clk <= not clk;
    end process;

    -- Testbench logic
    tb_process: process
    begin
        wait for 10 ns;
        rst <= '1';
        wait for 10 ns;
        cnt_en <= '1';
        wait for 50 ns;
        cnt_en <= '0';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;
        rst <= '1';
        wait for 50 ns;
        wait;
    end process;

end sim;
