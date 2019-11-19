library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity comparador0 is
	port(	OUT_FPGA, OUT_User: in std_logic_vector(63 downto 0);
			COMP_end: out std_logic
	);
end comparador0;

architecture comp of comparador0 is
begin
	COMP_end <= '1' when OUT_FPGA = OUT_user else '0';
end comp;