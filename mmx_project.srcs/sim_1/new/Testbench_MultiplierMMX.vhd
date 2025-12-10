library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity Testbench_MultiplierMMX is
end Testbench_MultiplierMMX;

architecture arhi of Testbench_MultiplierMMX is

signal x_input : STD_LOGIC_VECTOR(63 downto 0) := x"807F010180FFFF80";
signal y_input : STD_LOGIC_VECTOR(63 downto 0) := x"FF1738FF80FFFF7F"; 
signal res_low : STD_LOGIC_VECTOR(63 downto 0);
signal res_high : STD_LOGIC_VECTOR(63 downto 0);
signal res_pmadd : STD_LOGIC_VECTOR(63 downto 0);

component MultiplierMMX is
Port ( in1 : in  STD_LOGIC_VECTOR (63 downto 0);
in2 : in  STD_LOGIC_VECTOR (63 downto 0);
low : out  STD_LOGIC_VECTOR (63 downto 0);
high : out  STD_LOGIC_VECTOR (63 downto 0);
pmadd: out STD_LOGIC_VECTOR(63 downto 0) := (others => '0'));
end component;

begin

C: MultiplierMMX port map (x_input, y_input, res_low, res_high, res_pmadd);

end architecture;