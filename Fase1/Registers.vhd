library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- um registo que contem ate 8 palavras de 8 bits cada(parametrisavel)
-- pode ler ate dois registos em simultaneo
entity Registers is
	generic(N : positive := 8;
			  RA : positive := 3);
	port(clk : in std_logic;
		 reset : in std_logic;
		 RA1 : in std_logic_vector((RA-1) downto 0);
		 RA2 : in std_logic_vector((RA-1) downto 0);
		 WA : in std_logic_vector((RA-1) downto 0);
		 WD : in std_logic_vector((N-1) downto 0);
		 WE : in std_logic;
		 RD1 : out std_logic_vector((N-1) downto 0);
		 RD2 : out std_logic_vector((N-1) downto 0));
end Registers;

architecture Behavioral of Registers is

	subtype words is std_logic_vector(7 downto  0);
	type arr is array(0 to 7) of words;
	signal s_arr : arr;
	
begin
	process(clk)
	begin
		if(reset = '1') then
			s_arr <= (others => x"00");
		else
			if(rising_edge(clk)) then
				if(WE = '1') then
					s_arr(to_integer(unsigned(WA))) <= WD;
				end if;
			end if;
		end if;
	end process;
	
	RD1 <= x"00" when RA1 = "000" else s_arr(to_integer(unsigned(RA1)));-- a posicao 000 do registo é sempre igual a x"00"(zero), nao podendo ser alterada
	RD2 <= x"00" when RA2 = "000" else s_arr(to_integer(unsigned(RA2)));
end Behavioral;