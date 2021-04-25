library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit_tb is
end ControlUnit_tb;

architecture Stimulus of ControlUnit_tb is

	signal s_clk, s_reset, s_EnPC, s_RI, s_RegWr, s_RegDst, s_ALUSrc, s_MemWr, s_MemtoReg : std_logic;
	signal s_opcode : std_logic_vector(2 downto 0);
	signal s_func, s_ALUOp : std_logic_vector(3 downto 0);
	
begin
	uut: entity work.ControlUnit(Behavioral)
			port map(clk => s_clk,
						reset => s_reset,
						opcode => s_opcode,
						func => s_func,
						EnPC => s_EnPC,
						RI => s_RI,
						RegWr => s_RegWr,
						RegDst => s_RegDst,
						ALUSrc => s_ALUSrc,
						MemWr => s_MemWr,
						MemtoReg => s_MemtoReg,
						ALUOp => s_ALUOp);
						
	clk_proc : process
	begin
		s_clk <= '0'; wait for 10 ns;
		s_clk <= '1'; wait for 10 ns;
	end process;
	
	stim_proc : process
	begin
		wait for 10 ns;
		s_reset <= '0';
		s_opcode <= "001";
		s_func <= "1001";
		wait for 60 ns;
		s_opcode <= "100";
		wait for 60 ns;
		s_reset <= '1';
		wait for 20 ns;
		s_reset <= '0';
		s_opcode <= "110";
		wait for 60 ns;
		s_opcode <= "111";
		wait for 60 ns;
	end process;
end Stimulus;