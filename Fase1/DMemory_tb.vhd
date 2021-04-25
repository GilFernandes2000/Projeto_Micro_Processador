library ieee;
use ieee.std_logic_1164.all;

entity DMemory_tb is
end DMemory_tb;

architecture Stimulus of DMemory_tb is

	signal s_clk, s_we:std_logic;
	signal s_addr, s_wd, s_rd : std_logic_vector(7 downto 0);
	
begin

	ram_ut : entity work.DMemory(Behavioral)
				port map(clk => s_clk,
							WE => s_we,
							WD => s_wd,
							Addr => s_addr,
							RD => s_rd);
							
						
	clk_process : process
	begin
		s_clk <= '0'; wait for 10 ns;
		s_clk <= '1'; wait for 10 ns;
	end process;
	
	stim_process : process
	begin
		wait for 5 ns;
		s_addr <= "00000000";
		wait for 20 ns;
		s_addr <= "00000001";
		wait for 20 ns;
		s_we <= '1';
		s_addr <= "00000000";
		s_wd <= X"55";
		wait for 20 ns;
		s_addr <= "00000001";
		wait for 20 ns;
		s_wd <= X"AA";
		s_addr <= "00010000";
		wait for 20 ns;
		s_addr <= "00011100";
		wait for 20 ns;
		s_we <= '0';
		s_addr <= "00000000";
		wait for 20 ns;
		s_addr <= "00011000";
		wait for 20 ns;
		s_addr <= "00100000";
		wait for 20 ns;
		s_addr <= "00111100";
		wait for 20 ns;
		s_addr <= "00111000";
		wait for 20 ns;
	end process;
end Stimulus;