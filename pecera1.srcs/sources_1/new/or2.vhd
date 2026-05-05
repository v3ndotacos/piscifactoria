library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR_2 is
  Port (A,B: in std_logic; O: out std_logic);
end OR_2;

architecture Behavioral of OR_2 is

begin

    O <= A or B;
end Behavioral;
