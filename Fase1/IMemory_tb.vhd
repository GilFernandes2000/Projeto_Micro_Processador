library ieee;
use ieee.std_logic_1164.all;

entity IMemory_tb is
end IMemory_tb;

architecture Stimulus of IMemory_tb is

	signal s_En, s_clk: std_logic;
	signal s_RA : std_logic_vector(2 downto 0);
	signal s_RD : std_logic_vector(15 downto 0);
	
begin
	uut : entity work.IMemory(Behavioral)
				port map(clk => s_clk,
							En => s_EN,
							RA => s_RA,
							RD => s_RD);
	clk_proc : process
	begin
		s_clk <= '0'; wait for 10 ns;
		s_clk <= '1'; wait for 10 ns;
	end process;
	
	stim_proc : process
	begin
		wait for 10 ns;
		s_En <= '1';
		s_RA <= "000";
		wait for 50 ns;
		s_RA <= "001";
		wait for 50 ns;
		s_RA <= "010";
		wait for 50 ns;
		s_RA <= "011";
		wait for 50 ns;
		s_RA <= "100";
		wait for 50 ns;
		s_RA <= "101";
		wait for 50 ns;
		s_RA <= "110";
		wait for 50 ns;
		s_RA <= "111";
		wait for 50 ns;
	end process;
end Stimulus;