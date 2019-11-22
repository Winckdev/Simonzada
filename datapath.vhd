library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity datapath is
port(botao: in std_logic_vector(3 downto 0); -- Botao
	RST1,RST2,EN1,EN2,EN3,EN4,SELETOR: in std_logic; -- Entradas vindas do controle
	switch: in std_logic_vector(9 downto 2); -- SW
	luz96: out std_logic_vector (9 downto 6); -- LEDR96
	luz30: out std_logic_vector (3 downto 0); -- LEDR30
	display5, display4, display3, display2, display1, display0: out std_logic_vector(6 downto 0); -- Display
	fim_fpga, fim_user, fim_time, vitoria, partida: out std_logic; -- Saidas que vao para o controle
	CLK: std_logic -- CLOCK
	);

end datapath;

architecture datapath1 of datapath is
signal OUT_FPGA, OUT_USER: std_logic_vector (63 downto 0);
signal SW: std_logic_vector (9 downto 2);
signal SETUP, POINTS: std_logic_vector (7 downto 0);
signal L, F, U, P, S, g, E, A, r, t, MUX210O, MUX211O, MUX212O, MUX213O, MUX214O, MUX215O, MUX216O, MUX217O, MUX218O, MUX219O, DECOD0, DECOD1, DECOD2, DECOD3, DECOD4: std_logic_vector (6 downto 0);
signal ROUND, SEQFPGA, SEQUSER, SEQ0O, SEQ1O, SEQ2O, SEQ3O, SEQ_FPGA, TIEMPO: std_logic_vector(3 downto 0);
signal KEY0, KEY1, KEY2, KEY3, BTN0, BTN1, BTN2, BTN3, NBTN0, NBTN1, NBTN2, NBTN3, COUNTERTIME_IN, CLOCK_50, CLOCK05HZ, CLOCK1HZ, CLOCK2HZ, CLOCK3HZ, CLOCKHZ, R1, R2, E1, E2, E3, E4, SEL, END_FPGA, END_USER, END_TIME, WIN, MATCH, COMPOUT: std_logic;

component mux21 is

port (F1,F2: in std_logic_vector (6 downto 0);
sel: in std_logic;
F: out std_logic_vector(6 downto 0)
);

end component;


component decod7seg is

port (G: in std_logic_vector(5 downto 2);
X: out std_logic_vector(6 downto 0)
);

end component;

component div_freq is

port ( 
reset: in std_logic;
clock: in std_logic;
C05Hz, C1Hz, C2Hz, C3Hz: out std_logic
);

end component;

component mux41 is

port (F1,F2,F3,F4: in std_logic;
sel: in std_logic_vector(1 downto 0);
F: out std_logic
);

end component;

component mux41vetor is

port (F1,F2,F3,F4: in std_logic_vector(3 downto 0);
sel: in std_logic_vector(1 downto 0);
F: out std_logic_vector(3 downto 0)
);

end component;

component Regis8 is

port (
CLK, RST: in std_logic;
EN: in std_logic;
D: in std_logic_vector(7 downto 0);
Q: out std_logic_vector(7 downto 0)
);

end component;

component Regis64 is

port (
CLK, RST: in std_logic;
EN: in std_logic;
D: in std_logic_vector(63 downto 0);
Q: out std_logic_vector(63 downto 0)
);

end component;

component ButtonSync0 is

port
(
KEY0, KEY1, KEY2, KEY3, CLK: in std_logic;
BTN0, BTN1, BTN2, BTN3: out std_logic
);

end component;

component contador is

port (
m: in std_logic_vector(3 downto 0);
clock, Tw, Tc: in std_logic;
r: out std_logic_vector(3 downto 0);
Tm: out std_logic
);

end component;

component SEQ0 is

PORT(
address: IN std_logic_vector(3 DOWNTO 0);
output: OUT std_logic_vector(3 DOWNTO 0)
);

end component;

component SEQ1 is

PORT(
	address: IN std_logic_vector(3 DOWNTO 0);
	output: OUT std_logic_vector(3 DOWNTO 0)
);

end component;

component SEQ2 is

PORT(
	address: IN std_logic_vector(3 DOWNTO 0);
	output: OUT std_logic_vector(3 DOWNTO 0)
);

end component;

component SEQ3	is

PORT(
	address: IN std_logic_vector(3 DOWNTO 0);
	output: OUT std_logic_vector(3 DOWNTO 0)
);

end component;

component logico0 is

port(	SETUP76: in  std_logic_vector(1 downto 0);
		ROUNDS: in std_logic_vector(3 downto 0);
		SETUP54: in std_logic_vector(1 downto 0);
		POINTS: out std_logic_vector(7 downto 0)
);

end component;

component comparador0 is
port(	OUT_FPGA, OUT_User: in std_logic_vector(63 downto 0);
		COMP_end: out std_logic
	);
end component;

