
	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;

	entity lcd is
		generic (fclk: natural := 50_000_000); -- 50MHz , cristal do kit EE03
		port(
				signal clk : in std_logic; 
				signal RS	 : out std_logic;
				signal RW  : out std_logic;
				signal E   : buffer bit;  
				signal DB  : out std_logic_vector(7 downto 0);
				signal lcd_on : out std_logic;
				signal lcd_blon : out std_logic;
				signal freq : in std_logic_vector(3 downto 0)
				
		); 
	end lcd;

	architecture hardware of lcd is
		type state is (FunctionSetl, FunctionSet2, FunctionSet3,
							FunctionSet4,FunctionSet5,FunctionSet6,FunctionSet7,FunctionSet8,FunctionSet9,FunctionSet10,FunctionSet11,FunctionSet12,
							FunctionSet13,FunctionSet14,FunctionSet15,FunctionSet16,FunctionSet17,FunctionSet18,FunctionSet19,ClearDisplay, DisplayControl, EntryMode, 
							WriteDatal, WriteData2, WriteData3, WriteData4, WriteData5,WriteData6,WriteData7,WriteData8,WriteData9,WriteData10,WriteData11,
							WriteData12,WriteData13,WriteData14,WriteData15,WriteData16,WriteData17,WriteData18,WriteData19,SetAddress,SetAddress1, ReturnHome);
		signal pr_state, nx_state: state; 
	begin
	
		lcd_on <= '1';
		lcd_blon <='1';
	
		---—Clock generator (E->500Hz) :---------
			process (clk)
			variable count: natural range 0 to fclk/1000; 
			begin
				if (clk' event and clk = '1') then 
					count := count + 1;
					if (count=fclk/1000) then 
					 E <= not E; 
					 count := 0; 
					end if; 
				end if; 
			end process;
	
		-----Lower section of FSM:---------------
			process (E) 
			begin
				if (E' event and E = '1') then 
					--	IF (rst= '0') THEN
					pr_state <= FunctionSetl; 
					--ELSE
					pr_state <= nx_state; 
					--END IF; 
				end if; 
			end process;
	
-----Upper section of FSX:---------------
		process (pr_state) 
		begin
		
			case freq is
			
-- ===============================================================================
				when "0000" =>
										
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData9; --'0'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData10; --'0'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
-- ===============================================================================
				when "0001" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData9; --'0'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData10; --'5'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
		
				
-- ===============================================================================	
				when "0010" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"31"; nx_state <= WriteData9; --'1'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData10; --'0'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;

-- ===============================================================================
				when "0011" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"31"; nx_state <= WriteData9; --'1'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData10; --'5'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
				
-- ===============================================================================				
				when "0100" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"32"; nx_state <= WriteData9; --'2'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData10; --'0'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
					
					
-- ===============================================================================			
				when "0101" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"32"; nx_state <= WriteData9; --'2'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData10; --'5'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
				
-- ===============================================================================
				when "0110" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"33"; nx_state <= WriteData9; --'3'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData10; --'0'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
-- ===============================================================================
				when "0111" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"33"; nx_state <= WriteData9; --'3'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData10; --'5'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
				
-- ===============================================================================
				when "1000" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"34"; nx_state <= WriteData9; --'4'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData10; --'0'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
				
-- ===============================================================================
				when "1001" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"34"; nx_state <= WriteData9; --'4'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData10; --'5'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
				
-- ===============================================================================
				when "1010" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData9; --'5'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData10; --'0'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
				
-- ===============================================================================
				when "1011" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData9; --'5'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"35"; nx_state <= WriteData10; --'5'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
					
-- ===============================================================================
				when "1100" =>
				
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"36"; nx_state <= WriteData9; --'6'
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"30"; nx_state <= WriteData10; --'0'
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
				
				
-- ===============================================================================
				when others =>
					
					case pr_state is
				
						when FunctionSetl => 
							RS<= '0'; RW<= '0'; DB<= "00111000"; nx_state <= FunctionSet2;
						
						when FunctionSet2 => 
							RS<= '0'; RW<= '0'; DB <= "00111000"; nx_state <= FunctionSet3;
						
						when FunctionSet3 => 
							RS <= '0'; RW <='0'; DB <= "00111000"; nx_state <= FunctionSet4;
					
						when FunctionSet4 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet5;
					
						when FunctionSet5 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet6;
					
						when FunctionSet6 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet7;
					
						when FunctionSet7 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet8;
					
						when FunctionSet8 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet9;
					
						when FunctionSet9 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet10;
					
						when FunctionSet10 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet11;
					
						when FunctionSet11 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet12;
					
						when FunctionSet12 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet13;
					
						when FunctionSet13 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet14;
					
						when FunctionSet14 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet15;
					
						when FunctionSet15 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet16;
						
						when FunctionSet16 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet17;
					
						when FunctionSet17 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet18;
					
						when FunctionSet18 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= FunctionSet19;
					
						when FunctionSet19 =>
							RS <= '0'; RW <= '0'; DB <= "00111000"; nx_state <= ClearDisplay ;
					
						when ClearDisplay =>
							RS <= '0'; RW <= '0'; DB <= "00000001"; nx_state <= DisplayControl;
						
						when DisplayControl =>
							RS <= '0'; RW <= '0'; DB <= "00001100"; nx_state <= EntryMode;
						
						when EntryMode =>
							RS<= '0'; RW<= '0'; DB <= "00000110"; nx_state <= WriteDatal;
					
						when WriteDatal =>
							RS <= '1'; RW <= '0'; DB <= "00100000"; nx_state <= SetAddress1; --'ESCREVE UM ESPAÇO EM BRANDO
					
						when SetAddress1 =>
							RS <= '0'; RW <= '0'; DB <= "10000010"; nx_state  <= WriteData2; --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 3
					
						when WriteData2 =>
							RS <= '1'; RW <= '0'; DB <= X"46"; nx_state <= WriteData3; --'F'
						
						when WriteData3 =>
							RS <= '1'; RW <= '0'; DB <= X"72"; nx_state <= WriteData4; --'r'
						
						when WriteData4 =>
							RS <= '1'; RW <= '0'; DB <= X"65"; nx_state <= WriteData5; --'e'
					
						when WriteData5 =>
							RS <= '1'; RW <= '0'; DB <= X"71"; nx_state <= WriteData6; --'q'
					
						when WriteData6 =>
							RS <= '1'; RW <= '0'; DB <= X"3A"; nx_state <= WriteData7; --':'
					
						when WriteData7 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData8; --' '
					
						when WriteData8 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData9; --' '
					
						when WriteData9 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData10; --' '
					
						when WriteData10 =>
							RS <= '1'; RW <= '0'; DB <= X"20"; nx_state <= WriteData11; --' '
					
						when WriteData11 =>
							RS <= '1'; RW <= '0'; DB <= X"48"; nx_state <= WriteData12; --'H'
					
						when WriteData12 =>
							RS <= '1'; RW <= '0'; DB <= X"7A"; nx_state <= ReturnHome; -- 'z' 
					
						when ReturnHome =>
							RS <= '0'; RW <= '0'; DB <= "10000000"; nx_state <= WriteDatal;
							
						when others =>
							RS <= '0'; RW <= '0';
							
					end case;
			
			end case;
			
		end process;
	
	end hardware;