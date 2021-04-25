library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- converte um sinal  de M bits para N bits
entity SignExtend is
	generic(N : positive := 8);
	port(InP : in std_logic_vector(6 downto 0);
		  OutP : out std_logic_vector((N-1) downto 0));
end SignExtend;

architecture Behavioral of SignExtend is
begin
	OutP <= std_logic_vector(resize(signed(InP), N));
end Behavioral;
		  