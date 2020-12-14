

	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	
	entity set_freq is
	port(
			signal clk_50_MHz       : in std_logic;
			signal increment        : in std_logic;
			signal decrement        : in std_logic;
			signal freq_setada      : out std_logic_vector(3 downto 0);
			signal clk_button_aux   : in std_logic
		);
	end set_freq;
	
	architecture logica of set_freq is
		signal inc_button_ans  : std_logic;
		signal dec_button_ans  : std_logic;
		signal barramento : std_logic_vector(15 downto 0) := "0000000000000000";
			
		component button
		port(
			signal in_button      : in std_logic;
			signal clk_button     : in std_logic;
			signal out_pin_button : out std_logic
		);
		end component;
	
	begin
		inc_button : button port map( clk_button => clk_button_aux, in_button => increment, out_pin_button => inc_button_ans );
		dec_button : button port map( clk_button => clk_button_aux, in_button => decrement, out_pin_button => dec_button_ans );
	
		process(clk_50_MHz)
			variable contador_base 		: integer := 0;
			variable contador_1us  		: integer := 0;
			variable freq_count_aux 	: std_logic_vector(15 downto 0) := "0000000000000000";
			variable delay 				: integer := 0;
			variable inicializacao		: integer := 0;
		begin
		
			if (rising_edge(clk_50_MHz)) then
			
				contador_base := contador_base + 1;
				if(contador_base = 50) then
					contador_1us := contador_1us + 1;
					contador_base := 0;
				end if;
				
				if (inicializacao = 0) then
					
					case freq_count_aux is
						
						when "0000000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "0001000000000000";
								contador_1us := 0;
							end if;
							
						when "0001000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "0010000000000000";
								contador_1us := 0;
							end if;
							
						when "0010000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "0011000000000000";
								contador_1us := 0;
							end if;
							
						when "0011000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "0100000000000000";
								contador_1us := 0;
							end if;
							
						when "0100000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "0101000000000000";
								contador_1us := 0;
							end if;
							
						when "0101000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "0110000000000000";
								contador_1us := 0;
							end if;
							
						when "0110000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "0111000000000000";
								contador_1us := 0;
							end if;
							
						when "0111000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "1000000000000000";
								contador_1us := 0;
							end if;
							
						when "1000000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "1001000000000000";
								contador_1us := 0;
							end if;
							
						when "1001000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "1010000000000000";
								contador_1us := 0;
							end if;
							
						when "1010000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "1011000000000000";
								contador_1us := 0;
							end if;
							
						when "1011000000000000" =>
							if(contador_1us = 417000) then
								freq_count_aux <= "1100000000000000";
								contador_1us := 0;
							end if;
							
						when "1100000000000000" =>
							if(contador_1us = 417000) then
								inicializacao := 1;
								contador_1us := 0;
							end if;
						
						when others =>
							inicializacao := 1;
							contador_1us := 0;
							
					end case;
					
				else
				
					if(contador_1us = 100) then
				
						if (inc_button_ans = '0') then
							if(freq_count_aux < "1100000000000000") then
								freq_count_aux := freq_count_aux + '1';
							end if;
						end if;
				
						if (dec_button_ans = '0') then
							if(freq_count_aux > "0000000000000000") then
								freq_count_aux := freq_count_aux - '1';
							end if;
						end if;
					
						contador_1us := 0;
						
					end if;
					
				end if;
				
			end if;
			
			barramento <= freq_count_aux;
			
		end process;
		
		freq_setada(3) <= barramento(15);
		freq_setada(2) <= barramento(14);
		freq_setada(1) <= barramento(13);
		freq_setada(0) <= barramento(12);
		
	end logica;