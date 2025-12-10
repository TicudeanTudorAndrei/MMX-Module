library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity Testbench_ControllerMMX is
end Testbench_ControllerMMX;

architecture arhi of Testbench_ControllerMMX is

signal op: STD_LOGIC_VECTOR(3 downto 0);
signal s_CMPL: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_ADD: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_SUB: STD_LOGIC := '0';
signal s_SHIFT: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal s_FIN: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_LOG: STD_LOGIC := '0';
signal s_MUL: STD_LOGIC := '0';
signal s_PMUL: STD_LOGIC := '0';

component ControllerMMX is
Port ( operation: in STD_LOGIC_VECTOR(3 downto 0);
CMPL: out STD_LOGIC_VECTOR(1 downto 0);
ADD: out STD_LOGIC_VECTOR(1 downto 0);
SUB: out STD_LOGIC;
SHIFT: out STD_LOGIC_VECTOR(2 downto 0);
FIN: out STD_LOGIC_VECTOR(1 downto 0);
LOG: out STD_LOGIC;
MUL: out STD_LOGIC;
PMUL: out STD_LOGIC);
end component;

begin

C: ControllerMMX port map(op, s_CMPL, s_ADD, s_SUB, s_SHIFT, s_FIN, s_LOG, s_MUL, s_PMUL);

op <= "0000" after 0 ns,
      "0001" after 10 ns,
      "0010" after 20 ns,
      "0011" after 30 ns,
      "0100" after 40 ns,
      "0101" after 50 ns,
      "0110" after 60 ns,
      "0111" after 70 ns,
      "1000" after 80 ns,
      "1001" after 90 ns,
      "1010" after 100 ns,
      "1011" after 110 ns,
      "1100" after 120 ns,
      "1101" after 130 ns,
      "1110" after 140 ns,
      "1111" after 150 ns;

end architecture;