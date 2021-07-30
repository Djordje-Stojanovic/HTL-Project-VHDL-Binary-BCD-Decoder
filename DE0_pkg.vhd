--##############################################################################
--project:	full_adder
--file:		DE0_package.vhd
--author:	djordje
--date:		02.12.2019
--------------------------------------------------------------------------------
--package for terasic_DE0_board
--##############################################################################
library	ieee;
	use 	ieee.std_logic_1164.all;
	use 	ieee.numeric_std.all;
	use 	ieee.math_real.all;
--##############################################################################
package DE0_pkg is
--%% CLOCK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	-- use for circuit demonstration on de0 (button_in, switch_in, led_out) 
	-- instead of De0_clk_freq_c, also recommended for emulation with counters
	-- involved
-- DE0 emulation CLK frequency -------------------------------------------------
	constant Em_clk_freq_c		: real := 5.0;
	-- DE0 emulation cycle time
  constant Em_cycle_time_c 	: time := 1.0 sec / Em_clk_freq_c;
	-- use for final implementation on de0, also recommended for simulation
	-- when possible (no counters involved)
-- DE0 50MHz Clock -------------------------------------------------------------
  constant De0_clk_freq_c   	: real := 50.0E6;
  -- DE0 Cycle Time
  constant De0_cycle_time_c 	: time := 1.0 sec / De0_clk_freq_c;
--%% BASIC IO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  -- number of leds
  constant Leds_c     			: natural := 10;
  -- number of 7-Segment displays
  constant Digits_c   			: natural :=  4;
  -- number of switches
  constant Switches_c 			: natural := 10;
  -- number of buttons
  constant Buttons_c  			: natural :=  3;
--%% 7_SEG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  -- 7 segment display interface
  subtype disp_type is std_logic_vector(6 downto 0);
		type disp_array_type is array (0 to 15) of disp_type;
		constant Disp_array_c	: disp_array_type	:=	(("0111111"),  -- 0
																	("0000110"),  -- 1
																	("1011011"),  -- 2
																	("1001111"),  -- 3
																	("1100110"),  -- 4
																	("1101101"),  -- 5
																	("1111101"),  -- 6
																	("0000111"),  -- 7
																	("1111111"),  -- 8
																	("1101111"),  -- 9
																	("1110111"),  -- A
																	("1111100"),  -- b
																	("0111001"),  -- C
																	("1011110"),  -- d
																	("1111001"),  -- E
																	("1110001")); -- F
--%% add OTHERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end DE0_pkg;
