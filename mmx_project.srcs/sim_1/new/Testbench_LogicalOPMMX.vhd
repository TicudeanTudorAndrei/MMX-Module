library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity Testbench_LogicalOPMMX is
end Testbench_LogicalOPMMX;

architecture arhi of Testbench_LogicalOPMMX is

signal x_input : STD_LOGIC_VECTOR(63 downto 0) := x"00FF0000F00F00E7";
signal y_input : STD_LOGIC_VECTOR(63 downto 0) := x"003C0000FFFF00FF";
signal s_output : STD_LOGIC_VECTOR(63 downto 0);

component LogicalOpMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
sel: in STD_LOGIC;
output: out STD_LOGIC_VECTOR(63 downto 0));
end component;

begin

C: LogicalOpMMX port map (x_input, y_input, '0', s_output);

end architecture;