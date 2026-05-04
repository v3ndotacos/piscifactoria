library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm is
    Port ( 
        clk      : in  STD_LOGIC;
        duty     : in  STD_LOGIC_VECTOR (7 downto 0); -- Velocidad: 0 (nada) a 255 (tope)
        pwm_out  : out STD_LOGIC
    );
end pwm;

architecture Behavioral of pwm is
    signal counter : unsigned(7 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
            
            -- Si contador menor que velocidad, encender. Si no, apagar.
            if counter < unsigned(duty) then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;