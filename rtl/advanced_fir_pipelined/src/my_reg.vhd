library ieee;
use ieee.std_logic_1164.all;

entity my_reg is
    generic(
        nbits : integer := 8
    );
    port(
        Din     : in std_logic_vector (nbits-1 downto 0);
        Dout    : out std_logic_vector (nbits-1 downto 0);
        Enable  : in std_logic;
        Rst_n   : in std_logic;
        Clk     : in std_logic
    );
end my_reg;

architecture beh of my_reg is
    begin
    process (Rst_n, Clk)
        begin
            if (Rst_n = '0')  then
                Dout <= (others => '0');
            elsif (Enable = '1' and rising_edge(Clk)) then
                Dout <= Din;
            end if ;
    end process;
end beh;
