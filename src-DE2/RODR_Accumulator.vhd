LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_RegisterArray IS
	PORT(RODR_IN   : IN STD_LOGIC_VECTOR (nbits-1 downto 0) ;
	     RODR_OUT  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0));
END RODR_RegisterArray ;

ARCHITECTURE LogicFunction OF RODR_RegisterArray IS
BEGIN
	

END LogicFunction ;