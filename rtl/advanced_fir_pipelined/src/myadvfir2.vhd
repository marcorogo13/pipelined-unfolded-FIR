library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity myadvfir2 is 
  port (  
    CLK :     in std_logic;
    RST_n :   in std_logic;
    DIN3k :   in std_logic_vector(8-1 downto 0);
    DIN3k1 :  in std_logic_vector(8-1 downto 0);
    DIN3k2 :  in std_logic_vector(8-1 downto 0);
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
    DOUT3k:   out std_logic_vector(8-1 downto 0);
    DOUT3k1:  out std_logic_vector(8-1 downto 0);
    DOUT3k2:  out std_logic_vector(8-1 downto 0);
    VOUT:     out std_logic
  );
end myadvfir2;


architecture struct of myadvfir2 is

    constant N_BITS : integer := 8;
    constant coeff_num : integer := 11;
    type vector is array (0 to coeff_num-1) of std_logic_vector(N_BITS-1 downto 0);

    signal branch1_to_add   : vector;
    signal branch1_out      : vector;

    signal branch2_to_add   : vector;
    signal branch2_out      : vector;

    signal branch3_to_add   : vector;
    signal branch3_out      : vector;

    signal kp2              : std_logic_vector(N_BITS-1 downto 0);
    signal kp1              : std_logic_vector(N_BITS-1 downto 0);
    signal k                : std_logic_vector(N_BITS-1 downto 0);
    signal km1              : std_logic_vector(N_BITS-1 downto 0);
    signal km2              : std_logic_vector(N_BITS-1 downto 0);
    signal km3              : std_logic_vector(N_BITS-1 downto 0);
    signal km4              : std_logic_vector(N_BITS-1 downto 0);
    signal km5              : std_logic_vector(N_BITS-1 downto 0);
    signal km6              : std_logic_vector(N_BITS-1 downto 0);
    signal km7              : std_logic_vector(N_BITS-1 downto 0);
    signal km8              : std_logic_vector(N_BITS-1 downto 0);
    signal km9              : std_logic_vector(N_BITS-1 downto 0);
    signal km10             : std_logic_vector(N_BITS-1 downto 0);
    signal d_in0            : std_logic_vector(N_BITS-1 downto 0);
    signal d_in1            : std_logic_vector(N_BITS-1 downto 0);
    signal d_in2            : std_logic_vector(N_BITS-1 downto 0);

    signal out_s      : std_logic;
    signal delay      : std_logic;

    --pipeline signals

        --branch1 adder
    signal branch1_pipe1   : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_pipe2   : std_logic_vector(N_BITS-1 downto 0);

        --branch2 adder
    signal branch2_pipe1   : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_pipe2   : std_logic_vector(N_BITS-1 downto 0);

        --branch3 adder
    signal branch3_pipe1   : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_pipe2   : std_logic_vector(N_BITS-1 downto 0);

        --branch1 mul
    signal branch1_B4_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B5_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B6_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B7_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B8_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B9_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B10_0   : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B7_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B8_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B9_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch1_B10_1   : std_logic_vector(N_BITS-1 downto 0);

        --branch2 mul
    signal branch2_B4_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B5_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B6_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B7_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B8_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B9_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B10_0   : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B7_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B8_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B9_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch2_B10_1   : std_logic_vector(N_BITS-1 downto 0);

        --branch3 mul
    signal branch3_B4_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B5_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B6_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B7_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B8_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B9_0    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B10_0   : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B7_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B8_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B9_1    : std_logic_vector(N_BITS-1 downto 0);
    signal branch3_B10_1   : std_logic_vector(N_BITS-1 downto 0);

    signal VIN_d1          : std_logic;
    signal VIN_d2          : std_logic;
    

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

    --vin delay registers

    vin_delay1 : oneBit_reg
    port map(
            Din     => VIN,
            Dout    => VIN_d1,
            Enable  => '1',
            Rst_n   => RST_n,
            Clk     => CLK 
        );

    vin_delay2 : oneBit_reg
    port map(
            Din     => VIN_d1,
            Dout    => VIN_d2,
            Enable  => '1',
            Rst_n   => RST_n,
            Clk     => CLK 
        );

    --- Register in input per i 3 ingressi separati
    input_register_0 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => DIN3k,
            Dout    => k,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK 
        );
    
        input_register_1 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => DIN3k1,
            Dout    => kp1,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );
    
        input_register_2 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => DIN3k2,
            Dout    => kp2,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );



    --- filtro vero e proprio

        --- branch 1
        br1_0_to_3  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => k,
            Dout    => km3,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_3_to_6  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km3,
            Dout    => km6,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_6_to_9  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km6,
            Dout    => km9,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        ---branch 2
        br2_1_to_2  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => kp1,
            Dout    => km2,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        br2_2_to_5  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km2,
            Dout    => km5,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        br2_5_to_8  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km5,
            Dout    => km8,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        ---branch 3
        br3_2_to_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => kp2,
            Dout    => km1,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        br3_1_to_4  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km1,
            Dout    => km4,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_4_to_7  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km4,
            Dout    => km7,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_7_to_10  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km7,
            Dout    => km10,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        ---first branch multipliers

        br1_b0 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => k,
            B       => B0,
            X       => branch1_to_add(0)
        );

        br1_b1 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => km1,
            B       => B1,
            X       => branch1_to_add(1)
        );

        br1_b2 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => km2,
            B       => B2,
            X       => branch1_to_add(2)
        );

        br1_b3 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => km3,
            B       => B3,
            X       => branch1_to_add(3)
        );

        --first pipe

        br1_B4_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km4,
            Dout    => branch1_B4_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_b4 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_B4_0,
            B       => B4,
            X       => branch1_to_add(4)
        );

        br1_B5_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km5,
            Dout    => branch1_B5_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_b5 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_B5_0,
            B       => B5,
            X       => branch1_to_add(5)
        );

        br1_B6_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km6,
            Dout    => branch1_B6_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_b6 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_B6_0,
            B       => B6,
            X       => branch1_to_add(6)
        );

        --second pipe

        br1_B7_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km7,
            Dout    => branch1_B7_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_B7_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch1_B7_0,
            Dout    => branch1_B7_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );
        
        br1_b7 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_B7_1,
            B       => B7,
            X       => branch1_to_add(7)
        );

        br1_B8_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km8,
            Dout    => branch1_B8_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_B8_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch1_B8_0,
            Dout    => branch1_B8_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_b8 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_B8_1,
            B       => B8,
            X       => branch1_to_add(8)
        );

        br1_B9_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km9,
            Dout    => branch1_B9_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_B8_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch1_B9_0,
            Dout    => branch1_B9_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_b9 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_B9_1,
            B       => B9,
            X       => branch1_to_add(9)
        );

        br1_B10_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km10,
            Dout    => branch1_B10_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_B10_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch1_B10_0,
            Dout    => branch1_B10_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_b10 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_B10_1,
            B       => B10,
            X       => branch1_to_add(10)
        );

        ---second branch multipliers

        br2_b0 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => kp1,
            B       => B0,
            X       => branch2_to_add(0)
        );

        br2_b1 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => k,
            B       => B1,
            X       => branch2_to_add(1)
        );

        br2_b2 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => km1,
            B       => B2,
            X       => branch2_to_add(2)
        );

        br2_b3 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => km2,
            B       => B3,
            X       => branch2_to_add(3)
        );

        --first pipe

        br2_B4_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km3,
            Dout    => branch2_B4_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_b4 : my_mult               
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_B4_0,
            B       => B4,
            X       => branch2_to_add(4)
        );

        br2_B5_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km4,
            Dout    => branch2_B5_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_b5 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_B5_0,
            B       => B5,
            X       => branch2_to_add(5)
        );

        br2_B6_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km5,
            Dout    => branch2_B6_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_b6 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_B6_0,
            B       => B6,
            X       => branch2_to_add(6)
        );

        --second pipe

        br2_B7_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km6,
            Dout    => branch2_B7_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_B7_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch2_B7_0,
            Dout    => branch2_B7_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_b7 : my_mult            
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_B7_1,
            B       => B7,
            X       => branch2_to_add(7)
        );

        br2_B8_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km7,
            Dout    => branch2_B8_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_B8_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch2_B8_0,
            Dout    => branch2_B8_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_b8 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_B8_1,
            B       => B8,
            X       => branch2_to_add(8)
        );

        br2_B9_0  : my_reg      
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km8,
            Dout    => branch2_B9_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_B7_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch2_B9_0,
            Dout    => branch2_B9_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_b9 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_B9_1,
            B       => B9,
            X       => branch2_to_add(9)
        );

        br2_B10_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km9,
            Dout    => branch2_B10_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_B7_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch2_B10_0,
            Dout    => branch2_B10_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br2_b10 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_B10_1,
            B       => B10,
            X       => branch2_to_add(10)
        );

        ---third branch multipliers

        br3_b0 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => kp2,
            B       => B0,
            X       => branch3_to_add(0)
        );

        br3_b1 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => kp1,
            B       => B1,
            X       => branch3_to_add(1)
        );

        br3_b2 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => k,
            B       => B2,
            X       => branch3_to_add(2)
        );

        br3_b3 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => km1,
            B       => B3,
            X       => branch3_to_add(3)
        );

        --first pipe

        br3_B4_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km2,
            Dout    => branch3_B4_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_b4 : my_mult            
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_B4_0,
            B       => B4,
            X       => branch3_to_add(4)
        );

        br3_B5_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km3,
            Dout    => branch3_B5_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_b5 : my_mult            --changed input to post pipeline
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_B5_0,
            B       => B5,
            X       => branch3_to_add(5)
        );

        br3_B6_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km4,
            Dout    => branch3_B6_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_b6 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_B6_0,
            B       => B6,
            X       => branch3_to_add(6)
        );

        --second pipe

        br3_B7_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km5,
            Dout    => branch3_B7_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_B7_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch3_B7_0,
            Dout    => branch3_B7_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_b7 : my_mult            
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_B7_1,
            B       => B7,
            X       => branch3_to_add(7)
        );

        br3_B8_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km6,
            Dout    => branch3_B8_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_B8_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch3_B8_0,
            Dout    => branch3_B8_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_b8 : my_mult            --changed input to post pipeline
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_B8_1,
            B       => B8,
            X       => branch3_to_add(8)
        );

        br3_B9_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km7,
            Dout    => branch3_B9_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_B9_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch3_B9_0,
            Dout    => branch3_B9_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_b9 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_B9_1,
            B       => B9,
            X       => branch3_to_add(9)
        );

        br3_B10_0  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => km8,
            Dout    => branch3_B10_0,
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_B10_1  : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch3_B10_0,
            Dout    => branch3_B10_1,
            Enable  => VIN_d1,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_b10 : my_mult
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_B10_1,
            B       => B10,
            X       => branch3_to_add(10)
        );


        ---first branch adders

        br1_a1 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(0),
            B       => branch1_to_add(1),
            S       => branch1_out(0)
        );

        br1_a2 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(2),
            B       => branch1_out(0),
            S       => branch1_out(1)
        );

        br1_a3 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(3),
            B       => branch1_out(1),
            S       => branch1_pipe1
        );

        --pipe1
        br1_adder_pipe1 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch1_pipe1,
            Dout    => branch1_out(2),
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        br1_a4 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(4),
            B       => branch1_out(2),
            S       => branch1_out(3)
        );

        br1_a5 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(5),
            B       => branch1_out(3),
            S       => branch1_out(4)
        );

        br1_a6 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(6),
            B       => branch1_out(4),
            S       => branch1_pipe2
        );

        --pipe2
        br1_adder_pipe2 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch1_pipe2,
            Dout    => branch1_out(5),
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br1_a7 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(7),
            B       => branch1_out(5),
            S       => branch1_out(6)
        );

        br1_a8 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(8),
            B       => branch1_out(6),
            S       => branch1_out(7)
        );

        br1_a9 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(9),
            B       => branch1_out(7),
            S       => branch1_out(8)
        );

        br1_a10 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch1_to_add(10),
            B       => branch1_out(8),
            S       => branch1_out(9)
        );

        ---second branch adders

        br2_a1 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(0),
            B       => branch2_to_add(1),
            S       => branch2_out(0)
        );

        br2_a2 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(2),
            B       => branch2_out(0),
            S       => branch2_out(1)
        );

        br2_a3 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(3),
            B       => branch2_out(1),
            S       => branch2_pipe1
        );

        --pipe1
        br2_adder_pipe1 : my_reg
        generic map(
            nbits => N_BITS
        )  
        port map(
            Din     => branch2_pipe1,
            Dout    => branch2_out(2),
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        br2_a4 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(4),
            B       => branch2_out(2),
            S       => branch2_out(3)
        );

        br2_a5 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(5),
            B       => branch2_out(3),
            S       => branch2_out(4)
        );

        br2_a6 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(6),
            B       => branch2_out(4),
            S       => branch2_pipe2
        );

        --pipe2
        br2_adder_pipe2 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch2_pipe2,
            Dout    => branch2_out(5),
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        br2_a7 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(7),
            B       => branch2_out(5),
            S       => branch2_out(6)
        );

        br2_a8 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(8),
            B       => branch2_out(6),
            S       => branch2_out(7)
        );

        br2_a9 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(9),
            B       => branch2_out(7),
            S       => branch2_out(8)
        );

        br2_a10 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch2_to_add(10),
            B       => branch2_out(8),
            S       => branch2_out(9)
        );

        ---third branch adders

        br3_a1 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(0),
            B       => branch3_to_add(1),
            S       => branch3_out(0)
        );

        br3_a2 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(2),
            B       => branch3_out(0),
            S       => branch3_out(1)
        );

        br3_a3 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(3),
            B       => branch3_out(1),
            S       => branch3_pipe1
        );

        --pipe1

        br3_adder_pipe1 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch3_pipe1,
            Dout    => branch3_out(2),
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );

        br3_a4 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(4),
            B       => branch3_out(2),
            S       => branch3_out(3)
        );

        br3_a5 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(5),
            B       => branch3_out(3),
            S       => branch3_out(4)
        );

        br3_a6 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(6),
            B       => branch3_out(4),
            S       => branch3_pipe2
        );

        --pipe2
        br3_adder_pipe2 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch3_pipe2,
            Dout    => branch3_out(5),
            Enable  => VIN,
            Rst_n   => RST_n,
            Clk     => CLK
        );


        br3_a7 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(7),
            B       => branch3_out(5),
            S       => branch3_out(6)
        );

        br3_a8 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(8),
            B       => branch3_out(6),
            S       => branch3_out(7)
        );

        br3_a9 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(9),
            B       => branch3_out(7),
            S       => branch3_out(8)
        );

        br3_a10 : my_adder
        generic map(
            nbits => N_BITS
        )
        port map(
            A       => branch3_to_add(10),
            B       => branch3_out(8),
            S       => branch3_out(9)
        );

    --- registri in output per le 3 uscite separate
    output_reg_0 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch1_out(9), -- --2 siccome gli adder sono uno in meno dei registri
            Dout    => DOUT3k,
            Enable  => '1',       --non penso vada a uno ma dovrebbe essere vin con un clock di delay?
            Rst_n   => RST_n,
            Clk     => CLK
        );

        output_reg_1 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch2_out(9), -- --2 siccome gli adder sono uno in meno dei registri
            Dout    => DOUT3k1,
            Enable  => '1',       --non penso vada a uno ma dovrebbe essere vin con un clock di delay?
            Rst_n   => RST_n,
            Clk     => CLK
        );

        output_reg_2 : my_reg
        generic map(
            nbits => N_BITS
        )
        port map(
            Din     => branch3_out(9), -- --2 siccome gli adder sono uno in meno dei registri
            Dout    => DOUT3k2,
            Enable  => '1',       --non penso vada a uno ma dovrebbe essere vin con un clock di delay?
            Rst_n   => RST_n,
            Clk     => CLK
        );



    --- delay per il segnale di output valido rispetto al segnali di input valido

    dl1 : oneBit_reg
    port map(
        Din     => VIN_d2,       --DA VERIFICARE: sostiruito VIN con VIN_d2, ovvero la sua versione ritardata di deu per via della pipeline
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

  
  
end struct;
