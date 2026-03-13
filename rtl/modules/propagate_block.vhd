library ieee;
use ieee.std_logic_1164.all;

entity propagate_block is
    generic (
        block_size : integer := 4
    );
    port (
        a      : in  std_logic_vector(block_size - 1 downto 0);
        b      : in  std_logic_vector(block_size - 1 downto 0);
        propagate : out std_logic
    );
end propagate_block;

architecture behavioral of propagate_block is
    signal p : std_logic_vector(block_size - 1 downto 0);
    signal propagate_chain : std_logic_vector(block_size downto 0);
begin

    propagate_chain(0) <= '1'; 

    gen_propagate: for i in 0 to block_size - 1 generate
        p(i) <= a(i) xor b(i);  

        propagate_chain(i + 1) <= propagate_chain(i) and p(i);
    end generate;

    propagate <= propagate_chain(block_size);

end behavioral;

