

	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	
	entity button is
	port(
		 signal in_button       : in  std_logic;
		 signal clk_button      : in  std_logic;
		 signal out_pin_button  : out std_logic
	);
	end button;
	
	architecture logica of button is
	signal out_button : std_logic := '1';
	begin
	
		process(clk_button)
		begin
		
			if(rising_edge(clk_button)) then
				if(in_button = '0') then
					out_button <= '0';
				else
					out_button <= '1';
				end if;
			end if;
			
		end process;
		
		out_pin_button <= out_button;
		
	end logica;