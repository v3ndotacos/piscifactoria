library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity actuadores is
    Port ( 
        clk       : in  STD_LOGIC;
        datos_in  : in  STD_LOGIC_VECTOR (2 downto 0); -- 3 bits de compañero
        bomba_h2o : out STD_LOGIC;
        pwm_vent  : out STD_LOGIC;
        bomba_o2  : out STD_LOGIC
    );
end actuadores;

architecture arch of actuadores is
    component pwm
        Port ( 
            clk      : in  STD_LOGIC;
            duty     : in  STD_LOGIC_VECTOR (7 downto 0);
            pwm_out  : out STD_LOGIC
        );
    end component;
    
    signal duty_fan : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
begin
    U_PWM: pwm port map (
        clk      => clk,
        duty     => duty_fan,
        pwm_out  => pwm_vent
    );

    -- Bit 2 manda en Bomba de Agua
    bomba_h2o <= datos_in(2);
    
    -- Bit 1 manda en Ventilador (Velocidad PWM a 128)
    duty_fan <= "10000000" when datos_in(1) = '1' else "00000000";

    -- Bit 0 manda en Bomba de Oxígeno
    bomba_o2 <= datos_in(0);

end arch;