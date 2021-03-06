library ieee;
use ieee.std_logic_1164.all;

entity Registers_tb is
end Registers_tb;

architecture Stimulus of Registers_tb is

	signal s_RA1, s_RA2, s_WA : std_logic_vector(2 downto 0);
	signal s_WE, s_clk, s_reset : std_logic;
	signal s_WD, s_RD1, s_RD2 : std_logic_vector(7 downto 0);
	
begin
	register_uut: entity work.Registers(Behavioral)
			port map(clk => s_clk,
					 reset => s_reset,
					 RA1 => s_RA1,
					 RA2 => s_RA2,
					 WA => s_WA,
					 WD => s_WD,
					 WE => s_WE,
					 RD1 => s_RD1,
					 RD2 => s_RD2);

	clk_process : process
	begin
		s_clk <='0'; wait for 10 ns;
		s_clk <='1'; wait for 10 ns;
	end process;
	
	stim_process: process
	begin
		wait for 5 ns;
		s_reset <= '0';
		s_WE <= '1';
		s_WA <= "011";
		s_WD <= x"32";
		wait for 50 ns;
		s_WD <= x"F3";
		s_WA <= "010";
		wait for 50 ns;
		s_RA1 <= "010";
		s_RA2 <= "011";
		wait for 50 ns;
		s_WA <= "000";
		s_WD <= x"EE";
		wait for 50 ns;
		s_RA1 <= "000";
		s_RA2 <= "000";
		wait for 50 ns;
		s_WE <= '0';
		s_WA <= "011";
		s_WD <= x"8A";
		wait for 50 ns;
		s_RA1 <= "011";
		s_RA2 <= "011";
		wait for 50 ns;
		s_reset <= '1';
		s_RA1 <= "011";
		s_RA2 <= "011";
		wait for 50 ns;
		s_WE <= '1';
		s_reset <= '0';
		s_WA <= "011";
		s_WD <= x"8A";
		s_RA1 <= "011";
		s_RA2 <= "010";
		wait for 50 ns;
		wait;
	end process;
end Stimulus;