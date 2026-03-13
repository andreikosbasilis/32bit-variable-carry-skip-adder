library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fulladder_comp is
	port(
		a,b,cin: in std_logic;
		s,cout: out std_logic
		);
  end fulladder_comp;
  
architecture arch of fulladder_comp is 
  
	component and_comp
		port (
			a,b: in std_logic;
			c: out std_logic
			);
	end component;
	
	component or_comp
		port (
			a,b: in std_logic;
			c: out std_logic
			);
	end component;
	
	component xor_comp
		port (
			a,b: in std_logic;
			c: out std_logic
			);
	end component;
	
	signal xor1_out: std_logic;
    signal and1_out, and2_out : std_logic;
   
	
begin
	-- sum = a xor b xor cin
    xor1: xor_comp port map (a => a, b => b, c => xor1_out);
    xor2: xor_comp port map (a => xor1_out, b => cin, c => s);

    -- cout = (a and b) or (b and cin) or (a and cin)
    and1: and_comp port map (a => a, b => b, c => and1_out);
    and2: and_comp port map (a => xor1_out, b => cin, c => and2_out);
    
    or1: or_comp port map (a => and1_out, b => and2_out, c => cout);
    
end arch;
    