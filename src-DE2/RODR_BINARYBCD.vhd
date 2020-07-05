library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity RODR_BINARYBCD is								
	generic (nbits : natural;
				BCDBITS : natural); -- nbits(8) -> BCDBITS(12), nbits(16) -> BCDBits (20), nbits(32) -> BCDBITS (40)
				
    Port ( RODR_IN : in  STD_LOGIC_VECTOR (nbits-1 downto 0);
			  RODR_BCDVector : out std_logic_vector (BCDBITS-1 downto 0));
end RODR_BINARYBCD;

architecture Behavioral of RODR_BINARYBCD is
begin
	process(RODR_IN)
	variable temp : STD_LOGIC_VECTOR (nbits-1 downto 0);
	variable bcd : UNSIGNED (BCDBITS-1 downto 0) := (others => '0');	-- Unsigned to do number inputs
  
	begin
		bcd := (OTHERS => '0');
		temp(nbits-1 downto 0) := RODR_IN;     -- read input into temp variable
	
		for i in 0 to nbits-1 loop
			for j in 0 to (BCDBITS/4)-1 loop
				if bcd((j*4)+3 DOWNTO j*4) > 4 then 
					bcd((j*4)+3 DOWNTO j*4) := bcd((j*4)+3 DOWNTO j*4) + 3;
				end if;
			end loop;
		-- don't need to do anything to upper 4 bits of bcd
	
		-- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
			bcd := bcd(BCDBITS-2 downto 0) & temp(nbits-1);
	
		-- shift temp left by 1 bit
			temp := temp(nbits-2 downto 0) & '0';
			end loop;
		-- set outputs
		RODR_BCDVector <= STD_LOGIC_VECTOR(bcd);
  end process bcd1;            
end Behavioral;