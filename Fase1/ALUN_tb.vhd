library ieee;
use ieee.std_logic_1164.all;

entity ALUN_tb is
end ALUN_tb;

architecture Stimulus of ALUN_tb is

	signal s_ALUOp : std_logic_vector(3 downto 0);
	signal s_op1, s_op2 : std_logic_vector(7 downto 0);
	signal s_res : std_logic_vector(7 downto 0);
	
begin

	uut: entity work.ALUN(Behavioral)
			port map(ALUOp => s_ALUOp,
						op1 => s_op1,
						op2 => s_op2,
						res => s_res);
						
	stim_proc: process
	begin
		wait for 100 ns;
		s_op1 <= x"FE";
		s_op2 <= x"01";
		s_ALUOp <= "0000";
		wait for 100 ns;
		s_op1 <= x"F1";
		s_ALUOp <= "0001";
		wait for 100 ns;
		s_ALUOp <= "0010";
		wait for 100 ns;
		s_ALUOp <= "0011";
		wait for 100 ns;
		s_op2 <= x"59";
		s_ALUOp <= "0100";
		wait for 100 ns;
		s_ALUOp <= "0101";
		wait for 100 ns;
		s_ALUOp <= "0110";
		s_op1 <= x"45";
		wait for 100 ns;
		s_ALUOp <= "0111";
		wait for 100 ns;
		s_ALUOp <= "1000";
		s_op2 <= x"DD";
		wait for 100 ns;
		s_ALUOp <= "1001";
		wait for 100 ns;
		s_op1 <= x"10";
		s_ALUOp <= "1010";
		wait for 100 ns;
		s_op2 <= x"10";
		s_ALUOp <= "1011";
		wait for 100 ns;
		s_op1 <= x"01";
		wait for 100 ns;
		s_ALUOp <= "1100";
		wait for 100 ns;
		s_op1 <= x"EE";
		s_ALUOp <= "1101";
		wait for 100 ns;
		s_ALUOp <= "1110";
		wait for 100 ns;
		s_op2 <= x"FF";
		s_ALUOp <= "1111";
		wait for 100 ns;
	end process;
end Stimulus;
			