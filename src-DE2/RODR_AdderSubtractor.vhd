library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------

entity RODR_AdderSubtractor is

	generic(nbits: natural := 16);
port(	RODR_A:	in std_logic_vector(nbits-1 downto 0);
		RODR_B:	in std_logic_vector(nbits-1 downto 0);
		RODR_overflow:	out std_logic;
		RODR_CIN : in std_logic := '0';
		RODR_sum:	out std_logic_vector(nbits-1 downto 0);
		RODR_ACCUM : in std_logic;
		RODR_Clock : in std_logic;
		RODR_CLR: in std_logic);

end RODR_AdderSubtractor;

--------------------------------------------------------

architecture LogicFunction of RODR_AdderSubtractor is
-- define a temparary signal to store the result

signal result: std_logic_vector(nbits downto 0);		-- Extra bit to accomodate for overflow
signal addsubflag : std_logic_vector (nbits-1 downto 0);
signal temp : std_logic_vector(nbits downto 0);

signal tempA: std_logic_vector(nbits-1 downto 0);
signal tempB: std_logic_vector(nbits-1 downto 0);
begin
	addsubflag <= (Others => RODR_CIN);
	tempA <= RODR_A;
	tempB <= RODR_B;
	
	process(RODR_Clock, RODR_CLR, temp, tempA, tempB, addsubflag, RODR_CIN, RODR_ACCUM)
	begin 
		if(RODR_CLR = '1') then
			temp <= (Others => '0');
			result <= (Others => '0');
		elsif(rising_edge(RODR_Clock)) then
			case RODR_ACCUM is
				when '0' => 
					temp(nbits-1 downto 0) <= tempA;
				when '1' =>
					temp <= result;
			end case;
			result <= ('0' & temp(nbits-1 downto 0)) + ('0' & ((tempB XOR addsubflag) + RODR_CIN));
		end if;
		
			RODR_sum <= result(nbits-1 downto 0);
			RODR_overflow <= result(nbits);
	end process;
end LogicFunction;