LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity RODR_MASTERMAP IS
	generic(N : natural := 16;
				BCDB: natural := 20);
	
	PORT(--RODR_SIGBIT      : IN STD_LOGIC;
		  RODR_Clock1		 : IN STD_LOGIC;
		  RODR_Clock2		 : IN STD_LOGIC;
		  RODR_Clock3	    : IN std_logic;	-- Add
		 -- RODR_Preset 		 : IN STD_LOGIC;
		  RODR_Clear		 : IN STD_LOGIC;
		  RODR_Select 		 : IN STD_LOGIC;		-- Enable
			  RODR_binIN    : IN STD_LOGIC_VECTOR (7 downto 0) ;
			  RODR_LEDONOFF : OUT STD_LOGIC_VECTOR (15 downto 0) := (Others => '0');
					RODR_OF 	 : out std_logic;	-- Overflow
					ZerFlag	 : out std_logic;
					NegFlag	 : out std_logic;
					RODR_CarryIN : IN STD_Logic;
			  
	   RODR_SIGN		    : OUT STD_LOGIC_VECTOR (6 downto 0);		-- For Plus/Minus Seven Segment Display (Last One)
	 RODR_SegmentDisplays : out STD_LOGIC_VECTOR (48 downto 0));		-- For 7 Displays
			  
END RODR_MASTERMAP;

ARCHITECTURE CONNECTIONS of RODR_MASTERMAP IS
	Component RODR_DFlipFlop is 
		port(
			Q : out std_logic;    
			Clk :in std_logic;  
			sync_reset: in std_logic;  
			D :in  std_logic);
	END Component;
	
	Component RODR_NBit_Shift_Register
		generic(nbits : natural := N);
		Port (RODR_CLK : in STD_LOGIC;
				RODR_SET : in STD_LOGIC := '0';
				RODR_CLR : in STD_LOGIC;
				RODR_INS : in STD_LOGIC_VECTOR (7 downto 0) := (Others => '0');
				RODR_INP : in std_LOGIC_VECTOR (nbits-1 downto 0) := (Others => '0');
				Load		: in std_logic := '0';
				RODR_OUT : out STD_LOGIC_VECTOR (nbits-1 downto 0));
	END Component;

	Component RODR_AdderSubtractor
		generic(nbits : natural := N);
		port(	    RODR_A :	in std_logic_vector(nbits-1 downto 0);
			       RODR_B :	in std_logic_vector(nbits-1 downto 0);
			RODR_overflow :	out std_logic;
			RODR_CIN      :   in std_logic;
			RODR_sum      :   out std_logic_vector(nbits-1 downto 0);
			RODR_ACCUM : in std_logic;
			RODR_Clock : in std_logic;
			RODR_CLR		: in std_logic);
	END Component;

	Component RODR_UnsignedSigned
		generic (nbits : natural := N);
		PORT(RODR_SIGBIT : IN STD_LOGIC;
			    RODR_IN   : IN STD_LOGIC_VECTOR (nbits-1 downto 0);
			    RODR_OUT  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0));	
	END Component;

	Component RODR_BINARYBCD
		generic(  nbits : natural := N;
				  BCDBITS : natural := BCDB);
		PORT (        RODR_IN : in  STD_LOGIC_VECTOR (nbits-1 downto 0);
				 RODR_BCDVector : out std_logic_vector (BCDBITS-1 downto 0));
	END Component ;

	Component RODR_BCDDecoder
		PORT(RODR_IN : IN STD_LOGIC_VECTOR (3 downto 0) ;
	       RODR_OUT : OUT STD_LOGIC_VECTOR (6 downto 0));
	END Component ;
	
	Component RODR_PlusMinus
		PORT(RODR_SIGBIT : IN STD_LOGIC;
					RODR_IN : IN STD_LOGIC;
				  RODR_OUT : OUT STD_LOGIC_VECTOR (6 downto 0));
	END Component;
	
