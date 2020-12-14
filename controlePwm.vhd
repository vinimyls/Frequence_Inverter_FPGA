	
	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

	entity controlePwm is
	port(
		signal estado_pwm             		: in std_logic_vector(3 downto 0);
		signal clk_50Mhz              		: in std_logic;
		signal ciclo_ativo_senoide_positiva : out std_logic_vector(7 downto 0);
		signal ciclo_ativo_senoide_negativa : out std_logic_vector(7 downto 0)
	);
	end entity;	
	
	architecture logica of controlePwm is
		type seno is array (0 to 45) of std_logic_vector(7 downto 0);										
		signal seno_onda: seno := ("00000000","00010010","00100011","00110101","01000110","01010111","01101000","01111000","10000111","10010110","10100100","10110001","10111110","11001001","11010011","11010011","11100101","11101100","11110011","11110111","11111011","11111110","11111111","11111111","11111110","11111011","11110111","11110011","11101100","11100101","11011101","11010011","11001001","10111110","10110001","10100100","10010110","10000111","01111000","01101000","01010111","01000110","00110101","00100011","00010010","00000000");
		signal ciclo_ativo_controlado_positivo_aux : std_logic_vector(7 downto 0);
		signal ciclo_ativo_controlado_negativo_aux : std_logic_vector(7 downto 0);
	begin
		
		process(clk_50Mhz, estado_pwm)
			variable contador_base 			 : integer := 0;
			variable contador_1us  			 : integer := 0;
			variable posicao_no_vetor_seno : integer := 0;
			variable seno_positivo_negativo : integer := 0;
		begin
			
			if(rising_edge(clk_50Mhz)) then
			
				contador_base := contador_base + 1;
				if(contador_base = 50) then
					contador_1us := contador_1us + 1;
					contador_base := 0;
				end if;
				
				case estado_pwm is
				
					when "0000" =>
					
						ciclo_ativo_controlado_positivo_aux <= seno_onda(0);
						ciclo_ativo_controlado_negativo_aux <= seno_onda(0);
						
					when "0001" =>
						
						if(contador_1us >= 2174) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
						
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "0010" =>
					
						if(contador_1us >= 1087) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
						
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "0011" =>
						
						if(contador_1us >= 725) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "0100" =>
					
						if(contador_1us >= 543) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "0101" =>
					
						if(contador_1us >= 435) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "0110" =>
					
						if(contador_1us >= 362) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "0111" =>
					
						if(contador_1us >= 311) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "1000" =>
					
						if(contador_1us >= 272) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "1001" =>
					
						if(contador_1us >= 242) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;

					when "1010" =>
					
						if(contador_1us >= 217) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "1011" =>
					
						if(contador_1us >= 198) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when "1100" =>
					
						if(contador_1us >= 181) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
					when others =>
					
						if(contador_1us >= 181) then
							if(posicao_no_vetor_seno < 45) then
								posicao_no_vetor_seno := posicao_no_vetor_seno + 1;
							else
								posicao_no_vetor_seno := 0;
								
								if(seno_positivo_negativo = 0) then
									seno_positivo_negativo := 1;
								else
									seno_positivo_negativo := 0;
								end if;
								
							end if;
							contador_1us := 0;
						end if;
					
						if(seno_positivo_negativo = 0) then
							ciclo_ativo_controlado_negativo_aux <= seno_onda(posicao_no_vetor_seno);
						else
							ciclo_ativo_controlado_positivo_aux <= seno_onda(posicao_no_vetor_seno);
						end if;
						
				end case;
				
			end if;
			
		end process;
		
		ciclo_ativo_senoide_positiva <= ciclo_ativo_controlado_positivo_aux;
		ciclo_ativo_senoide_negativa <= ciclo_ativo_controlado_negativo_aux;
		
	end architecture;