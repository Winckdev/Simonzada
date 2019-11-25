library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity div_freq is
port ( 
reset: in std_logic;
clock: in std_logic;
C05Hz, C1Hz, C2Hz, C3Hz: out std_logic
);
end div_freq;

architecture topo_beh of div_freq is
	signal contador: std_logic_vector(27 downto 0);
	signal contador05: std_logic_vector(27 downto 0);
	signal contador2: std_logic_vector(27 downto 0);
	signal contador3: std_logic_vector(27 downto 0);
	
-- registra valor da contagem
Begin
	P1: process(clock, reset, contador)
		begin
			if reset= '1' then
					contador <= x"0000000";
			elsif clock'event and clock= '1' then
					contador <= contador + 1;
				if contador = x"2FAF07F" then
					contador <= x"0000000";
						C1Hz <= '1';
			else
						C1Hz <= '0';
			end if;
				end if;
	end process;
	
	P2: process(clock, reset, contador)
		begin
			if reset= '1' then
					contador05 <= x"0000000";
			elsif clock'event and clock= '1' then
					contador05 <= contador05 + 1;
				if contador = x"17d783f" then
					contador05 <= x"0000000";
						C05Hz <= '1';
			else
						C05Hz <= '0';
			end if;
				end if;
	end process;
	
	P3: process(clock, reset, contador)
		begin
			if reset= '1' then
					contador2 <= x"0000000";
			elsif clock'event and clock= '1' then
					contador2 <= contador2 + 1;
				if contador = x"5f5e0ff" then
					contador2 <= x"0000000";
						C2Hz <= '1';
			else
						C2Hz <= '0';
			end if;
				end if;
	end process;
	
	P4: process(clock, reset, contador)
		begin
			if reset= '1' then
					contador3 <= x"0000000";
			elsif clock'event and clock= '1' then
					contador3 <= contador3 + 1;
				if contador = x"8f0d17f" then
					contador3 <= x"0000000";
						C3Hz <= '1';
			else
						C3Hz <= '0';
			end if;
				end if;
	end process;
end topo_beh;