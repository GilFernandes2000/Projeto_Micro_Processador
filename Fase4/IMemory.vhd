library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--ROM que contem as intrucoes do programa

entity IMemory is
	generic(N : positive := 3;
			  D : positive := 16);
	port(clk : in std_logic;
		  En : in std_logic;
		  RA : in std_logic_vector((N-1) downto 0);--contem 8 instrucoes
		  RD : out std_logic_vector((D-1) downto 0));--as intruçoes sao todas de 16 bits cada
end IMemory;

architecture Behavioral of IMemory is

	subtype TDataWord is std_logic_vector((D-1) downto 0);--palavras de 16 bits
	type TROM is array (0 to 7) of TDataWord;-- array de comprimento 8 que armazena palvras TDataWord
	constant c_memory: TROM :=("1110000010000000", "1110000100000001", "0010010100110011", "0010010011000100", "1100000110000010", "1100001000000011", "0110110110000011", "0110010010000011");
	
begin
	process(clk, En)
	begin
		if(rising_edge(clk)) then
			if(En = '1') then
				RD <= c_memory(to_integer(unsigned(RA)));
			end if;
		end if;
	end process;
end Behavioral;