signal RODR_NBitShiftOutput1 : std_LOGIC_VECTOR (N-1 downto 0);
signal RODR_NBitShiftOutput2 : std_LOGIC_VECTOR (N-1 downto 0);

signal RODR_ADDOUT : Std_LOGIC_VECTOR (N-1 downto 0);
	
signal RODR_TCO : STD_LOGIC_VECTOR (N-1 downto 0);		--TCO = TWo's Complement Output

signal RODR_BCD_Vector : STD_LOGIC_VECTOR(BCDB-1 downto 0);			-- Output from Binary to BCD Decoder

shared variable RODR_SevenSegment: STD_LOGIC_VECTOR (48 downto 0) := (Others => '1');				-- Seven Segment outputs

BEGIN
	LEDS: process(RODR_NBitShiftOutput1, RODR_NBitShiftOutput2)
	begin
		if(RODR_NBitShiftOutput2 = (RODR_NBitShiftOutput2'range => '0') ) then
			if(N-1 = 31) then
				RODR_LEDONOFF <= RODR_NBitShiftOutput1(15 downto 0);
			else
				RODR_LEDONOFF <= RODR_NBitShiftOutput1(N-1 downto 0);
			end if;
		
		elsif(RODR_NBitShiftOutput1 = (RODR_NBitShiftOutput1'range => '0')) then
			if(N-1 = 31) then
				RODR_LEDONOFF <= RODR_NBitShiftOutput2(15 downto 0);
			else
				RODR_LEDONOFF <= RODR_NBitShiftOutput2(N-1 downto 0);
			end if;
		else
			if(N-1 = 31) then
				RODR_LEDONOFF <= RODR_NBitShiftOutput2(15 downto 0);
			else
				RODR_LEDONOFF <= RODR_NBitShiftOutput2(N-1 downto 0);
			end if;
		end if;
	end process LEDS;
	
	FLAGS: process(RODR_ADDOUT)
	begin
		if(RODR_ADDOUT = 0) then
			ZerFlag <= '1';
		elsif(RODR_ADDOUT > 0) then
			ZerFlag <= '0';
		end if;
		if(RODR_ADDOUT(N-1) = '1') then
			NegFlag <= '1';
		else
			NegFlag <= '0';
		end if;
	end process FLAGS; 	
	
	RODR_NBitShift1	: RODR_NBit_Shift_Register 	PORT MAP(not RODR_Clock1, open, not RODR_Clear, RODR_binIN, open ,'1', RODR_NBitShiftOutput1);
																				
	RODR_NBitShift2	: RODR_NBit_Shift_Register 	PORT MAP(not RODR_Clock2, open, not RODR_Clear, RODR_binIN, open, '1', RODR_NBitShiftOutput2);
	
	RODR_Add 			: RODR_AdderSubtractor			PORT MAP (RODR_NBitShiftOutput1, RODR_NBitShiftOutput2, RODR_OF, RODR_CarryIN, RODR_ADDOUT, RODR_Select, not RODR_Clock3, not RODR_Clear);
	
	RODR_TWOSCOMPLEMENT   : RODR_UnsignedSigned  PORT MAP(RODR_CarryIN, RODR_ADDOUT, RODR_TCO);
	
	RODR_BINARYTOBCD      : RODR_BINARYBCD 		PORT MAP(RODR_TCO, RODR_BCD_Vector);
	
	decoders: for i in 0 to 4 generate			-- Only Work on 7 Seven Segment Displays (2,4,6 for 8, 16, 32 bit)
		DECODERX : RODR_BCDDecoder		PORT MAP(RODR_BCD_Vector((i*4)+3 downto i*4), RODR_SevenSegment((i*7)+6  downto i*7));
	END generate decoders;
	
	RODR_SegmentDisplays <= RODR_SevenSegment;
	
	RODR_POSNEG				 : RODR_PlusMinus			PORT MAP (RODR_CarryIN, RODR_ADDOUT(N-1), RODR_SIGN);
	
END CONNECTIONS;