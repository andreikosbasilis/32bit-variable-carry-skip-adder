library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity QD_1 is 
	PORT(q:in std_logic;
	     clk,rst:std_logic;
	     d:out std_logic);
end QD_1;

architecture my_arch of QD_1 is
signal reg_q : std_logic;
begin
process(clk,rst)
begin
	if rst='1' then
		reg_q<='0';
	elsif clk'event and clk='1' then
		reg_q<=q;
	end if;
end process;
d <= reg_q;
end my_arch;
