library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_mult is
    generic(
        nbits : integer := 8
    );
    port(
        A       : in std_logic_vector (nbits-1 downto 0);
        B       : in std_logic_vector (nbits-1 downto 0);
        X       : out std_logic_vector (nbits-1 downto 0)
    );
end my_mult;

architecture beh of my_mult is
    signal x_int : std_logic_vector (2*nbits-1 downto 0);
    signal x_int2 : std_logic_vector (nbits-1 downto 0);
    begin
        x_int <= std_logic_vector(signed(A) * signed(B));
        X <= x_int(2*nbits-2 downto 2*nbits - 2 - 7); --tagliamo il bit di segno poi teniamo i primi 7 bit dopo la virgola
        --x_int2 <= x_int(2*nbits-1 downto 2*nbits - 1 - 7); -- old version, used to mimic the C behavior
        --X <= x_int2(nbits-2 downto 0) & '0';

end beh;
