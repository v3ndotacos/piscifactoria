library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SISTEMA is
  Port (input_system: in std_logic_vector(15 downto 0); 
        output_system: out std_logic_vector(2 downto 0));
end SISTEMA;

architecture Behavioral of SISTEMA is

component LOGICA is
  Port (input_logic: in std_logic_vector(15 downto 0); 
        output_logic: out std_logic_vector(2 downto 0)
        );
end component;

component REG_PIPO is
  Port (input_reg: std_logic_vector(15 downto 0);
        clk: in std_logic;
        output_reg: out std_logic_vector(15 downto 0));
end component;

component REG_3_PIPO is
  Port (input_reg: std_logic_vector(2 downto 0);
        clk: in std_logic;
        output_reg: out std_logic_vector(2 downto 0));
end component;

signal bus_datos_in: std_logic_vector(15 downto 0);
signal bus_datos_out: std_logic_vector(2 downto 0);

signal input_signal: std_logic_vector(15 downto 0);
signal output_signal: std_logic_vector(2 downto 0);

signal s_clk: std_logic;

begin

input_signal <= input_system;

Reg_input: REG_PIPO Port Map(input_reg => input_signal, 
                               clk=> s_clk, 
                               output_reg=>bus_datos_in);
                               
Reg_output: REG_3_PIPO Port Map(input_reg => bus_datos_out,
                                clk=> s_clk,
                                output_reg=>output_signal); 
                                
Control: LOGICA Port Map(input_logic => bus_datos_in,
                         output_logic=> bus_datos_out);

output_system <= output_signal;

end Behavioral;
