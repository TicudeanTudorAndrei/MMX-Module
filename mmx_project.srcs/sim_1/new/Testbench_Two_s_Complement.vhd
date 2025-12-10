library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity Testbench_Two_s_Complement is
end Testbench_Two_s_Complement;

architecture arhi of Testbench_Two_s_Complement is

signal x_input : STD_LOGIC_VECTOR(63 downto 0) := x"FF1738FF80FFFF7F";
signal cascade_input : STD_LOGIC_VECTOR(1 downto 0);
signal s_output : STD_LOGIC_VECTOR(63 downto 0);

component Two_s_Complement is
Port ( input: in STD_LOGIC_VECTOR(63 downto 0);
cascade: in STD_LOGIC_VECTOR(1 downto 0);
output: out STD_LOGIC_VECTOR(63 downto 0));
end component;

begin

C: Two_s_Complement port map (x_input, cascade_input, s_output);

cascade_input <= "00" after 0 ns, "01" after 10 ns, "10" after 20 ns;

end architecture;