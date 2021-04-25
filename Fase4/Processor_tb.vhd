library ieee;
use ieee.std_logic_1164.all;

entity Processor_tb is
end Processor_tb;

architecture Stimulus of Processor_tb is
	
	signal s_clk, s_reset : std_logic;
	
begin
	
	processor_ut : entity work.Processor(Structural)
					port map(clk => s_clk,
							 reset => s_reset);
	clk_proc : process
	begin
		s_clk <= '0'; wait for 10 ns;
		s_clk <= '1'; wait for 10 ns;
	end process;
	
	stim_proc : process
	begin
		wait for 5 ns;
		s_reset <= '0';
		wait for 700 ns;
		s_reset <= '1';
		wait for 50 ns;
		s_reset <= '0';
		wait for 200 ns;
	end process;
end Stimulus;