library ieee;
use ieee.std_logic_1164.all;

entity adder_n is
	generic(n: integer :=8);
	port(a, b: in std_logic_vector(n-1 downto 0);
		 cin: in std_logic;
		 s: out std_logic_vector(n-1 downto 0);
		 cout: out std_logic);	
end adder_n;

architecture rtl of adder_n is

	signal c: std_logic_vector(n downto 0);
 
	component fulladder_comp is
	port(a, b, cin: in std_logic;
		 s, cout: out std_logic);
	end component;
	
begin
	c(0) <= cin;
								
	generate_label:
	for i in 0 to n-1 generate
		u_add_i: fulladder_comp port map(a => a(i),
					    b => b(i),
	          			    cin => c(i),
	   				    s => s(i),
	  				    cout => c(i+1));
	end generate;
	
	cout <= c(n);
end rtl;
