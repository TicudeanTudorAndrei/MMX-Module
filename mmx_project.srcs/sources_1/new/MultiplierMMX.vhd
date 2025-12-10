library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity MultiplierMMX is
Port ( in1 : in  STD_LOGIC_VECTOR (63 downto 0);
in2 : in  STD_LOGIC_VECTOR (63 downto 0);
low : out  STD_LOGIC_VECTOR (63 downto 0);
high : out  STD_LOGIC_VECTOR (63 downto 0);
pmadd: out STD_LOGIC_VECTOR(63 downto 0) := (others => '0'));
end entity;

architecture arhi of MultiplierMMX is

component Multiplier16b is
Port ( x: in STD_LOGIC_VECTOR (15 downto 0);
y:in STD_LOGIC_VECTOR (15 downto 0);
p: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component AdderMMX is
Port ( x: in STD_LOGIC_VECTOR(63 downto 0);
y: in STD_LOGIC_VECTOR(63 downto 0);
cascade: in STD_LOGIC_VECTOR(1 downto 0); -- 00 = 8b, 01 = 16b, 10 = 32b
s: out STD_LOGIC_VECTOR(63 downto 0));
end component;

signal out1: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal out2: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal out3: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal out4: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal sum_pmadd: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal sum1: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal sum2: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal mmx1: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal mmx2: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');

begin

C1: Multiplier16b port map (in1(15 downto 0), in2(15 downto 0), out1);
C2:	Multiplier16b port map (in1(31 downto 16), in2(31 downto 16), out2);
C3:	Multiplier16b port map (in1(47 downto 32), in2(47 downto 32), out3);
C4:	Multiplier16b port map (in1(63 downto 48), in2(63 downto 48), out4);
C5: AdderMMX port map (mmx2, mmx1, "10", sum_pmadd);

process(out1, out2, out3, out4)
begin
high <= out4(31 downto 16) & out3(31 downto 16) & out2(31 downto 16) & out1(31 downto 16);
low <= out4(15 downto 0) & out3(15 downto 0) & out2(15 downto 0) & out1(15 downto 0);
mmx2 <= out4 & out2;
mmx1 <= out3 & out1; 
end process;

process(sum_pmadd)
begin
pmadd <= sum_pmadd;
end process;

end architecture;