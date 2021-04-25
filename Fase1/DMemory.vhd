library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- RAM que armazena ate 256 palavras de 8 bits cada
entity DMemory is
	generic(N : positive := 8);
	port(clk : in std_logic;
		 WE : in std_logic;
		 Addr : in std_logic_vector((N-1) downto 0);
		 WD : in std_logic_vector((N-1) downto 0);
		 RD : out std_logic_vector((N-1) downto 0));
end DMemory;

architecture Behavioral of DMemory is

	constant NUM_WORDS : integer := (2**N);
	subtype TDataWord is std_logic_vector((N-1) downto 0);
	type TMemory is array (0 to NUM_WORDS-1) of TDataWord;-- temos aqui o array onde se vao guardar as palavras
	signal s_memory : TMemory := (x"F5", x"32", others => x"00");
	
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(WE ='1') then
				s_memory(to_integer(unsigned(Addr))) <= WD;
			end if;
		end if;
	end process;
	
	RD <= s_memory(to_integer(unsigned(Addr)));
end Behavioral;