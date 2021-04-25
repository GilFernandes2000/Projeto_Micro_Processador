library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--guarda os endereços das instrucoes
--parametrisavel
entity PC is
	generic(N : positive := 3;
			  S : positive := 8);
	port(clk : in std_logic;
		  EnBNE : in std_logic;
	     reset : in std_logic;
		  En : in std_logic;
		  SignIn : in std_logic_vector((S-1) downto 0);
		  cnt : out std_logic_vector((N-1) downto 0));
end PC;

architecture Behavioral of PC is

	signal s_count : integer := 0;
	constant max : integer := 7;
	signal s_Sign : integer;
	
begin
	s_Sign <= to_integer(unsigned(SignIn));
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset = '1') then
				s_count <= 0;
			else
				if(s_count = max) then
					s_count <= 0;
				elsif(EnBNE = '1') then
					s_count <= s_count + s_Sign;
				elsif(En = '1') then
					s_count <= s_count + 1;
				end if;
			end if;
		end if;
	end process;
	cnt <= std_logic_vector(to_unsigned(s_count,N));
end Behavioral;