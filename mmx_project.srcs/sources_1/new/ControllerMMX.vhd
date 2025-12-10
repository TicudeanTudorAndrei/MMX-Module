library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControllerMMX is
Port ( operation: in STD_LOGIC_VECTOR(3 downto 0);
CMPL: out STD_LOGIC_VECTOR(1 downto 0);
ADD: out STD_LOGIC_VECTOR(1 downto 0);
SUB: out STD_LOGIC;
SHIFT: out STD_LOGIC_VECTOR(2 downto 0);
FIN: out STD_LOGIC_VECTOR(1 downto 0);
LOG: out STD_LOGIC;
MUL: out STD_LOGIC;
PMUL: out STD_LOGIC);
end entity;

architecture arhi of ControllerMMX is

signal s_CMPL: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_ADD: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_SUB: STD_LOGIC := '0';
signal s_SHIFT: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal s_FIN: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_LOG: STD_LOGIC := '0';
signal s_MUL: STD_LOGIC := '0';
signal s_PMUL: STD_LOGIC := '0';

begin

process(operation)
begin
s_CMPL <= (others => '0');
s_ADD <= (others => '0');
s_SUB <= '0';
s_SHIFT <= (others => '0');
s_FIN <= (others => '0');
s_LOG <= '0';
s_MUL <= '0';
s_PMUL <= '0';
	
case operation is
when "0000" => s_ADD <= "00"; s_SUB <= '0'; s_FIN <= "00";
when "0001" => s_ADD <= "01"; s_SUB <= '0'; s_FIN <= "00";
when "0010" => s_ADD <= "10"; s_SUB <= '0'; s_FIN <= "00";
when "0011" => s_ADD <= "00"; s_SUB <= '1'; s_CMPL <= "00"; s_FIN <= "00";
when "0100" => s_ADD <= "01"; s_SUB <= '1'; s_CMPL <= "01"; s_FIN <= "00";
when "0101" => s_ADD <= "10"; s_SUB <= '1'; s_CMPL <= "10"; s_FIN <= "00";
when "0110" => s_LOG <= '0'; s_FIN <= "11";
when "0111" => s_SHIFT <= "000"; s_FIN <= "01";
when "1000" => s_SHIFT <= "001"; s_FIN <= "01";
when "1001" => s_SHIFT <= "010"; s_FIN <= "01";
when "1010" => s_SHIFT <= "011"; s_FIN <= "01";
when "1011" => s_SHIFT <= "100"; s_FIN <= "01";
when "1100" => s_SHIFT <= "101"; s_FIN <= "01";
when "1101" => s_MUL <= '0'; s_PMUL <= '0'; s_FIN <= "10";
when "1110" => s_MUL <= '1'; s_PMUL <= '0'; s_FIN <= "10";
when others => s_PMUL <= '1'; s_FIN <= "10";
end case;
end process;

CMPL <= s_CMPL;
ADD <= s_ADD;
SUB <= s_SUB; 
SHIFT <= s_SHIFT;
FIN <= s_FIN;
LOG <= s_LOG; 
MUL <= s_MUL; 
PMUL <= s_PMUL;

end architecture;