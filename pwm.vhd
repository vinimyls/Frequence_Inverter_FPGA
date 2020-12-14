	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	
	entity pwm is
		port(
			signal clk_50MHz          : in std_logic;
			signal pwm_ciclo_ativo_us : in std_logic_vector(7 downto 0);
			signal pwm_saida          : out std_logic
		);
	end entity;
	
	architecture logica of pwm is
		signal pwm_sinal_interno : std_logic := '0';
		signal pwm_periodo_us    : std_logic_vector(7 downto 0) := "11001000";
	begin
		
		process(clk_50MHz)
			variable contador_base : integer := 0;
			variable contador_1us  : integer := 0;
		begin
			
			if(rising_edge(clk_50MHz)) then
				contador_base := contador_base + 1;
				if(contador_base = 50) then
				
					contador_1us := contador_1us + 1;
					
					if(contador_1us = pwm_periodo_us) then
						contador_1us := 0;
					end if;
					
					if(contador_1us < pwm_ciclo_ativo_us) then
						pwm_sinal_interno <= '1';
					else
						pwm_sinal_interno <= '0';
					end if;
					
					contador_base := 0;
					
				end if;
			end if;
		end process;
		
		pwm_saida <= pwm_sinal_interno;
		
	end architecture;