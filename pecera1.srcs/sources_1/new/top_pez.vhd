library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_pez is
    Port ( 
        clk   : in  STD_LOGIC;
        swt   : in  STD_LOGIC_VECTOR (3 downto 0); -- 4 sensores de compañero
        led   : out STD_LOGIC_VECTOR (2 downto 0)  -- 3 actuadores tuyos
    );
end top_pez;

architecture union of top_pez is

    component SISTEMA is
      Port (
            clk : in std_logic;
            input_system: in std_logic_vector(3 downto 0); 
            output_system: out std_logic_vector(2 downto 0)
           );
    end component;

    component actuadores is
        Port ( 
            clk       : in  STD_LOGIC;
            datos_in  : in  STD_LOGIC_VECTOR (2 downto 0);
            bomba_h2o : out STD_LOGIC;
            pwm_vent  : out STD_LOGIC;
            bomba_o2  : out STD_LOGIC
        );
    end component;

    -- Cable interno para conectar compañero contigo
    signal cable_compa_a_ti : STD_LOGIC_VECTOR (2 downto 0);

begin

    CEREBRO: SISTEMA port map(
        clk => clk,
        input_system => swt,
        output_system => cable_compa_a_ti
    );

    MUSCULOS: actuadores port map(
        clk => clk,
        datos_in => cable_compa_a_ti,   
        bomba_h2o => led(2),
        pwm_vent => led(1),
        bomba_o2 => led(0)
    );

end union;