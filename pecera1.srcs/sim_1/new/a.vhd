library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_main is
end tb_main;

architecture sim of tb_main is

    component main
        Port ( 
            clk   : in  STD_LOGIC;
            swt   : in  STD_LOGIC_VECTOR (7 downto 0);
            sw    : in  STD_LOGIC_VECTOR (8 downto 8);
            led   : out STD_LOGIC_VECTOR (7 downto 0);
            seg   : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    signal clk   : STD_LOGIC := '0';
    signal swt   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal sw    : STD_LOGIC_VECTOR (8 downto 8) := "0";
    signal led   : STD_LOGIC_VECTOR (7 downto 0);
    signal seg   : STD_LOGIC_VECTOR (6 downto 0);

    constant clk_period : time := 10 ns;

begin

    UUT: main port map (
        clk => clk,
        swt => swt,
        sw => sw,
        led => led,
        seg => seg
    );

    -- Reloj falso
    clk_process :process
    begin
        clk <= '0'; wait for clk_period/2;
        clk <= '1'; wait for clk_period/2;
    end process;

    -- Eventos falsos (Simular mundo de pez)
    stim_proc: process
    begin
        -- Estado 1: Todo bien
        swt(0) <= '1'; -- Agua llena
        swt(1) <= '0'; -- Temperatura OK
        swt(2) <= '0'; -- O2 OK
        wait for 5000 ns;

        -- Estado 2: Pez perder agua
        swt(0) <= '0'; -- Fuga!
        wait for 5000 ns;
        swt(0) <= '1'; -- Agua llena otra vez

        -- Estado 3: Agua caliente
        swt(1) <= '1'; -- Alarma calor!
        wait for 5000 ns;
        swt(1) <= '0'; -- Frío otra vez

        -- Estado 4: Pez no respirar
        swt(2) <= '1'; -- Alarma O2!
        wait for 5000 ns;
        
        wait; -- Fin simulacion
    end process;

end sim;