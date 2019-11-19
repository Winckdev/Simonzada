library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--SW(9,8) = Selecionar velocidade
--SW(7,6) = selecionar frequencia
--SW(5,2) = Selecionar quantas iteracoes

entity logico0 is
port(	SETUP76: in  std_logic_vector(1 downto 0);
		ROUNDS: in std_logic_vector(3 downto 0);
		SETUP54: in std_logic_vector(1 downto 0);
		POINTS: out std_logic_vector(7 downto 0)
);
end logico0;

architecture logica of logico0 is
begin
	POINTS <= (SETUP76 & "00000") + ("00" & ROUNDS & "00") + ("000000" & SETUP54);
end logica;