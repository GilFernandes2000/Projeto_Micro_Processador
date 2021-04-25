library ieee;
use ieee.std_logic_1164.all;

entity Mux2_1_8bits is
	port(sel : in std_logic;
		  dataIn0 : in std_logic_vector(7 downto 0);
		  dataIn1 : in std_logic_vector(7 downto 0);
		  dataOut : out std_logic_vector(7 downto 0));
end Mux2_1_8bits;

architecture Behavioral of Mux2_1_8bits is
begin
	with sel select
				dataOut <= dataIn0 when '0',
						     dataIn1 when '1',
						     "XXXXXXXX" when others;
end Behavioral;