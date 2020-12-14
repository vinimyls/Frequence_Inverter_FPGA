	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	
	entity controladora is
		port(
			signal clk_50MHz_top    			: in std_logic;
			signal pwm_saida_positivo_top    : out std_logic;
			signal pwm_saida_negativo_top    : out std_logic;
			signal increment_top 				: in std_logic;
			signal decrement_top 				: in std_logic;
			signal RS_top	   				   : out std_logic;
			signal RW_top    						: out std_logic;
			signal E_top       					: buffer bit;  
			signal DB_top       					: out std_logic_vector(7 downto 0);
			signal lcd_on_top   					: out std_logic;
			signal lcd_blon_top 					: out std_logic 
		);
	end entity;
	
	architecture logica of controladora is
	
	signal freq_setada_top  		  : std_logic_vector(3 downto 0);
	signal ciclo_ativo_positivo_aux : std_logic_vector(7 downto 0);
	signal ciclo_ativo_negativo_aux : std_logic_vector(7 downto 0);
	signal estado_pwm_top   		  : std_logic_vector(3 downto 0);
	
	component pwm
		port(
			signal clk_50MHz          : in std_logic;
			signal pwm_ciclo_ativo_us : in std_logic_vector(7 downto 0);
			signal pwm_saida          : out std_logic
		);
	end component;
	
	component controlePwm
		port(
			signal estado_pwm             		: in std_logic_vector(3 downto 0);
			signal clk_50Mhz              		: in std_logic;
			signal ciclo_ativo_senoide_positiva : out std_logic_vector(7 downto 0);
			signal ciclo_ativo_senoide_negativa : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component set_freq
		port(
			signal clk_50_MHz       : in std_logic;
			signal increment        : in std_logic;
			signal decrement        : in std_logic;
			signal freq_setada      : out std_logic_vector(3 downto 0);
			signal clk_button_aux   : in std_logic
		);
	end component;
	
	component lcd
		port(
			signal clk      : in std_logic; 
			signal RS	    : out std_logic;
			signal RW       : out std_logic;
			signal E        : buffer bit;  
			signal DB       : out std_logic_vector(7 downto 0);
			signal lcd_on   : out std_logic;
			signal lcd_blon : out std_logic;
			signal freq     : in std_logic_vector(3 downto 0)
		);	
	end component;
		
	begin
				
		pwm_1         : pwm         port map(clk_50MHz => clk_50MHz_top, pwm_ciclo_ativo_us => ciclo_ativo_positivo_aux, pwm_saida => pwm_saida_positivo_top);
		pwm_2         : pwm         port map(clk_50MHz => clk_50MHz_top, pwm_ciclo_ativo_us => ciclo_ativo_negativo_aux, pwm_saida => pwm_saida_negativo_top);
		controlePwm_1 : controlePwm port map(estado_pwm => freq_setada_top, clk_50MHz => clk_50MHz_top, ciclo_ativo_senoide_positiva => ciclo_ativo_positivo_aux, ciclo_ativo_senoide_negativa => ciclo_ativo_negativo_aux);
		set_freq_1    : set_freq    port map(clk_50_MHz => clk_50MHz_top, increment => increment_top, decrement => decrement_top, freq_setada => freq_setada_top, clk_button_aux => clk_50MHz_top);
		lcd_1         : lcd         port map(clk => clk_50MHz_top, RS => RS_top, RW => RW_top, E => E_top, DB => DB_top, lcd_on => lcd_on_top, lcd_blon => lcd_blon_top, freq => freq_setada_top);
	
	end architecture;