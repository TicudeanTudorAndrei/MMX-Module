library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity Testbench_ShifterMMX is
end Testbench_ShifterMMX;

architecture arhi of Testbench_ShifterMMX is

signal x_input : STD_LOGIC_VECTOR(63 downto 0) := x"FFFFFFFFFFFFFFFF";
signal y_input : STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000008"; 
signal cascade_input : STD_LOGIC_VECTOR(2 downto 0);
signal s_output : STD_LOGIC_VECTOR(63 downto 0);

component ShifterMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
sel: in STD_LOGIC_VECTOR(2 downto 0);
output: out STD_LOGIC_VECTOR(63 downto 0));
end component;

begin

C: ShifterMMX port map (x_input, y_input, cascade_input, s_output);

cascade_input <= "000" after 0 ns, "001" after 20 ns, "010" after 40 ns, "011" after 60 ns, "100" after 80 ns, "101" after 100 ns;

end architecture;