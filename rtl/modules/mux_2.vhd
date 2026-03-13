library ieee;
use ieee.std_logic_1164.all; 

entity mux_2 is
	port(a, b: in std_logic;
		sel: in std_logic;
		c: out std_logic);
end mux_2;

architecture arch1 of mux_2 is
begin 
	with sel select
		c <= a when '0',
		b when others;
end; 
