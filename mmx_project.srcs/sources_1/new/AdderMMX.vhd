library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity AdderMMX is
Port ( x: in STD_LOGIC_VECTOR(63 downto 0);
y: in STD_LOGIC_VECTOR(63 downto 0);
cascade: in STD_LOGIC_VECTOR(1 downto 0); -- 00 = 8b, 01 = 16b, 10 = 32b
s: out STD_LOGIC_VECTOR(63 downto 0));
end AdderMMX;

architecture arhi of AdderMMX is

component FullAdder1bit is
Port ( x: in STD_LOGIC;
y: in STD_LOGIC;
cin: in STD_LOGIC;
ignore_cin: in STD_LOGIC;
s: out STD_LOGIC;
cout: out STD_LOGIC);
end component;

signal carry : STD_LOGIC_VECTOR(64 downto 0) := (others => '0');
signal ign_carry: STD_LOGIC_VECTOR(6 downto 0) := (others => '0');

begin

carry(0) <= '0';	

with cascade select	ign_carry(0) <= '1' when "00", '0' when others;
with cascade select	ign_carry(1) <= '1' when "00", '1' when "01", '0' when others;
with cascade select	ign_carry(2) <= '1' when "00", '0' when others;
with cascade select	ign_carry(3) <= '1' when "00", '1' when "01", '1' when "10", '0' when others;
with cascade select	ign_carry(4) <= '1' when "00", '0' when others;
with cascade select	ign_carry(5) <= '1' when "00", '1' when "01", '0' when others;
with cascade select	ign_carry(6) <= '1' when "00", '0' when others;

-- ROW 0
ADDERS_0:
for i in 0 to 7 
generate
	ADD_i_0: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

-- ROW 1
ROW_START_1: FullAdder1bit port map (x(8), y(8), carry(8), ign_carry(0), s(8), carry(9));

ADDERS_1: 
for i in 9 to 15 
generate
	ADD_i_1: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

-- ROW 2
ROW_START_2: FullAdder1bit port map (x(16), y(16), carry(16), ign_carry(1), s(16), carry(17));

ADDERS_2: 
for i in 17 to 23 
generate
	ADD_i_2: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

-- ROW 3
ROW_START_3: FullAdder1bit port map (x(24), y(24), carry(24), ign_carry(2), s(24), carry(25));

ADDERS_3: 
for i in 25 to 31 
generate
	ADD_i_3: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

-- ROW 4
ROW_START_4: FullAdder1bit port map (x(32), y(32), carry(32), ign_carry(3), s(32), carry(33));

ADDERS_4: 
for i in 33 to 39 
generate
	ADD_i_4: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

-- ROW 5
ROW_START_5: FullAdder1bit port map (x(40), y(40), carry(40), ign_carry(4), s(40), carry(41));

ADDERS_5: 
for i in 41 to 47 
generate
	ADD_i_5: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

-- ROW 6
ROW_START_6: FullAdder1bit port map (x(48), y(48), carry(48), ign_carry(5), s(48), carry(49));

ADDERS_6: 
for i in 49 to 55 
generate
	ADD_i_6: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

-- ROW 7
ROW_START_7: FullAdder1bit port map (x(56), y(56), carry(56), ign_carry(6), s(56), carry(57));

ADDERS_7: 
for i in 57 to 63 
generate
	ADD_i_7: FullAdder1bit port map (x(i), y(i), carry(i), '0', s(i), carry(i+1));
end generate;

end architecture;