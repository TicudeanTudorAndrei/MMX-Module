library IEEE;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.ALL;

entity RAM is
port ( clk : in std_logic;
addr : in std_logic_vector(1 downto 0);
rd : out std_logic_vector(127 downto 0));
end entity;

architecture Behavioral of RAM is

signal count: std_logic_vector(1 downto 0) := "00";

type MEM is array (0 to 3) of std_logic_vector (127 downto 0);
signal RAM_MEM: MEM := (x"807F010180FFFF80_FF1738FF80FFFF7F", x"00FF0000F00F00E7_003C0000FFFF00FF", x"FFFFFFFFFFFFFFFF_0000000000000008", others => (others => '0') );
begin
	
process(clk)
begin
if(clk'event and clk = '1') then
    rd <= RAM_MEM(conv_integer(addr));
end if;
end process;

end Behavioral;