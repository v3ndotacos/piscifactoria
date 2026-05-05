library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF is
  Port (D, CLK: in std_logic; Q, nQ: out std_logic);
end D_FF;

architecture Behavioral of D_FF is

signal q_reg: std_logic := '0';

begin

    q_reg <= D when CLK'event and CLK = '1' else
             q_reg;
             
    Q <= q_reg;
    nQ <= not q_reg;

end Behavioral;
