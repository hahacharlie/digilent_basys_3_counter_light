library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;   -- Active low reset
        cnt_en  : in  STD_LOGIC;   -- Counter enable
        cnt     : out STD_LOGIC_VECTOR(5 downto 0) -- 6-bit counter output
    );
end counter;

architecture Behavioral of counter is
    signal cnt_reg : STD_LOGIC_VECTOR(5 downto 0) := "000100"; -- Initialize to 4
begin

process(clk, rst)
begin
    if rst = '0' then
        cnt_reg <= "000100"; -- Reset to 4
    elsif rising_edge(clk) then
        if cnt_en = '1' then
            cnt_reg <= cnt_reg - 1;
        end if;
    end if;
end process;

-- Assign output
cnt <= cnt_reg;

end Behavioral;
