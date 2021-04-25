library ieee;
use ieee.std_logic_1164.all;

entity Mux2_1 is
	generic(N : positive := 3);
	port(sel : in std_logic;
		  dataIn0 : in std_logic_vector((N-1) downto 0);
		  dataIn1 : in std_logic_vector((N-1) downto 0);
		  dataOut : out std_logic_vector((N-1) downto 0));
end Mux2_1;

architecture Behavioral of Mux2_1 is
begin
	process(sel, dataIn0, dataIn1)
	begin
		if(sel = '0') then
			dataOut <= dataIn0;
		else
			dataOut <= dataIn1;
		end if;
	end process;
end Behavioral;