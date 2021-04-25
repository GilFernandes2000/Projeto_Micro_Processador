library ieee;
use ieee.std_logic_1164.all;

entity Processor is
	port(clk : in std_logic;
		 reset : in std_logic);
end Processor;

architecture Structural of Processor is

	signal s_func, s_ALUOp : std_logic_vector(3 downto 0);
	signal s_opcode : std_logic_vector(2 downto 0);
	signal s_EnPC, s_RI, s_RegWr, s_RegDst, s_ALUSrc, s_MemWr, s_MemtoReg : std_logic;
	
begin

	controlUnit : entity work.ControlUnit(Behavioral)
					port map(clk => clk,
							 reset => reset,
							 opcode => s_opcode,
							 func => s_func,
							 EnPC => s_EnPC,
							 RI => s_RI,
							 RegWr => s_RegWr,
							 RegDst => s_RegDst,
							 ALUSrc => s_ALUSrc,
							 ALUOp => s_ALUOp,
							 MemWr => s_MemWr,
							 MemtoReg => s_MemtoReg);
							 
	dataPath : entity work.DataPath(Structural)
					port map(Clk => clk,
							 reset => reset,
							 opcode_out => s_opcode,
							 func_out => s_func,
							 EnPC => s_EnPC,
							 RI => s_RI,
							 RegWr => s_RegWr,
							 RegDst => s_RegDst,
							 ALUSrc => s_ALUSrc,
							 ALUOp => s_ALUOp,
							 MemWr => s_MemWr,
							 MemtoReg => s_MemtoReg);
							 
end Structural;