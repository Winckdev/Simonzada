library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity topo is
port(KEY: in std_logic_vector(3 downto 0);
	SW: in std_logic_vector(9 downto 0);
	LEDR: out std_logic_vector (9 downto 0);
	HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
	CLOCK_50:in std_logic
);

end topo;

architecture topinho of topo is
 
signal R1, R2, E1, E2, E3, E4, SEL, END_FPGA, END_USER, END_TIME, WIN, MATCH, CLK50: std_logic;
signal BTN: std_logic_vector (3 downto 0);
signal HEXA0, HEXA1, HEXA2, HEXA3, HEXA4, HEXA5: std_logic_vector(6 downto 0);
signal SWITCH, LEDRED: std_logic_vector(9 downto 0);

component datapath is

port(
	botao: in std_logic_vector(3 downto 0); -- Botao
	RST1,RST2,EN1,EN2,EN3,EN4,SELETOR: in std_logic; -- Entradas vindas do controle
	switch: in std_logic_vector(9 downto 2); -- SW
	luz: out std_logic_vector (9 downto 0); -- LEDR
	display5, display4, display3, display2, display1, display0: out std_logic_vector(6 downto 0); -- Display
	fim_fpga, fim_user, fim_time, vitoria, partida: out std_logic; -- Saidas que vao para o controle
	CLK: std_logic -- CLOCK
	);

end component;

component Controle is

port(
	enter,reset,clock: in std_logic;
	end_FPGA,end_User,end_time,win,match: in std_logic;
	R1,R2,E1,E2,E3,E4,SEL: out std_logic
	);
	
end component;

begin

Datap: datapath port map (BTN, R1, R2, E1, E2, E3, E4, SEL, SWITCH (9 downto 2), LEDRED, HEXA5, HEXA4, HEXA3, HEXA2, HEXA1, HEXA0, END_FPGA, END_USER, END_TIME, WIN, MATCH, CLK50);
Control: Controle port map (SWITCH(0), SWITCH(1), CLK50, END_FPGA, END_USER, END_TIME, WIN, MATCH, R1, R2, E1, E2, E3, E4, SEL);

HEX5 <= HEXA5;
HEX4 <= HEXA4;
HEX3 <= HEXA3;
HEX2 <= HEXA2;
HEX1 <= HEXA1;
HEX0 <= HEXA0;

LEDR <= LEDRED;

SWITCH (9 downto 2) <= SW (9 downto 2);
SWITCH(1) <= SW(1);
SWITCH(0) <= SW(0);

CLK50 <= CLOCK_50;

BTN <= KEY;


end topinho;