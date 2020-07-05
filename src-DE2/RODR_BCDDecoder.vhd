LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_BCDDecoder IS
	PORT(RODR_IN   : IN STD_LOGIC_VECTOR (3 downto 0) ;
	     RODR_OUT  : OUT STD_LOGIC_VECTOR (6 downto 0));
END RODR_BCDDecoder ;

ARCHITECTURE LogicFunction OF RODR_BCDDecoder IS
BEGIN
	
	Logic0_To_9: process(RODR_IN)		-- Create a process for sequential logic reading, not concurrent
	BEGIN
		case RODR_IN is
		
		when "0000" => 					-- Number 0
			RODR_OUT <= "0000001";
		when "0001" => 					-- Number 1
			RODR_OUT <= "1001111";
		when "0010" => 					-- Number 2
			RODR_OUT <= "0010010";
		when "0011" => 					-- Number 3
			RODR_OUT <= "0000110";
		when "0100" => 					-- Number 4
			RODR_OUT <= "1001100";
		when "0101" => 					-- Number 5
			RODR_OUT <= "0100100";
		when "0110" => 					-- Number 6
			RODR_OUT <= "1100000";
		when "0111" => 					-- Number 7
			RODR_OUT <= "0001111";
		when "1000" => 					-- Number 8
			RODR_OUT <= "0000000";
		when "1001" => 					-- Number 9
			RODR_OUT <= "0001100";
		
		when others =>
			RODR_OUT <= "1111111";		-- Segment Display is off
			
		END case;
		
	END process LOGIC0_TO_9 ;

END LogicFunction ;