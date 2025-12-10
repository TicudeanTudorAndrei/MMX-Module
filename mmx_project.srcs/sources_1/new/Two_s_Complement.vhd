library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Two_s_Complement is
Port ( input: in STD_LOGIC_VECTOR(63 downto 0);
cascade: in STD_LOGIC_VECTOR(1 downto 0); -- 00 = 8b, 01 = 16b, 10 = 32b
output: out STD_LOGIC_VECTOR(63 downto 0));
end entity;

architecture arhi of Two_s_Complement is
  signal neg_input: STD_LOGIC_VECTOR(63 downto 0);
begin 
	
  process(input, cascade)
  begin
  neg_input <= not input;
  end process;
  
  process(neg_input, cascade)
  begin
    case cascade is
      when "00" =>
        for i in 0 to 7 loop
          output( (i+1)*8 - 1 downto i*8 ) <= neg_input( (i+1)*8 - 1 downto i*8 ) + '1';
        end loop;

      when "01" =>
        for i in 0 to 3 loop
          output( (i+1)*16 - 1 downto i*16 ) <= neg_input( (i+1)*16 - 1 downto i*16 ) + '1';
        end loop;

      when "10" =>
        for i in 0 to 1 loop
          output( (i+1)*32 - 1 downto i*32 ) <= neg_input( (i+1)*32 - 1 downto i*32 ) + '1';
        end loop;

      when others => null;
    end case;
  end process;
end architecture;