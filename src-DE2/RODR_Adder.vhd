library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------

entity RODR_Adder is

	generic(nbits: natural := 8);
port(	RODR_A:	in std_logic_vector(nbits-1 downto 0);
		RODR_B:	in std_logic_vector(nbits-1 downto 0);
		RODR_overflow:	out std_logic;
		RODR_CIN : in std_logic;
		RODR_sum:	out std_logic_vector(nbits-1 downto 0)); 

end RODR_Adder;

--------------------------------------------------------

architecture LogicFunction of RODR_Adder is

-- define a temparary signal to store the result

signal result: std_logic_vector(nbits downto 0);		-- Extra bit to accomodate for overflow

begin
	process(RODR_CIN, result, RODR_A, RODR_B)
	begin
		result <= ('0' & RODR_A)+('0' & RODR_B) + RODR_CIN;
		RODR_sum <= result(nbits-1 downto 0);
		RODR_overflow <= result(nbits);
	end process;
			
end LogicFunction;