library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity FullAdder1bit is
Port ( x: in STD_LOGIC;
y: in STD_LOGIC;
cin: in STD_LOGIC;
ignore_cin: in STD_LOGIC;
s: out STD_LOGIC;
cout: out STD_LOGIC);
end FullAdder1bit;

architecture arhi of FullAdder1bit is

signal carry: STD_LOGIC;

begin

with ignore_cin select carry <=
cin when '0',
'0' when others;
	
s <= x xor y xor carry;
cout<= (x and y) or ((x or y) and carry);

end arhi;
