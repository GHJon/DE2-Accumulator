LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_PlusMinus IS
	PORT(RODR_SIGBIT : IN STD_LOGIC;
		  RODR_IN: IN STD_LOGIC;
	     RODR_OUT : OUT STD_LOGIC_VECTOR (6 downto 0));
END RODR_PlusMinus ;

ARCHITECTURE LogicFunction OF RODR_PlusMinus IS
BEGIN
	plus_or_minus : process(RODR_SIGBIT, RODR_IN)
	BEGIN
	
		if((RODR_SIGBIT = '0') AND (RODR_IN = '0')) then 
			RODR_OUT <= "1111111";
		elsif((RODR_SIGBIT = '0') AND (RODR_IN = '1')) then
			RODR_OUT <= "1111111";
		elsif((RODR_SIGBIT = '1') AND (RODR_IN = '1')) then
			RODR_OUT <= "1111110";
		elsif((RODR_SIGBIT = '1') AND (RODR_IN = '0')) then
			RODR_OUT <= "1001110";
		end if;
	end process plus_or_minus;

END LogicFunction ;