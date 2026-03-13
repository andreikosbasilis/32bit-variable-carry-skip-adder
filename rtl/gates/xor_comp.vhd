library ieee;
use ieee.std_logic_1164.all;

entity xor_comp is
	port(
  	a,b : in std_logic;
  	c : out std_logic
  	);
end xor_comp;

architecture arch of xor_comp is
  begin
  c <= a xor b;
end arch;