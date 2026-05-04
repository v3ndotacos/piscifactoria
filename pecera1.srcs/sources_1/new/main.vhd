library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( 
        clk   : in  STD_LOGIC;
        swt   : in  STD_LOGIC_VECTOR (7 downto 0);
        sw    : in  STD_LOGIC_VECTOR (8 downto 8);
        led   : out STD_LOGIC_VECTOR (7 downto 0);
        seg   : out STD_LOGIC_VECTOR (6 downto 0)
    );
end main;

architecture FSM_Arch of main is

    component pwm
        Port ( 
            clk      : in  STD_LOGIC;
            duty     : in  STD_LOGIC_VECTOR (7 downto 0);
            pwm_out  : out STD_LOGIC
        );
    end component;

    signal duty_fan : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    
    -- Definir Estados del Pez
    type estado_pez is (NORMAL, FALTA_AGUA, CALOR, FALTA_O2);
    signal estado : estado_pez := NORMAL;

begin

    U_PWM: pwm port map (
        clk      => clk,
        duty     => duty_fan,
        pwm_out  => led(1)
    );

    -- Transición de Estados FSM
    process(clk)
    begin
        if rising_edge(clk) then
            case estado is
            
                when NORMAL =>
                    led(0) <= '0';
                    led(2) <= '0';
                    duty_fan <= "00000000";
                    
                    if swt(0) = '0' then
                        estado <= FALTA_AGUA;
                    elsif swt(1) = '1' then
                        estado <= CALOR;
                    elsif swt(2) = '1' then
                        estado <= FALTA_O2;
                    end if;
                    
                when FALTA_AGUA =>
                    led(0) <= '1'; -- Bomba agua
                    if swt(0) = '1' then
                        estado <= NORMAL;
                    end if;
                    
                when CALOR =>
                    duty_fan <= "10000000"; -- Ventilador PWM
                    if swt(1) = '0' then
                        estado <= NORMAL;
                    end if;
                    
                when FALTA_O2 =>
                    led(2) <= '1'; -- Bomba O2
                    if swt(2) = '0' then
                        estado <= NORMAL;
                    end if;
               -- TODO
               -- Añadir sensor de temperatura que seguro que lo tienen
               --     algun actuador que tengan 100% quizas
            end case;
            
            led(7 downto 3) <= (others => '0');
            seg <= (others => '1');
            
        end if;
    end process;
end FSM_Arch;