--##############################################################################
--project:	bin_bcd_ser
--file:			bin_bcd_ser_pkg.vhd
--author:		djordje
--date:			02.12.2019
--------------------------------------------------------------------------------
--package for serial 10bit binary number to bcd converter functions
--##############################################################################
library ieee;
	use 	ieee.std_logic_1164.all;
	use 	ieee.numeric_std.all;
	use 	ieee.math_real.all;
library	work;
	use		work.DE0_pkg.all;
--##############################################################################
package bin_bcd_ser_pkg is
--%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	alias 		T_c 	is De0_cycle_time_c;
	-- constants -----------------------------------------------------------------
	--!! define all constants in one location (package) -> no data inconsistency
	-- in case of change
	--!! use names not only simple values
	constant State_delay_init_c				: time		:=	T_c / 20;
	constant Output_delay_init_c			: time		:=	T_c / 10;
	constant Transition_delay_init_c	: time		:=	T_c / 10;
	constant Set_up_time_init_c				: time		:=	T_c / 5;
	constant Data_path_delay_init_c		: time		:=	T_c / 40;
	constant State_delay_c						: time		:=	T_c / 10;
	constant Output_delay_c						: time		:=	T_c / 20;
	constant Transition_delay_c				: time		:=	T_c / 20;
	constant Set_up_time_c						: time		:=	T_c / 5;
	constant Data_path_delay_c				: time		:=	T_c / 40;
	constant CNT_MAX									: natural	:=	24; --cycles in simulation
--%% FSM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- logic -----------------------------------------------------------------------
	constant T												: std_logic	:= '1';
	constant F												: std_logic := '0';
-- states ----------------------------------------------------------------------
	type state_type_t IS (ST_IDLE, ST_UPDATE_REG, ST_SHIFT_LEFT, ST_Done);
end bin_bcd_ser_pkg;
--%% BODY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
package body bin_bcd_ser_pkg is
end bin_bcd_ser_pkg;
--##############################################################################
