library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity myfir is 
  port (  
    CLK :     in std_logic;
    RST_n :   in std_logic;
    DIN :     in std_logic_vector(8-1 downto 0);
    VIN :     in std_logic;
    B0  :     in std_logic_vector(8-1 downto 0);
    B1  :     in std_logic_vector(8-1 downto 0);
    B2  :     in std_logic_vector(8-1 downto 0);
    B3  :     in std_logic_vector(8-1 downto 0);
    B4  :     in std_logic_vector(8-1 downto 0);
    B5  :     in std_logic_vector(8-1 downto 0);
    B6  :     in std_logic_vector(8-1 downto 0);
    B7  :     in std_logic_vector(8-1 downto 0);
    B8  :     in std_logic_vector(8-1 downto 0);
    B9  :     in std_logic_vector(8-1 downto 0);
    B10 :     in std_logic_vector(8-1 downto 0);
    DOUT:     out std_logic_vector(8-1 downto 0);
    VOUT:     out std_logic
  );
end myfir;


architecture struct of myfir is

  constant N_BITS : integer := 8;
  constant coeff_num : integer := 11;
  type vector is array (0 to coeff_num-1) of std_logic_vector(N_BITS-1 downto 0);
  --signal coefficents : vector := (B0, B1, B2, B3, B4, B5, B6, B7, B8, B9);
  signal coefficents : vector;
  signal reg_out : vector;
  signal mult_out : vector;
  signal add_out : vector;
  signal out_s : std_logic;
  signal delay : std_logic ;

  component my_reg is
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
  end component;

  component my_adder is
    generic(
        nbits : integer := 8
    );
    port(
        A       : in std_logic_vector (nbits-1 downto 0);
        B       : in std_logic_vector (nbits-1 downto 0);
        S       : out std_logic_vector (nbits-1 downto 0)
    );
  end component;

  component my_mult is
    generic(
        nbits : integer := 8
    );
    port(
        A       : in std_logic_vector (nbits-1 downto 0);
        B       : in std_logic_vector (nbits-1 downto 0);
        X       : out std_logic_vector (nbits-1 downto 0)
    );
  end component;

  component oneBit_reg is
    port(
        Din     : in std_logic;
        Dout    : out std_logic;
        Enable  : in std_logic;
        Rst_n   : in std_logic;
        Clk     : in std_logic
    );
  end component;


begin

  coefficents(0) <= B0;
  coefficents(1) <= B1;
  coefficents(2) <= B2;
  coefficents(3) <= B3;
  coefficents(4) <= B4;
  coefficents(5) <= B5;
  coefficents(6) <= B6;
  coefficents(7) <= B7;
  coefficents(8) <= B8;
  coefficents(9) <= B9;
  coefficents(10) <= B10;

  input_register : my_reg
    generic map(
        nbits => N_BITS
    )
    port map(
        Din     => DIN,
        Dout    => reg_out(0),
        Enable  => VIN,
        Rst_n   => RST_n,
        Clk     => CLK
    );
  
  for_register : for i in 1 to coeff_num-1 generate
    reg_i : my_reg
      generic map(
          nbits => N_BITS
      )
      port map(
          Din     => reg_out(i-1),
          Dout    => reg_out(i),
          Enable  => VIN,
          Rst_n   => RST_n,
          Clk     => CLK
      );
  end generate for_register;

  for_mult : for i in 0 to coeff_num-1 generate
    mult_i : my_mult
      generic map(
          nbits => N_BITS
      )
      port map(
          A       => reg_out(i),
          B       => coefficents(i),
          X       => mult_out(i)
      );
  end generate for_mult;

  add_1 : my_adder
    generic map(
        nbits => N_BITS
    )
    port map(
        A       => mult_out(0),
        B       => mult_out(1),
        S       => add_out(0)
    );

  for_add : for i in 1 to coeff_num-2 generate
    add_i : my_adder
      generic map(
          nbits => N_BITS
      )
      port map(
          A       => add_out(i-1),
          B       => mult_out(i+1),
          S       => add_out(i)
      );
  end generate for_add;


  -- nota sull'output: l'eneble è fisso a 1 così come VOUT, poichè il filtro è sempre attivo a prescindere dal numero di campioni già processati
  -- sarà necessario modificare questo comportamento con l'introduzione della pipeline
  output_reg : my_reg
    generic map(
        nbits => N_BITS
    )
    port map(
        Din     => add_out(coeff_num-2), -- --2 siccome gli adder sono uno in meno dei registri
        Dout    => DOUT,
        Enable  => '1',       --non penso vada a uno ma dovrebbe essere vin con un clock di delay?
        Rst_n   => RST_n,
        Clk     => CLK
    );

  --VOUT <= VIN;

 dl1 : oneBit_reg
   port map(
       Din     => VIN,
       Dout    => delay,
       Enable  => '1',
       Rst_n   => RST_n,
       Clk     => CLK
   );
 
 dl2 : oneBit_reg
   port map(
       Din     => delay,
       Dout    => out_s,
       Enable  => '1',
       Rst_n   => RST_n,
       Clk     => CLK
   );

  VOUT <= out_s;

  -- del : process(CLK)
  -- begin
  --   if rising_edge(CLK) then
  --     if (delay = 0) then
  --       out_s <= VIN;
  --     else
  --       delay <= delay - 1;
  --     end if ;
  --   end if;
  -- end process del;

  
  
end struct;
