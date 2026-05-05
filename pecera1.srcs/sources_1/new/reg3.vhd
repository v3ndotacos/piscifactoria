library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG_3_PIPO is
  Port (input_reg: std_logic_vector(2 downto 0);
        clk: in std_logic;
        output_reg: out std_logic_vector(2 downto 0));
end REG_3_PIPO;

architecture Behavioral of REG_3_PIPO is
component D_FF is
  Port (D, CLK: in std_logic; Q, nQ: out std_logic);
end component;

Signal s_input: std_logic_vector(2 downto 0);
Signal s_output: std_logic_vector(2 downto 0);
Signal s_clk: std_logic;

begin
s_input <= input_reg;
s_clk <= clk;

Biestables: for i in 0 to 2 generate
    Biestable_D: D_FF Port Map(D => s_input(i), 
                               clk => s_clk,  
                               Q => s_output(i));
end generate;

output_reg <= s_output;
end Behavioral;
