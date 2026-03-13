library ieee;
use ieee.std_logic_1164.all;

entity or_comp is
  port(
    a,b: in std_logic;
    c: out std_logic
    );
  end or_comp;
  
  architecture or_comp_arch of or_comp is
    begin
      c <= a or b;
  end or_comp_arch;
