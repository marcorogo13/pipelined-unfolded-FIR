library ieee;
use ieee.std_logic_1164.all;

entity oneBit_reg is
    port(
        Din     : in std_logic;
        Dout    : out std_logic;
        Enable  : in std_logic;
        Rst_n   : in std_logic;
        Clk     : in std_logic
    );
end oneBit_reg;

architecture beh of oneBit_reg is
    begin
    process (Rst_n, Clk)
        begin
            if (Rst_n = '0')  then
                Dout <= '0';
            elsif (Enable = '1' and rising_edge(Clk)) then
                Dout <= Din;
            end if ;
    end process;
end beh;
