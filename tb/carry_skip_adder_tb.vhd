library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_skip_adder_tb is
end carry_skip_adder_tb;

architecture behavior of carry_skip_adder_tb is

    constant block_size : integer := 4;
    constant block_num  : integer := 4;
    constant WIDTH      : integer := block_size * block_num;

    signal a     : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
    signal b     : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
    signal cin   : std_logic_vector(0 downto 0) := "0";
    signal sum   : std_logic_vector(WIDTH - 1 downto 0);
    signal cout  : std_logic_vector(0 downto 0);

    -- DUT component declaration
    component carry_skip_adder is 
        generic (
            block_size: integer := 4;
            block_num: integer := 4
        );
        port (
            a    : in  std_logic_vector(block_size * block_num - 1 downto 0);
            b    : in  std_logic_vector(block_size * block_num - 1 downto 0);
            cin  : in  std_logic_vector(0 downto 0);
            sum  : out std_logic_vector(block_size * block_num - 1 downto 0);
            cout : out std_logic_vector(0 downto 0)
        );
    end component;

begin

    -- Instantiate DUT
    uut: carry_skip_adder
        generic map (
            block_size => block_size,
            block_num  => block_num
        )
        port map (
            a    => a,
            b    => b,
            cin  => cin,
            sum  => sum,
            cout => cout
        );

    -- Test process
    stimulus: process
        variable a_int, b_int, sum_int: integer;
    begin

        report "Starting simulation...";

        -- Test case 1: 15 + 1
        a <= std_logic_vector(to_unsigned(15, WIDTH));
        b <= std_logic_vector(to_unsigned(1, WIDTH));
        cin <= "0";
        wait for 10 ns;
        a_int := to_integer(unsigned(a));
        b_int := to_integer(unsigned(b));
        sum_int := to_integer(unsigned(sum));
      
        -- Test case 2: max + 1
        a <= std_logic_vector(to_unsigned(2**WIDTH - 1, WIDTH));
        b <= std_logic_vector(to_unsigned(1, WIDTH));
        cin <= "0";
        wait for 10 ns;
       
        -- Test case 3: 12345 + 6789
        a <= std_logic_vector(to_unsigned(12345, WIDTH));
        b <= std_logic_vector(to_unsigned(6789, WIDTH));
        cin <= "1";
        wait for 10 ns;

        report "Test completed.";
        wait;
    end process;

end behavior;

