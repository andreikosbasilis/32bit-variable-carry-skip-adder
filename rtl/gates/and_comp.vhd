library ieee;
use ieee.std_logic_1164.all;

entity and_comp is 
  port(a,b: in std_logic;
    c: out std_logic);
  end and_comp;
  
  architecture arch of and_comp is 
  begin
      c <= a and b;
  end arch;
    