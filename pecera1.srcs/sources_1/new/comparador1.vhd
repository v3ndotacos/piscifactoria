library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- Para comparaciones con unsigned

entity compare is
    port (
        A, B    : in  std_logic_vector(15 downto 0);
        Greater : out std_logic;  
        Equal   : out std_logic;  
        Lower   : out std_logic   
    );
end compare;

architecture behavioral of compare is
begin
    Greater <= '1' when unsigned(A) > unsigned(B) else '0';
    Equal   <= '1' when unsigned(A) = unsigned(B) else '0';
    Lower   <= '1' when unsigned(A) < unsigned(B) else '0';
end behavioral;
