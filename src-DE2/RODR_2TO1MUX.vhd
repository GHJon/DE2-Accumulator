library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------

entity RODR_2TO1MUX is

	generic(nbits: natural := 8);
port(	RODR_A:	in std_logic_vector(nbits-1 downto 0);
		RODR_B:	in std_logic_vector(nbits-1 downto 0);
		RODR_SEL : in std_logic;
		RODR_OUT : Out std_logic_vector(nbits-1 downto 0));

end RODR_2TO1MUX;

--------------------------------------------------------

architecture LogicFunction of RODR_2TO1MUX is
begin
	process(RODR_SEL)
	begin 
	
		case RODR_SEL is
	
		when '0' =>
			RODR_OUT <= RODR_A;
		when '1' =>
			RODR_OUT <= RODR_B;
		when others =>
			RODR_OUT <= (others => '1');
		end case;
	end process;

end LogicFunction;