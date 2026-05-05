library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LOGICA is
  Port (input_logic: in std_logic_vector(15 downto 0); 
        output_logic: out std_logic_vector(2 downto 0)
        );
end LOGICA;

architecture Behavioral of LOGICA is

component compare is
    port (
        A, B    : in  std_logic_vector(15 downto 0);
        Greater : out std_logic;  
        Equal   : out std_logic;  
        Lower   : out std_logic   
    );
end component;

component AND_2 is
  Port (A,B: in std_logic; O: out std_logic);
end component;

component OR_2 is
  Port (A,B: in std_logic; O: out std_logic);
end component;

signal s_input: std_logic_vector(15 downto 0);
signal s_output: std_logic_vector(2 downto 0);

signal s_greater1: std_logic;
signal s_equal1: std_logic;
signal s_lower1: std_logic;

signal s_greater2: std_logic;
signal s_equal2: std_logic;
signal s_lower2: std_logic;

signal s_or1: std_logic;
signal s_or2: std_logic;
signal s_and: std_logic;

begin
s_input <= input_logic;
comparator1: compare port map (A=>s_input, B=>"1111111100000000", Greater=>s_greater1, Equal=>s_equal1, Lower=>s_lower1);
comparator2: compare port map (A=>s_input, B=>"0000000011111111", Greater=>s_greater2, Equal=>s_equal2, Lower=>s_lower2);
and_door: and_2 port map (A=> s_lower1, B=> s_greater2, O=> s_and);
or_door1: or_2 port map (A=> s_greater1, B=> s_equal1, O=> s_or1);
or_door2: or_2 port map (A=> s_lower2, B=> s_equal2, O=> s_or2);

s_output(0) <= s_or1;
s_output(1) <= s_and;
s_output(2) <= s_or2;

output_logic <= s_output;
--    output_logic <= "100" when input_logic = "0000" else
--    "100" when input_logic = "0001" else
--    "100" when input_logic = "0010" else
--    "100" when input_logic = "0011";
    
--    output_logic <= "010" when input_logic = "0100" else
--    "010" when input_logic = "0101" else
--    "010" when input_logic = "0110" else
--    "010" when input_logic = "0111" else
    
--    "010" when input_logic = "1000" else
--    "010" when input_logic = "1001" else
--    "010" when input_logic = "1010" else
--    "010" when input_logic = "1011";
    
--    output_logic <= "001" when input_logic = "1100" else
--    "001" when input_logic = "1101" else
--    "001" when input_logic = "1110" else
--    "001" when input_logic = "1111";
    
end Behavioral;