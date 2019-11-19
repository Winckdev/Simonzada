library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux21 is

port (F1,F2: in std_logic_vector (6 downto 0);
sel: in std_logic;
F: out std_logic_vector(6 downto 0)
);

end mux21;

architecture mux21arc of mux21 is
begin

F <= 	F1 when sel = '0' else
		F2;

end mux21arc;