library IEEE;
use IEEE.Std_Logic_1164.all;

entity decod7seg is
port (G: in std_logic_vector(5 downto 2);
X: out std_logic_vector(6 downto 0)
);

end decod7seg;

architecture decod of decod7seg is
begin
X <=  "1000000" when G = "0000" else
		"1111001" when G = "0001" else
		"0100100" when G = "0010" else
		"0110000" when G = "0011" else
		"0011001" when G = "0100" else
		"0010010" when G = "0101" else
		"0000010" when G = "0110" else
		"1111000" when G = "0111" else
		"0000000" when G = "1000" else
		"0010000" when G = "1001" else
		"0001000" when G = "1010" else
		"0000011" when G = "1011" else
		"0000110" when G = "1100" else
		"0100001" when G = "1101" else
		"0000110" when G = "1110" else
		"0001110" when G = "1111";

end decod;