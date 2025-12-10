library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity Testbench_AdderMMX is
end Testbench_AdderMMX;

architecture arhi of Testbench_AdderMMX is

signal x_input : STD_LOGIC_VECTOR(63 downto 0) := x"807F010180FFFF80";
signal y_input : STD_LOGIC_VECTOR(63 downto 0) := x"FF1738FF80FFFF7F"; 
signal cascade_input : STD_LOGIC_VECTOR(1 downto 0);
signal s_output : STD_LOGIC_VECTOR(63 downto 0);

component AdderMMX
Port ( x: in STD_LOGIC_VECTOR(63 downto 0);
y: in STD_LOGIC_VECTOR(63 downto 0);
cascade: in STD_LOGIC_VECTOR(1 downto 0);
s: out STD_LOGIC_VECTOR(63 downto 0));
end component;

begin

C: AdderMMX port map (x_input, y_input, cascade_input, s_output);

cascade_input <= "00" after 0 ns, "01" after 10 ns, "10" after 20 ns;

end architecture;