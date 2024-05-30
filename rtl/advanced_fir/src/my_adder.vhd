library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_adder is
    generic(
        nbits : integer := 8
    );
    port(
        A       : in std_logic_vector (nbits-1 downto 0);
        B       : in std_logic_vector (nbits-1 downto 0);
        S       : out std_logic_vector (nbits-1 downto 0)
    );
end my_adder;

architecture beh of my_adder is
    signal temp : std_logic_vector (nbits downto 0);
    begin
        temp <= std_logic_vector(signed(A(nbits-1) & A) + signed(B(nbits-1) & B));
        S <= temp(nbits-1 downto 0);
end beh;