library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_skip_adder_qd_tb is
end carry_skip_adder_qd_tb;

architecture behavior of carry_skip_adder_qd_tb is

    constant block_size : integer := 4;
    constant block_num  : integer := 32/4; 

    signal a, b        : std_logic_vector(block_size * block_num - 1 downto 0);
    signal cin         : std_logic;
    signal clk, rst    : std_logic := '0';
    signal sum         : std_logic_vector(block_size * block_num - 1 downto 0);
    signal cout        : std_logic;

    component carry_skip_adder_qd
        generic (
            block_size: integer := 4;
            block_num: integer := 2
        );
        port(
            a    : in  std_logic_vector(block_size * block_num - 1 downto 0);
            b    : in  std_logic_vector(block_size * block_num - 1 downto 0);
            cin  : in  std_logic;
            clk, rst : in  std_logic;
            sum  : out std_logic_vector(block_size * block_num - 1 downto 0);
            cout : out std_logic
        );
    end component;

begin

    uut: carry_skip_adder_qd
        generic map(
            block_size => block_size,
            block_num => block_num
        )
        port map (
            a => a,
            b => b,
            cin => cin,
            clk => clk,
            rst => rst,
            sum => sum,
            cout => cout
        );

    -- Clock process
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

 -- Stimulus process
stim_proc: process
begin
    -- Reset
    rst <= '1';
    a <= (others => '0');
    b <= (others => '0');
    cin <= '0';
    wait for 10 ns;

    rst <= '0';

    -- Test 1: 15 + 1 = 16
    a <= std_logic_vector(to_unsigned(15, 32));  -- 00001111
    b <= std_logic_vector(to_unsigned(1, 32));   -- 00000001
    cin <= '0';
    wait for 10 ns;

    -- Test 2: 100 + 28 = 128
    a <= std_logic_vector(to_unsigned(100, 32));
    b <= std_logic_vector(to_unsigned(28, 32));
    cin <= '0';
    wait for 10 ns;

    -- Test 3: 200 + 55 = 255
    a <= std_logic_vector(to_unsigned(200, 32));
    b <= std_logic_vector(to_unsigned(55, 32));
    cin <= '0';
    wait for 10 ns;

    -- Test 4: 200 + 55 + carry-in = 256 (overflow)
    a <= std_logic_vector(to_unsigned(200, 32));
    b <= std_logic_vector(to_unsigned(55, 32));
    cin <= '1';
    wait for 10 ns;

    -- Test 5: All ones (255 + 255 + 1)
    a <= (others => '1');
    b <= (others => '1');
    cin <= '1';
    wait for 10 ns;

    -- Test 6: Zero + zero
    a <= (others => '0');
    b <= (others => '0');
    cin <= '0';
    wait for 10 ns;

    -- Finish simulation
    wait for 50 ns;
    assert false report "All test cases finished" severity failure;
end process;


end behavior;

