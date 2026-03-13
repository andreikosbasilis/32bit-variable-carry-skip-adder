library ieee;
use ieee.std_logic_1164.all;

entity carry_skip_adder_qd is 
	generic (
		block_size: integer:= 4;
		block_num: integer:= 32/4
	);
	port(
	a    : in  std_logic_vector(block_size * block_num - 1 downto 0);
        b    : in  std_logic_vector(block_size * block_num - 1 downto 0);
        cin : in std_logic;
	clk,rst  : in  std_logic;
        sum  : out std_logic_vector(block_size * block_num - 1 downto 0);
        cout : out std_logic
	);
end carry_skip_adder_qd;

architecture arch of carry_skip_adder_qd is

	component QD
		generic (n:integer:=8);
		port(q:in std_logic_vector(n-1 downto 0);
	     	clk,rst:std_logic;
	     	d:out std_logic_vector(n-1 downto 0));
	end component;

	component QD_1
		port(q:in std_logic;
	     	clk,rst:std_logic;
	     	d:out std_logic);
	end component;

	component carry_skip_adder 
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
	end component;

signal a1,b1,sum1:std_logic_vector(block_size * block_num - 1 downto 0);
signal cin1,cout1: std_logic;

begin
	U1:QD generic map(block_size*block_num)
		port map (q=>a,
			clk=>clk,
			rst=>rst,
			d=>a1);

	U2:QD generic map(block_size*block_num)
		port map (q=>b,
			clk=>clk,
			rst=>rst,
			d=>b1);

	U3:QD_1
		port map (q=>cin,
			clk=>clk,
			rst=>rst,
			d=>cin1);

	U4: carry_skip_adder generic map(block_size=>block_size,
					block_num=>block_num)
				port map (a=>a1,
					b=>b1,
					cin=>cin1,
					sum=>sum1,
					cout=>cout1);

	U5:QD generic map(block_size*block_num)
		port map (q=>sum1,
			clk=>clk,
			rst=>rst,
			d=>sum);

	U6:QD_1
		port map (q=>cout1,
			clk=>clk,
			rst=>rst,
			d=>cout);

end arch;