library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_acre is
	port(clk : in std_logic;
		  EnBNE : in std_logic;
		  SignExt : in std_logic_vector(7 downto 0);
		  res_In : in std_logic_vector(7 downto 0);
		  countPlus : out std_logic_vector(7 downto 0));
end PC_acre;

architecture Behavioral of PC_acre is
begin
	process(clk, EnBNE)
	begin
		if(rising_edge(clk)) then
			if(EnBNE = '1') then
				if(res_In = x"01") then
					countPlus <= SignExt;
				else
					countPlus <= x"00";
				end if;
			end if;
		end if;
	end process;
end Behavioral;