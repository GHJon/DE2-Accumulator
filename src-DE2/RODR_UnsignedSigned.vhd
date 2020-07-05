LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE IEEE.numeric_std.all;

	ENTITY RODR_UnsignedSigned IS
--	generic (nbits : natural := 8);
	generic (nbits : natural);
	PORT(RODR_SIGBIT : IN STD_LOGIC;
		  RODR_IN   : IN STD_LOGIC_VECTOR (nbits-1 downto 0) ;
	     RODR_OUT  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0));		--SUM OF ADDER
END RODR_UnsignedSigned ;

ARCHITECTURE LogicFunction OF RODR_UnsignedSigned IS

	signal IN_FLIP : STD_LOGIC_VECTOR (nbits-1 downto 0);
	signal ADD_ONE : STD_LOGIC_VECTOR (nbits-1 downto 0);
	signal SIGNED_OUT : STD_LOGIC_VECTOR (nbits-1 downto 0);
	
	
	BEGIN
		process(ADD_ONE)							-- -- New process to address n bits for ADD_ONE
		BEGIN
			ADD_ONE(0) <= '1';					
			for index in 1 to nbits-1 loop
				ADD_ONE(index) <= '0';
			end loop;
		end process;
		IN_FLIP <= NOT RODR_IN;
	
	SIGNED_OR_UNSIGNED: process(RODR_IN, IN_FLIP, ADD_ONE, SIGNED_OUT, RODR_SIGBIT)		-- Create a process for sequential logic reading, not concurrent
	variable carry : STD_LOGIC;						-- Initialized to one to add 1 bit to Bit flipped RODR_IN
	BEGIN
		case RODR_SIGBIT is
		when '0' => 										--CASE 1: UNSIGNED
			RODR_OUT <= RODR_IN;
		
		when '1' =>										--CASE 2: 
			if((RODR_IN(nbits-1) = '0')) then
				RODR_OUT <= RODR_IN;
			else
				if (IN_FLIP(0) = '0') then 				--INITIAL CONDITION
					SIGNED_OUT <= IN_FLIP XOR ADD_ONE;
					carry := '0';
				elsif (IN_FLIP(0) = '1') Then
					SIGNED_OUT <= IN_FLIP XOR ADD_ONE;
					carry := '1';
				end if; 	
				for i in 1 to nbits-1 loop					--CHECK THROUGH REST OF IN_FLIP ARRAY
					if (IN_FLIP(i) = '0') then 
						SIGNED_OUT(i) <= IN_FLIP(i) XOR carry;
						carry := '0';
					elsif ((carry = '1') AND (IN_FLIP(i) xor carry) = '0') Then
						SIGNED_OUT(i) <= IN_FLIP(i) XOR carry;
						carry := '1';
					end if ;
				end loop ;
			RODR_OUT <= SIGNED_OUT;
			end if;
			
		end case;
			
	END process Signed_OR_Unsigned ;

END LogicFunction ;