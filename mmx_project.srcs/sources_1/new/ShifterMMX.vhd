library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShifterMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
sel: in STD_LOGIC_VECTOR(2 downto 0); -- 000 = L on 16b, 001 = L on 32b, 010 = L on 64b, 011 = R on 16b, 100 = R on 32b, 101 = R on 64b
output: out STD_LOGIC_VECTOR(63 downto 0));
end entity;

architecture arhi of ShifterMMX is 

signal sa_16b : integer := 0;
signal sa_32b : integer := 0;
signal sa_64b : integer := 0;
signal inp: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal rez: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');

signal aux16: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal aux32: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal aux64: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal aux16_2: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal aux32_2: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal aux64_2: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');	

begin
process(input1)
begin
inp <= input1;
end process;
	
process(input2)
begin
sa_16b <= to_integer(unsigned(input2(3 downto 0)));
sa_32b <= to_integer(unsigned(input2(4 downto 0)));
sa_64b <= to_integer(unsigned(input2(5 downto 0)));
end process;

process(sel, inp)

begin
case sel is
	-- shift left
	when "000" =>
		for i in 0 to 3 loop
		    aux16 <= inp((i+1)*16 - 1 downto i*16 );
			aux16_2 <= std_logic_vector(shift_left(unsigned(aux16), sa_16b));
			rez( (i+1)*16 - 1 downto i*16 ) <= aux16_2;
        end loop;
	when "001" =>
	    for i in 0 to 1 loop
		    aux32 <= inp((i+1)*32 - 1 downto i*32);
			aux32_2 <= std_logic_vector(shift_left(unsigned(aux32), sa_32b));
			rez((i+1)*32 - 1 downto i*32) <= aux32_2;
        end loop;
	when "010" =>
	    aux64 <= inp(63 downto 0);
		aux64_2 <= std_logic_vector(shift_left(unsigned(aux64), sa_64b));
		rez(63 downto 0) <= aux64_2;
	-- shift right
	when "011" =>
        for i in 0 to 3 loop
		    aux16 <= inp((i+1)*16 - 1 downto i*16 );
			aux16_2 <= std_logic_vector(shift_right(unsigned(aux16), sa_16b));
			rez( (i+1)*16 - 1 downto i*16 ) <= aux16_2;
        end loop;
    when "100" =>
        for i in 0 to 1 loop
		    aux32 <= inp((i+1)*32 - 1 downto i*32);
			aux32_2 <= std_logic_vector(shift_right(unsigned(aux32), sa_32b));
			rez((i+1)*32 - 1 downto i*32) <= aux32_2;
        end loop;
    when "101" =>
        aux64 <= inp(63 downto 0);
		aux64_2 <= std_logic_vector(shift_right(unsigned(aux64), sa_64b));
		rez(63 downto 0) <= aux64_2;
    when others => null;
    
end case;
end process;

output <= rez;

end architecture;