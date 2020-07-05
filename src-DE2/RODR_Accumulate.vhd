library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity RODR_Accumulate is
	generic(nbits : natural)
	port(clk, reset : in std_logic;
			Din : in std_logic_vector(nbits-1 downto 0);
			  Q : out std_logic_vector(nbits-1 downto 0));
end RODR_Accumulate;

architecture bhv of RODR_Accumulate is
signal tmp: std_logic_vector(3 downto 0);
begin
	process (clk, reset)
	begin
		if (reset='1') then
			tmp <= (Others => '0');
		elsif rising_edge(clk) then
			tmp <= tmp + Din;
		end if;
	end process;
	Q <= tmp;
end bhv;