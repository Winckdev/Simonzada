library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity contador is port (
m: in std_logic_vector(3 downto 0);
clock, Tw, Tc: in std_logic;
r: out std_logic_vector(3 downto 0);
Tm: out std_logic);
end contador;
architecture arqdtp of contador is
	signal tot: std_logic_vector(3 downto 0);
begin
-- Registrador e Somador:
	process(clock,Tc,Tw)
	begin
		if (Tc = '1') then
				tot <= "0000";
		elsif (clock'event AND clock = '1') then
				if (Tw = '1') then
					tot <= tot + 1;
				end if;
			end if;
		end process; 
r <= tot;
-- Comparador:
Tm <= '0' when (tot <= m) else
'1';
end arqdtp;