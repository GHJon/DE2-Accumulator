LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_SelToAdder IS
	generic(nbits : natural := 16);
	PORT(SEL : in std_logic_vector (2 downto 0);
		  but : in std_logic;
	     input1  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
	     input2  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
	     input3  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
	     input4  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
	     input5  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
	     input6  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
	     input7  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
	     input8  : in STD_LOGIC_VECTOR (nbits-1 downto 0);
		  output1 : out STD_logic_vector (nbits-1 downto 0);
		  output2 : out STD_logic_vector (nbits-1 downto 0));
END RODR_SelToAdder ;

ARCHITECTURE LogicFunction OF RODR_SelToAdder IS

type input is array (1 to 8) of std_logic_vector(nbits-1 downto 0);
signal a : input := (input1, input2, input3, input4, input5, input6, input7, input8);

BEGIN
	process(a, SEL, but)
	variable counter : integer := 0;
	begin
	
	if(rising_edge(but)) then
		if(counter = 0) then
			case SEL is
			
				when "000" =>
				output1 <= a(1);
				counter := counter+1;
				
				when "001" =>
				output1 <= a(2);
				counter := counter+1;
				
				when "010" =>
				output1 <= a(3);
				counter := counter+1;
				
				when "011" =>
				output1 <= a(4);
				counter := counter+1;
				
				when "100" =>
				output1 <= a(5);
				counter := counter+1;
				
				when "101" =>
				output1 <= a(6);
				counter := counter+1;
				
				when "110" =>
				output1 <= a(7);
				counter := counter+1;
				
				when "111" =>
				output1 <= a(8);
				counter := counter+1;
			end case;
		elsif(counter = 1) then
			case SEL is
			
				when "000" =>
				output2 <= a(1);
				counter := counter+1;
				
				when "001" =>
				output2 <= a(2);
				counter := counter+1;
				
				when "010" =>
				output2 <= a(3);
				counter := counter+1;
				
				when "011" =>
				output2 <= a(4);
				counter := counter+1;
				
				when "100" =>
				output2 <= a(5);
				counter := counter+1;
				
				when "101" =>
				output2 <= a(6);
				counter := counter+1;
				
				when "110" =>
				output2 <= a(7);
				counter := counter+1;
				
				when "111" =>
				output2 <= a(8);
				counter := counter+1;
			end case;
			if(counter = 2) then
				counter := 0;
			end if;
		end if;
	end if;
	end process;
END LogicFunction ;