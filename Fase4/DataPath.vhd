library ieee;
use ieee.std_logic_1164.all;
--estrutura do datapath, ligacao de todos os bloco como pedido no projeto
entity DataPath is
	port(Clk : in std_logic;
		  reset : in std_logic;
		  EnPC : in std_logic;
		  RI : in std_logic;
		  RegDst : in std_logic;
		  RegWR : in std_logic;
		  ALUSrc : in std_logic;
		  ALUOp : in std_logic_vector(3 downto 0);
		  MemWr : in std_logic;
		  EnBNE : in std_logic;
		  MemToReg : in std_logic;
		  opcode_out : out std_logic_vector(2 downto 0);
		  func_out : out std_logic_vector(3 downto 0));
end DataPath;

architecture Structural of DataPath is

	signal s_RDIM : std_logic_vector(15 downto 0);
	signal s_RDM, s_RD1, s_RD2, s_Mux2, s_Mux3, s_res, s_Extend, s_acres: std_logic_vector(7 downto 0);
	signal s_cnt : std_logic_vector(2 downto 0);
	signal s_Mux1 : std_logic_vector(2 downto 0);
	
begin
	pc: entity work.PC(Behavioral)
				generic map(N => 3,
								S => 8)
				port map(clk => Clk,
							EnBNE => EnBNE,
							reset => reset,
							SignIn => s_acres,
							En => EnPC,
							cnt => s_cnt);
							
	acres: entity work.PC_acre(Behavioral)
				port map(clk => Clk,
							EnBNE => EnBNE,
							SignExt => s_Extend,
							res_In => s_res,
							countPlus => s_acres);
				
	imemory: entity work.IMemory(Behavioral)
				generic map(N => 3,
								D => 16)
				port map(clk => Clk,
							En => Ri,
							RA => s_cnt,
							RD => s_RDIM);
	
	mux1 : entity work.Mux2_1(Behavioral)
				generic map(N => 3)
				port map(sel => RegDst,
							dataIn0 => s_RDIM(6 downto 4),
							dataIn1 => s_RDIM(9 downto 7),
							dataOut => s_Mux1);
							
	regists : entity work.Registers(Behavioral)
				generic map(N => 8,
								RA => 3)
				port map(clk => Clk,
							reset => reset,
							RA1 => s_RDIM(12 downto 10),
							RA2 => s_RDIM(9 downto 7),
							WA => s_Mux1,
							WD => s_Mux3,
							WE => RegWr,
							RD1 => s_RD1,
							RD2 => s_RD2);
	
	mux2 : entity work.Mux2_1(Behavioral)
				generic map(N => 8)
				port map(sel => ALUSrc,
							dataIn0 => s_RD2,
							dataIn1 => s_Extend,
							dataOut => s_Mux2);
	
	alu : entity work.ALUN(Behavioral)
				generic map(N => 8)
				port map(op1 => s_RD1,
							op2 => s_Mux2,
							ALUOp => ALUOp,
							res => s_res);
						
	dmemory : entity work.DMemory(Behavioral)
				generic map(N => 8)
				port map(clk => Clk,
							WE => MemWr,
							Addr => s_res,
							WD => s_RD2,
							RD => s_RDM);
						
	mux3 : entity work.Mux2_1(Behavioral)
				generic map(N => 8)
				port map(sel => MemToReg,
							dataIn1 => s_RDM,
							dataIn0 => s_res,
							dataOut => s_Mux3);
		
	signex : entity work.SignExtend(Behavioral)
				generic map(N => 8)
				port map(InP => s_RDIM(6 downto 0),
							OutP => s_Extend);
							
	opcode_out <= s_RDIM(15 downto 13);
	func_out <= s_RDIM(3 downto 0);
end Structural;