library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter_a_clk_dvd is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;   -- Active low reset
        cnt_en  : in  STD_LOGIC;   -- Counter enable
        cnt     : out STD_LOGIC_VECTOR(5 downto 0) -- 6-bit counter output
    );
end counter_a_clk_dvd;

architecture Behavioral of counter_a_clk_dvd is
    signal cnt_reg   : STD_LOGIC_VECTOR(5 downto 0) := "000100"; -- Initialize to 4
    signal clk_slow  : STD_LOGIC_VECTOR(27 downto 0) := (others => '0'); -- 28-bit slow clock counter, initialized to 0
begin

process(clk, rst)
begin
    if rst = '0' then
        cnt_reg <= "000100"; -- Reset to 4
        clk_slow <= (others => '0'); -- Reset to 0
    elsif rising_edge(clk) then
        if cnt_en = '1' then
            if clk_slow = '100000000' then -- 1Hz
                clk_slow <= (others => '0');
                cnt_reg <= cnt_reg - 1;  -- Decrement the counter
            else
                clk_slow <= clk_slow + 1;
            end if;
        end if;
    end if;
end process;

-- Assign output
cnt <= cnt_reg;

end Behavioral;
