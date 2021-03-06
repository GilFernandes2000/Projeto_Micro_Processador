library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- bloco que executa as operacoes func
entity ALUN is
	generic(N : positive := 8);
	port(op1 : in std_logic_vector((N-1) downto 0);
		 op2 : in std_logic_vector((N-1) downto 0);
		 ALUOp : in std_logic_vector(3 downto 0);
		 res : out std_logic_vector((N-1) downto 0));
end ALUN;

architecture Behavioral of ALUN is

	signal s_res : std_logic_vector((N-1) downto 0);
	signal s_Amount : integer;-- sinal usado para os deslocamentos
	
begin
	s_Amount <= to_integer(unsigned(op2));
	process(ALUOp, op1, op2, s_Amount)
	begin
		case (ALUOp) is
			when "0000" =>
				s_res <= std_logic_vector(unsigned(op1) + unsigned(op2));
				
			when "0001" =>
				s_res <= std_logic_vector(unsigned(op1) - unsigned(op2));
			
			when "0010" =>
				s_res <= op1 and op2;
			
			when "0011" =>
				s_res <= op1 or op2;
				
			when "0100" =>
				s_res <= op1 xor op2;
				
			when "0101" =>
				s_res <= op1 nor op2;
				
			when "0110" => 
				s_res <= std_logic_vector(to_unsigned((to_integer(unsigned(op1)) * to_integer(unsigned(op2))), 8));-- multiplicacao do op1 com op2 mas apenas guardando os 8 bits menos significativos
				
			when "0111" => 
				s_res <= std_logic_vector(to_unsigned((to_integer(signed(op1)) * to_integer(signed(op2))), 8));
				
			when "1000" =>
				s_res <= std_logic_vector(unsigned(op1) sll s_Amount);
				
			when "1001" => 
				s_res <= std_logic_vector(unsigned(op1) srl s_Amount);
			
			when "1010" => 
				s_res <= std_logic_vector(shift_right(signed(op1), s_Amount));
				
			when "1011" =>
				if(op1 = op2) then
					s_res <= x"01";
				else
					s_res <= x"00";
				end if;
			
			when "1100" =>
				if(signed(op1) < signed(op2)) then
					s_res <= x"01";
				else
					s_res <= x"00";
				end if;
			
			when "1101" =>
				if(unsigned(op1) < unsigned(op2)) then
					s_res <= x"01";
				else
					s_res <= x"00";
				end if;
				
			when "1110" =>
				if(signed(op1) > signed(op2)) then
					s_res <= x"01";
				else 
					s_res <= x"00";
				end if;
				
			when "1111" => 
				if(unsigned(op1) > unsigned(op2)) then
					s_res <= x"01";
				else
					s_res <= x"00";
				end if;
			
			when others =>
				s_res <= std_logic_vector(unsigned(op1) + unsigned(op2));
		end case;
	end process;
		
	res <= s_res;
end Behavioral;
				