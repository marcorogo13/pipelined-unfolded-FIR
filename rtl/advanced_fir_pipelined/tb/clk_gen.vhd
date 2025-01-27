library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
  port (
    END_SIM : in  std_logic;
    CLK     : out std_logic;
    RST_n   : out std_logic);
end clk_gen;

architecture beh of clk_gen is

  constant Ts : time := 4800 ps;
  
  signal CLK_i : std_logic := '1';
  
begin  -- beh

  process
  begin  -- process
    CLK_i <= not(CLK_i);
    wait for Ts/2;
  end process;

  CLK <= CLK_i and not(END_SIM);

  process
  begin  -- process
    RST_n <= '0';
    wait for 4900 ps;
    RST_n <= '1';
    wait;
  end process;

end beh;
