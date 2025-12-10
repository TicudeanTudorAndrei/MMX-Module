library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LogicalOpMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
sel: in STD_LOGIC;
output: out STD_LOGIC_VECTOR(63 downto 0));
end entity;

architecture arhi of LogicalOpMMX is
begin
with sel select output <= input1 and input2 when '0', (others => '0') when others;
end architecture;