begin


	MUX210: mux21 port map (F, U, WIN, MUX210O);
	MUX211: mux21 port map (P, S, WIN, MUX211O);
	MUX212: mux21 port map (g, E, WIN, MUX212O);
	MUX213: mux21 port map (A, r, WIN, MUX213O);
	MUX214: mux21 port map (L, MUX210O, SEL, MUX214O);
	MUX215: mux21 port map (DECOD0, MUX211O, SEL, MUX215O);
	MUX216: mux21 port map (t, MUX212O, SEL, MUX216O);
	MUX217: mux21 port map (DECOD1, MUX213O, SEL, MUX217O);
	MUX218: mux21 port map (r, DECOD2, SEL, MUX218O);
	MUX219: mux21 port map (DECOD3, DECOD4, SEL, MUX219O);
	MUX410: mux41 port map (CLOCK05HZ, CLOCK1HZ, CLOCK2HZ, CLOCK3HZ, SETUP(7 downto 6), CLOCKHZ);
	MUX411: mux41vetor port map (SEQ0O, SEQ1O, SEQ2O, SEQ3O, SETUP(5 downto 4), SEQ_FPGA);
	DECODIFICADOR0: decod7seg port map (("00" & SETUP(7 downto 6)), DECOD0);
	DECODIFICADOR1: decod7seg port map (TIEMPO, DECOD1);
	DECODIFICADOR2: decod7seg port map (POINTS (7 downto 4), DECOD2);
	DECODIFICADOR3: decod7seg port map (ROUND, DECOD3);
	DECODIFICADOR4: decod7seg port map (POINTS (3 downto 0), DECOD4);
	buttonsync: ButtonSync0 port map (KEY0, KEY1, KEY2, KEY3,CLOCK_50, BTN0, BTN1, BTN2, BTN3);
	REG_FPGA: Regis64 port map (CLOCKHZ, R2, E3, (SEQ_FPGA & OUT_FPGA(63 downto 4)), OUT_FPGA);
	REG_User: Regis64 port map (CLOCK_50, R2, ((NBTN0 OR NBTN1 OR NBTN2 OR NBTN3) AND E2), (NBTN3 & NBTN2 & NBTN1 & NBTN0 & OUT_USER(63 downto 4)), OUT_USER);
	REG_setup: Regis8 port map (CLOCK_50, R1, E1, SW( 9 downto 2), SETUP);
	DIVFREQ0: div_freq port map (R1, CLOCK_50, CLOCK05HZ, CLOCK1HZ, CLOCK2HZ, CLOCK3HZ);
	COUNTER_ROUND: contador port map (SETUP (3 downto 0), CLOCK_50, E4, R1, ROUND, WIN);
	COUNTER_TIME: contador port map ("1010", CLOCK1HZ, E2, R2, TIEMPO, END_TIME);
	COUNTER_FPGA: contador port map (ROUND, CLOCKHZ, E3, R2, SEQFPGA, END_FPGA);
	COUNTER_USER: contador port map (ROUND, CLOCK_50, E2 AND (NBTN0 OR NBTN1 OR NBTN2 OR NBTN3), R2, SEQUSER, END_USER);
	SEQUENCIA0: SEQ0 port map (SEQFPGA, SEQ0O);
	SEQUENCIA1:	SEQ1 port map (SEQFPGA, SEQ1O);
	SEQUENCIA2: SEQ2 port map (SEQFPGA, SEQ2O);
	SEQUENCIA3: SEQ3 port map (SEQFPGA, SEQ3O);
	LOGICA: logico0 port map (SETUP (7 downto 6), ROUND, SETUP(5 downto 4), POINTS);
	COMP: comparador0 port map (OUT_FPGA, OUT_USER, COMPOUT);

	NBTN0 <= not BTN0;
	NBTN1 <= not BTN1;
	NBTN2 <= not BTN2;
	NBTN3 <= not BTN3;

	MATCH <= (END_USER AND COMPOUT);
	luz30 (3 downto 0) <= OUT_FPGA (63 downto 60);
	luz96 (9 downto 6) <= not botao (3 downto 0);

	display5 <= mux214O;
	display4 <= mux215O;
	display3 <= mux216O;
	display2 <= mux217O;
	display1 <= mux218O;
	display0 <= mux219O;
	 
	 
	
	fim_fpga <= END_FPGA;
	fim_user <= END_USER;
	fim_time <= END_TIME;
	
	vitoria <= WIN;
	
	partida <= MATCH;
	
	KEY0 <= botao(0);
	KEY1 <= botao(1);
	KEY2 <= botao(2);
	KEY3 <= botao(3);
	
	R1 <= RST1;
	R2 <= RST2;
	
	E1 <= EN1;
	E2 <= EN2;
	E3 <= EN3;
	E4 <= EN4;
	
	SEL <= SELETOR;
	
	t <= "0000111";
	L <= "1000111";
	F <= "0001110";
	U <= "1000001";
	P <= "0001100";
	S <= "0010010";
	g <= "0010000";
	E <= "0000110";
	A <= "0001000";
	r <= "0101111";
	
	
	SW(9 downto 2) <= switch(9 downto 2);

	CLOCK_50 <= CLK;
	
end datapath1;