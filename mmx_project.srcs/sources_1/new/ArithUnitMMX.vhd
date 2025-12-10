library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ArithUnitMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
operation: in STD_LOGIC_VECTOR(3 downto 0);
rez: out STD_LOGIC_VECTOR(63 downto 0));
end entity;

architecture arhi of ArithUnitMMX is

component AdderMMX is
Port ( x: in STD_LOGIC_VECTOR(63 downto 0);
y: in STD_LOGIC_VECTOR(63 downto 0);
cascade: in STD_LOGIC_VECTOR(1 downto 0); -- 00 = 8b, 01 = 16b, 10 = 32b
s: out STD_LOGIC_VECTOR(63 downto 0));
end component;

component Two_s_Complement is
Port ( input: in STD_LOGIC_VECTOR(63 downto 0);
cascade: in STD_LOGIC_VECTOR(1 downto 0); -- 00 = 8b, 01 = 16b, 10 = 32b
output: out STD_LOGIC_VECTOR(63 downto 0));
end component;

component ShifterMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
sel: in STD_LOGIC_VECTOR(2 downto 0); -- 000 = L on 16b, 001 = L on 32b, 010 = L on 64b, 011 = R on 16b, 100 = R on 32b, 101 = R on 64b
output: out STD_LOGIC_VECTOR(63 downto 0));
end component;

component LogicalOpMMX is
Port ( input1: in STD_LOGIC_VECTOR(63 downto 0);
input2: in STD_LOGIC_VECTOR(63 downto 0);
sel: in STD_LOGIC;
output: out STD_LOGIC_VECTOR(63 downto 0));
end component;

component MultiplierMMX is
Port ( in1 : in  STD_LOGIC_VECTOR (63 downto 0);
in2 : in  STD_LOGIC_VECTOR (63 downto 0);
low : out  STD_LOGIC_VECTOR (63 downto 0);
high : out  STD_LOGIC_VECTOR (63 downto 0);
pmadd: out STD_LOGIC_VECTOR(63 downto 0) := (others => '0'));
end component;

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

signal rez_add_sub: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal rez_shift: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal rez_2_compl: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal rez_logic: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal rez_mul_high: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal rez_mul_low: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
signal rez_pmadd: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');

signal s_CMPL: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_ADD: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_SUB: STD_LOGIC := '0';
signal s_SHIFT: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal s_FIN: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal s_LOG: STD_LOGIC := '0';
signal s_MUL: STD_LOGIC := '0';
signal s_PMUL: STD_LOGIC := '0';

signal inp2_add: STD_LOGIC_VECTOR(63 downto 0) := (others => '0'); 
signal mul_hi_lo_mux: STD_LOGIC_VECTOR(63 downto 0) := (others => '0'); 
signal mul_final: STD_LOGIC_VECTOR(63 downto 0) := (others => '0');

begin

with s_SUB select inp2_add <= input2 when '0', rez_2_compl when others;
with s_MUL select mul_hi_lo_mux <= rez_mul_low when '0', rez_mul_high when others;
with s_PMUL select mul_final <= mul_hi_lo_mux when '0', rez_pmadd when others;
with s_FIN select rez <= rez_add_sub when "00", rez_shift when "01", mul_final when "10", rez_logic when others;

ADDER: AdderMMX port map(input1, inp2_add, s_ADD, rez_add_sub);
COMPLEMENT: Two_s_Complement port map(input2, s_CMPL, rez_2_compl);
SHIFTER: ShifterMMX port map(input1, input2, s_SHIFT, rez_shift);
LOGICAL: LogicalOpMMX port map(input1, input2, s_LOG, rez_logic);
MULTIPLIER: MultiplierMMX port map(input1, input2, rez_mul_low, rez_mul_high, rez_pmadd);
CONTROL: ControllerMMX port map(operation, s_CMPL, s_ADD, s_SUB, s_SHIFT, s_FIN, s_LOG, s_MUL, s_PMUL);

end architecture;