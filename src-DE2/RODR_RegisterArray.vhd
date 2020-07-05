LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_RegisterArray IS
	generic(nbits : natural := 16);
	PORT(RegSelect : in std_logic_vector (2 downto 0);
			Clock : in std_logic;
		  SET	  : in std_logic := '0';
		  Clear : in std_logic;
		  RODR_IN   : IN STD_LOGIC_VECTOR (nbits-1 downto 0);
		  Load		: in std_logic := '0';
	     output1  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output2  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output3  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output4  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output5  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output6  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output7  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output8  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0));
END RODR_RegisterArray ;

ARCHITECTURE LogicFunction OF RODR_RegisterArray IS

type input is array (1 to 8) of std_logic_vector(nbits-1 downto 0);

signal a : input := ((Others => '0'), (Others => '0') , (Others => '0') , (Others => '0') , (Others => '0') , (Others => '0') , (Others => '0') , (Others => '0'));

	Component RODR_NBit_Shift_Register
		generic(nbits : natural := nbits);
		Port (RODR_CLK : in STD_LOGIC;
				RODR_SET : in STD_LOGIC := '0';
				RODR_CLR : in STD_LOGIC;
				RODR_INS : in STD_LOGIC_VECTOR (7 downto 0) := (Others => '0');
				RODR_INP : in std_LOGIC_VECTOR (nbits-1 downto 0) := (Others => '0');
				Load		: in std_logic := '0';
				RODR_OUT : out STD_LOGIC_VECTOR (nbits-1 downto 0));
	END Component;
BEGIN
			Register1 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(1), '0', output1);
			Register2 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(2), '0', output2);
			Register3 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(3), '0', output3);
			Register4 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(4), '0', output4);
			Register5 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(5), '0', output5);
			Register6 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(6), '0', output6);
			Register7 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(7), '0', output7);
			Register8 : RODR_NBit_Shift_Register PORT MAP(Clock, open, Clear, open, a(8), '0', output8);

	process(RegSelect, RODR_IN, a)
	BEGIN
		case RegSelect is
		
			when "000" =>
				a(1) <= RODR_IN;
			
			when "001" =>
				a(2) <= RODR_IN;
			
			when "010" =>
				a(3) <= RODR_IN;
			
			when "011" =>
				a(4) <= RODR_IN;
			
			when "100" =>
				a(5) <= RODR_IN;
				
			when "101" =>
				a(6) <= RODR_IN;
			
			when "110" =>
				a(7) <= RODR_IN;
			
			when "111" =>
				a(8) <= RODR_IN;
		end case;
	end process;
END LogicFunction ;