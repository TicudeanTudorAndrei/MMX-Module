library IEEE;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.ALL;

entity MPG is
port ( btn: in STD_LOGIC;
clk : in  STD_LOGIC;
enable: out  STD_LOGIC);
end entity;

architecture Behavioral of MPG is

signal count_int : std_logic_vector(15 downto 0) := x"0000";
signal Q1 : std_logic;
signal Q2 : std_logic;
signal Q3 : std_logic;

begin
enable <= Q2 AND (not Q3);

COUNTER: process (clk) 
begin
if clk'event and clk='1' then
count_int <= count_int + 1;
end if;
end process;

SEMNAL: process (clk)
begin
if clk'event and clk='1' then  
	if count_int(15 downto 0) = x"1111" then 
	Q1 <= btn;
	end if; 
end if;
end process;

LEGATURI: process (clk)
begin
if clk'event and clk='1' then  
Q2 <= Q1;
Q3 <= Q2;
end if;
end process;

end Behavioral;