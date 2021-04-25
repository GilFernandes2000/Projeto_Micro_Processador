library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
	port(clk : in std_logic;
		  reset : in std_logic;
		  opcode: in std_logic_vector(2 downto 0);
	     func : in std_logic_vector(3 downto 0);
		  EnPC : out std_logic;
		  RI : out std_logic;
		  RegWr : out std_logic;
		  RegDst : out std_logic;
		  ALUSrc : out std_logic;
		  ALUOp : out std_logic_vector(3 downto 0);
		  MemWr : out std_logic;
		  MemtoReg : out std_logic);
end ControlUnit;

architecture Behavioral of ControlUnit is

	type type_fstate is (S0, S1, S2, S3, S4);
	signal fstate : type_fstate;
	signal reg_fstate : type_fstate;
	
begin
	process(clk, reg_fstate)
	begin
		if(rising_edge(clk))then
			fstate <= reg_fstate;
		end if;
	end process;
	
	process(fstate, reset, opcode, func)
	begin
		if(reset = '1') then
			reg_fstate <= S0;
			EnPc <= '0';
			RI <= '0';
			RegWr <= '0';
			RegDst <= '0';
			ALUSrc <= '0';
			ALUOp <= "0000";
			MemWr <= '0';
			MemtoReg <= '0';
		else
			case fstate is 
				when S0 => 
					EnPc <= '1';
					RI <= '1';
					RegWr <= '0';
					RegDst <= '0';
					ALUSrc <= '0';
					ALUOp <= "0000";
					MemWr <= '0';
					MemtoReg <= '0';
					reg_fstate <= S1;
				when S1 =>
					EnPc <= '0';
					RI <= '0';
					RegWr <= '0';
					RegDst <= '0';
					ALUSrc <= '0';
					ALUOp <= "0000";
					MemWr <= '0';
					MemtoReg <= '0';
					reg_fstate <= S2;
				when S2 => 
					case opcode is
						when "000" =>--NOP
							EnPc <= '0';
							RI <= '0';
							RegWr <= '0';
							RegDst <= '0';
							ALUSrc <= '0';
							ALUOp <= "0000";
							MemWr <= '0';
							MemtoReg <= '0';
							reg_fstate <= S0;
						when "001"=>--funcoes ALU
							EnPc <= '0';
							RI <= '0';
							RegWr <= '0';
							RegDst <= '0';
							ALUSrc <= '1';
							ALUOp <= func;
							MemWr <= '0';
							MemtoReg <= '0';
							reg_fstate <= S3;
						when "100" =>--ADDI
							EnPc <= '0';
							RI <= '0';
							RegWr <= '0';
							RegDst <= '0';
							ALUSrc <= '1';
							ALUOp <= "0000";
							MemWr <= '0';
							MemtoReg <= '0';
							reg_fstate <= S3;
						when "110" =>--SW
							EnPc <= '0';
							RI <= '0';
							RegWr <= '0';
							RegDst <= '0';
							ALUSrc <= '1';
							ALUOp <= "0000";
							MemWr <= '0';
							MemtoReg <= '0';
							reg_fstate <= S4;
						when "111"=>--LW
							EnPc <= '0';
							RI <= '0';
							RegWr <= '0';
							RegDst <= '0';
							ALUSrc <= '1';
							ALUOp <= "0000";
							MemWr <= '0';
							MemtoReg <= '0';
							reg_fstate <= S3;
						when others =>
							EnPc <= '0';
							RI <= '0';
							RegWr <= '0';
							RegDst <= '0';
							ALUSrc <= '0';
							ALUOp <= "0000";
							MemWr <= '0';
							MemtoReg <= '0';
							reg_fstate <= S2;
					end case;
				when S3 =>--RegUpdate
					EnPc <= '0';
					RI <= '0';
					RegWr <= '1';
					RegDst <= '0';
					ALUSrc <= '0';
					ALUOp <= "0000";
					MemWr <= '0';
					MemtoReg <= '1';
					reg_fstate <= S0;
				when S4 =>--WriteMem
					EnPc <= '0';
					RI <= '0';
					RegWr <= '0';
					RegDst <= '0';
					ALUSrc <= '1';
					ALUOp <= "0000";
					MemWr <= '1';
					MemtoReg <= '0';
					reg_fstate <= S0;
				when others =>
					EnPc <= 'X';
					RI <= 'X';
					RegWr <= 'X';
					RegDst <= 'X';
					ALUSrc <= 'X';
					ALUOp <= "XXXX";
					MemWr <= 'X';
					MemtoReg <= 'X';
					report "Estado nao definido";
					reg_fstate <= S0;
			end case;
		end if;
	end process;
end Behavioral;
				