library IEEE;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.ALL;

entity top_level_project is
port ( clk: in STD_LOGIC;
btn: in STD_LOGIC_VECTOR (4 downto 0);
sw: in STD_LOGIC_VECTOR (15 downto 0);       
led: out STD_LOGIC_VECTOR (15 downto 0);       
an: out STD_LOGIC_VECTOR (7 downto 0);        
cat: out STD_LOGIC_VECTOR (6 downto 0));
end entity;	

architecture arhi of top_level_project is

component MPG is
port ( btn: in STD_LOGIC;
clk : in  STD_LOGIC;
enable: out  STD_LOGIC);
end component;

component ArithUnitMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
operation: in STD_LOGIC_VECTOR(3 downto 0);
rez: out STD_LOGIC_VECTOR(63 downto 0));
end component;

component SSD is
port ( digits: in STD_LOGIC_VECTOR (31 downto 0); 
clk: in STD_LOGIC;
an: out STD_LOGIC_VECTOR (7 downto 0);
cat: out STD_LOGIC_VECTOR (6 downto 0));
end component;

component RAM is
port ( clk : in STD_LOGIC;
addr : in STD_LOGIC_VECTOR(1 downto 0);
rd : out STD_LOGIC_VECTOR(127 downto 0));
end component;

signal memoryData: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
signal debButtons: STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
signal displayData: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

signal input1: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal input2: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal op: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal result: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');

begin

M0: MPG port map(btn(0), clk, debButtons(0));
M1: MPG port map(btn(1), clk, debButtons(1));
M2: MPG port map(btn(2), clk, debButtons(2));
M3: MPG port map(btn(3), clk, debButtons(3));
M4: MPG port map(btn(4), clk, debButtons(4));
--    1
--  2 0 3 
--    4
DISPLAY: SSD port map(displayData, clk, an, cat);
MMX: ArithUnitMMX port map(input1, input2, op, result);
MEMORY: RAM port map(btn(1), sw(5 downto 4), memoryData);

process(btn(0))
begin
input1 <= memoryData(127 downto 64); 
input2 <= memoryData(63 downto 0);
op <= sw(3 downto 0);
end process;

process(sw)
begin
	case sw(6) is
	when '0' => displayData <= result(63 downto 32);
	when others => displayData <= result(31 downto 0);
end case;
end process;

end architecture;





