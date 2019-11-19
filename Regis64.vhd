library ieee;
use ieee.std_logic_1164.all;
entity Regis64 is port (
CLK, RST: in std_logic;
EN: in std_logic;
D: in std_logic_vector(63 downto 0);
Q: out std_logic_vector(63 downto 0)
);
end Regis64;


architecture behv64 of Regis64 is
begin
	process(CLK, D, RST)
	begin
		if RST = '0' then
			Q <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			if EN = '0' then
					Q <= D;
			end if;
		end if;
	end process;
end behv64;