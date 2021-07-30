--##############################################################################
--project:	bin_bcd_ser
--file:			tb_bin_bcd_ser.vhd
--author:		djordje
--date:			02.12.2019
--------------------------------------------------------------------------------
--test bench for serial 10bit binary number to bcd converter
--##############################################################################
library ieee;
	use 	ieee.std_logic_1164.all;
	use		ieee.numeric_std.all;
library	work;
	use		work.bin_bcd_ser_pkg.all;
--##############################################################################
entity	tb_bin_bcd_ser is
end 		tb_bin_bcd_ser;
--##############################################################################
architecture behavior of tb_bin_bcd_ser is
	signal clk_s					: std_logic;
	signal res_s					: std_logic;
	signal start_in_s			: std_logic; 
	signal bin_in_s				: std_logic_vector (9 downto 0);
	signal bcd2_out_s			: std_logic_vector (3 downto 0);
	signal bcd1_out_s			: std_logic_vector (3 downto 0);
	signal bcd0_out_s			: std_logic_vector (3 downto 0);
	signal tdone_out_s		: std_logic;
	------------------------------------------------------------------------------
	signal clk_cnt_s			: natural range 0 to CNT_MAX;
	signal d_0_s					: std_logic_vector (9 downto 0)
												:= (others => '0');
	signal d_in_s					: std_logic_vector (9 downto 0)
												:= std_logic_vector (to_unsigned (222, 10));
	begin
		--$$ test circuit $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
		UUT : entity work.bin_bcd_ser (rtl)
			generic map	(
									state_delay_g				=> State_delay_c,
									output_delay_g			=> Output_delay_c,
									transition_delay_g	=> Transition_delay_c,
									set_up_time_g				=> Set_up_time_c,
									data_path_delay_g		=> Data_path_delay_c
									)
			port map		(
									CLK									................
									RES									................
									START_in						................
									BIN_in							................
									BCD2_out						................
									BCD1_out						................
									BCD0_out						................
									Tdone_out						................
									);
		--$$ source configuration $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
		---- clock -----------------------------------------------------------------
		SCK : process
		begin
			clk_cnt_s 	<= 0;
			for i in 0 to CNT_MAX - 1 loop
				clk_cnt_s <= clk_cnt_s + 1;
				clk_s 		<= '1'; 
				wait for T_c / 2; 
				clk_s 		<= '0';
				wait for T_c / 2;
			end loop;
			wait;
		end process SCK;
		---- control input ---------------------------------------------------------
		CNTR : process
			begin
				res_s				<=	
					T,F						after 1.00 * T_c - T_c / 5;
				start_in_s	<= 	
					.........................................
				wait;
		end process CNTR;
		---- data input ------------------------------------------------------------
		TEST_VECTORS : process
			begin
				bin_in_s		<=	
					.........................................
				wait;
		end process TEST_VECTORS;
end behavior;
