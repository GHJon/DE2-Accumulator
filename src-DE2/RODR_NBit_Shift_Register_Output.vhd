library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RODR_NBit_Shift_Register_Output is
--	generic (nbits : natural := 16);
	generic(nbits : natural);
	Port (RODR_CLK : in STD_LOGIC;
			RODR_SET : in STD_LOGIC;
			RODR_CLR : in STD_LOGIC;
			 RODR_IN : in STD_LOGIC_VECTOR (nbits-1 downto 0);
		   RODR_OUT : out STD_LOGIC_VECTOR (nbits-1 downto 0));
end RODR_NBit_Shift_Register_Output ;

architecture Behavioral of RODR_NBit_Shift_Register_Output is

signal tempOut : std_LOGIC_VECTOR (nbits-1 downto 0);		-- Bit storage for Shifting and Set/Clear
shared variable index: integer := nbits-8;
begin
	RODR_OUT <= TempOut;
	process(RODR_CLK, RODR_CLR, RODR_SET)
	begin
		if(RODR_CLR ='1' AND RODR_SET = '0') then
			tempOut <= (others => '0');
			index := nbits-8;
		elsif(RODR_SET ='1' AND RODR_CLR = '0') then
			tempOut <= (others => '1');
			index := nbits-8;
		elsif (RODR_CLK = '0') then
			tempOut <= RODR_IN;
		end if;
	end process;
end Behavioral;