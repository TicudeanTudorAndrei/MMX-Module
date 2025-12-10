library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier16b is
Port ( x: in STD_LOGIC_VECTOR (15 downto 0);
y:in STD_LOGIC_VECTOR (15 downto 0);
p: out STD_LOGIC_VECTOR (31 downto 0));
end entity;

architecture arhi of Multiplier16b is

component Multiplier8b is
Port (x: in  STD_LOGIC_VECTOR (7 downto 0);
y: in STD_LOGIC_VECTOR (7 downto 0);
p: out STD_LOGIC_VECTOR (15 downto 0));
end component;	

signal x_low, x_high, y_low, y_high: STD_LOGIC_VECTOR(7 downto 0);
signal x_low_y_low ,x_high_y_low ,x_low_y_high, x_high_y_high: STD_LOGIC_VECTOR(15 downto 0);
signal x_high_y_high2: STD_LOGIC_VECTOR(31 downto 0);

signal z1, z2, z3, z4, res: integer;		  
begin
x_low <= x(7 downto 0);
x_high <= x(15 downto 8);
y_low <= y(7 downto 0);
y_high <= y(15 downto 8);
 
MUL1: Multiplier8b port map(x_low,y_low,x_low_y_low);
MUL2: Multiplier8b port map (x_high,y_low,x_high_y_low);
MUL3: Multiplier8b port map (x_low,y_high,x_low_y_high);
MUL4: Multiplier8b port map (x_high,y_high,x_high_y_high);

x_high_y_high2(15 downto 0) <= x_high_y_high(15 downto 0);


z1 <= to_integer(unsigned(x_low_y_low));
z2 <= to_integer(unsigned(x_high_y_low));
z3 <= to_integer(unsigned(x_low_y_high));
z4 <= to_integer(shift_left(unsigned(x_high_y_high2),16));

res <= z1 + (z2 + z3)*256 + z4;

p <= std_logic_vector(to_signed(res,32));
end architecture;