library IEEE;
use IEEE.Std_logic_1164.all;

--Falta: Fazer a lógica dos reset's, Revisar, fazer lógica do SEL

entity Controle is
port(
	enter,reset,clock: in std_logic;
	end_FPGA,end_User,end_time,win,match: in std_logic;
	R1,R2,E1,E2,E3,E4,SEL: out std_logic
	);
end;

architecture controle of Controle is
	type STATES is (START,SETUP,PLAY_FPGA,PLAY_USER,CHECK,RESULT,NEXT_ROUND);
	signal EA,PE: STATES;
begin
	process(enter,reset,EA,PE)
	begin
		if reset = '1' then
			EA <= START;
		elsif clock'event and clock='1' then
			EA <= PE;
		end if;
		
	end process;
	
	process(EA,end_FPGA,end_User,end_time,win,match)
	begin
	
		case EA is
			
			-- E1 Enable REG_setup --> Setar o jogo
	
			-- E2 Enable REG_user/Counter_time --> Habilitar a entrada / Contador da jogada
	
			-- E3 Enable REG_FPGA/Counter_FPGA --> Mostrar a sequência / Contador da sequência
	
			-- E4 Enable Counter_round --> Definir a condição de vitória / Contador de round
			
			
			when START => 		PE <= SETUP; 
									R1 <= '1';
									R2 <= '1';
									E1 <= '0';
									E2 <= '0';
									E3 <= '0';
									E4 <= '0';
									SEL <= '0';
			
			
			when SETUP =>			E1 <= '1';

									R1 <= '0';
									R2 <= '0';
									E2 <= '0';
									E3 <= '0';
									E4 <= '0';
									SEL <= '0';
									if enter = '1' then PE <= PLAY_FPGA; else PE <= SETUP; end if;
			
			
			when PLAY_FPGA =>		E3 <= '1';
			
									R1 <= '0';
									R2 <= '0';
									E1 <= '0';
									E2 <= '0';
									E4 <= '0';
									SEL <= '0';
									if end_FPGA = '1' then PE <= PLAY_USER; else PE <= PLAY_FPGA; end if;
			
			
			when PLAY_USER => 		E2 <= '1';
									E4 <= '0';
									
									R1 <= '0';
									R2 <= '0';
									E1 <= '0';
									E3 <= '0';
									SEL <= '0';
									if end_time = '1' then PE <= RESULT;
									
									elsif end_time = '0' then
										if end_user = '1' then
											PE <= CHECK;
										else 
											PE <= PLAY_USER;
										end if;
									end if;
	
			
			when CHECK =>			R1 <= '0';
									R2 <= '0';
									E1 <= '0';
									E2 <= '0';
									E3 <= '0';
									E4 <= '1';
									SEL <= '0';
									if match = '1' then PE <= NEXT_ROUND; else PE <= RESULT; end if;
							
							
			when RESULT =>			PE <= RESULT;
									SEL <= '1';
			
									R1 <= '0';
									R2 <= '0';
									E1 <= '0';
									E2 <= '0';
									E3 <= '0';
									E4 <= '0';
									
								
								
			when NEXT_ROUND =>		if win = '1' then PE <= RESULT; else PE <= PLAY_FPGA; end if;
									R1 <= '0';
									R2 <= '1';
									E1 <= '0';
									E2 <= '0';
									E3 <= '0';
									E4 <= '0';
									SEL <= '0';
									
		end case;
	end process;	
end controle;	
									
									