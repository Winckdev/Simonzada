library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Controle is

port(	c, Tm, clock, reset: in std_logic;
			Tc, Tw: out std_logic
);
end Controle;

architecture ocontrole of Controle is
	type STATES is (C0,C1,C2);
	signal EA, PE: STATES;
begin
	P1: process(clock, reset)
	begin
		if reset= '0' then
						EA <= C0;
			elsif clock'event and clock= '1' then
			
					EA <= PE;
		end if;
	end process;
	P2: process(EA)
	begin
		case EA is
			when C0 =>						
						Tc<='1';	
						Tw<='0';
						PE <= C1;
			when C1 =>
						Tc<='0';
						Tw<='0';
						if (c = '1' and Tm = '1') then
							PE <= C1;
						end if;
						if (c = '0' and Tm = '1') then
							PE <= C2;
						end if;
						if (Tm = '0') then
							PE <= C2;
						end if;
						
			when C2 =>
						Tc<='0';
						Tw<='1';
						PE <= C1;
		end case;
	end process;
end ocontrole;
