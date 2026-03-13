library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_skip_adder is 
	generic (
		block_size: integer:= 4;
		block_num: integer:= 32/4
	);
	port(
	a    : in  std_logic_vector(block_size * block_num - 1 downto 0);
        b    : in  std_logic_vector(block_size * block_num - 1 downto 0);
        cin  : in  std_logic;
        sum  : out std_logic_vector(block_size * block_num - 1 downto 0);
        cout : out std_logic
	);

end carry_skip_adder;

architecture arch of carry_skip_adder is

	component propagate_block
    		generic (block_size : integer := 4);
    		port (
        	  a: in  std_logic_vector(block_size - 1 downto 0);
        	  b: in  std_logic_vector(block_size - 1 downto 0);
        	propagate : out std_logic);
	end component;


	component mux_2
		port(a, b: in std_logic;
		  sel: in std_logic;
		  c: out std_logic);
	end component;
	
	component adder_n 
		generic(n: integer :=8);
		port(a, b: in std_logic_vector(n-1 downto 0);
		 cin: in std_logic;
		 s: out std_logic_vector(n-1 downto 0);
		 cout: out std_logic);	
	end component;

signal carry: std_logic_vector(block_num downto 0);
signal propagate_between: std_logic_vector(block_num-1 downto 0);
signal adder_carry: std_logic_vector(block_num-1 downto 0);
begin
	
	carry(0) <= cin;
	gen: for i in 0 to block_num-1 generate
	begin

	propagate_i: propagate_block
		generic map(block_size => block_size)
		port map(
			a => a(block_size*(i+1) -1 downto i*block_size),
			b => b(block_size*(i+1) -1 downto i*block_size),	
			propagate => propagate_between(i)
		);

	adder_i: adder_n
		generic map(n => block_size)
		port map(
			a => a(block_size*(i+1) -1 downto i*block_size),
			b => b(block_size*(i+1) -1 downto i*block_size),
			cin => carry(i),
			s => sum(block_size*(i+1) -1 downto i*block_size),
			cout => adder_carry(i)
		);

	mux_i: mux_2
		port map(
			a => adder_carry(i),
			b => carry(i),
			sel => propagate_between(i),
			c => carry(i+1)
		);
	end generate;
	cout <= carry(block_num);

end arch;