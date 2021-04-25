library ieee;
use ieee.std_logic_1164.all;

entity PC_tb is
end PC_tb;

architecture Stimulus of PC_tb is

	signal s_clk, s_En,s_EnBNE, s_reset : std_logic;
	signal s_cnt : std_logic_vector(2 downto 0);
	signal s_SignIn : std_logic_vector(7 downto 0);
	
begin

	uut : entity work.PC(Behavioral)
		port map(clk => s_clk,
					EnBNE => s_EnBNE,
					SignIn => s_SignIn,
					reset => s_reset,
					En => s_En,
					cnt => s_cnt);
					
	clk_proc : process
	begin
		s_clk <= '0'; wait for 10 ns;
		s_clk <= '1'; wait for 10 ns;
	end process;
	
	stim_proc : process
	begin
		wait for 10 ns;
		s_reset <= '0';
		s_En <= '1';
		wait for 200 ns;
		s_EnBNE <= '1';
		s_SignIn <= "00011101";
		wait for 50 ns;
		s_EnBNE <= '0';
		s_SignIn <= "00010001";
		s_reset <= '1';
		wait for 50 ns;
		s_reset <= '0';
		s_En <= '0';
		wait for 100 ns;
		s_En <= '1';
		wait for 100 ns;
	end process;
end Stimulus;
		