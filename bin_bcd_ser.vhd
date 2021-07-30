--##############################################################################
--project:	bin_bcd_ser
--file:			bin_bcd_ser.vhd
--author:		djordje
--date:			02.12.2019
--------------------------------------------------------------------------------
--convert 10bit binary number to bcd
--##############################################################################
library ieee;
	use 	ieee.std_logic_1164.all;
	use 	ieee.numeric_std.all;
library	work;
	use		work.bin_bcd_ser_pkg.all;	-- package placed in work directory
--##############################################################################
entity bin_bcd_ser is
  generic	(-- !! always initialise generics
					 -- !! beware code style 
					state_delay_g					: time := State_delay_init_c;	--don't use values
					output_delay_g					: time := Output_delay_init_c;
					transition_delay_g			: time := Transition_delay_init_c;
					set_up_time_g					: time := Set_up_time_init_c;
					data_path_delay_g				: time := Data_path_delay_init_c
					);	
	port		(
					CLK				:	in	std_logic;
					RES				:	in	std_logic;
					START_in			: 	in	std_logic;
					BIN_in			: 	in	std_logic_vector(9 downto 0);
					BCD2_out			:	out	std_logic_vector(3 downto 0);
					BCD1_out 		: 	out	std_logic_vector(3 downto 0);
					BCD0_out			: 	out 	std_logic_vector(3 downto 0);
					Tdone_out		:	out	std_logic
					); 
end bin_bcd_ser;
--##############################################################################
architecture rtl of bin_bcd_ser is
  signal state_s		: state_type_t;	-- !!implemented as d_ff
	signal r_bin_s		: std_logic_vector(9 downto 0);	--shift register (bin_value)
	signal r_cnt_s		: unsigned(3 downto 0);--cnt register, 10 steps
	signal r2_bcd_s	: unsigned(3 downto 0);	--bcd register 10^2
	signal r1_bcd_s	: unsigned(3 downto 0);									--bcd register 10^1
	signal r0_bcd_s	: unsigned(3 downto 0);										--bcd register 10^0
	begin
--$$ transition net and state registers  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$		
		ESN_REG: process (CLK, RES) -- esn and registers in single process 														
    	begin											-- allowed according  to vhdl standard
      	if RES = '1' then				-- prefered coding method
					state_s <= ST_IDLE after state_delay_g;
        -- clock_synchronous_frame ============================================>
        elsif CLK'event and CLK = '1' then 
				case state_s is							 
          	when ST_IDLE		=>	
            	if START_in		= T then 
								r_cnt_s 		<= "1010" 	after data_path_delay_g;
								r_bin_s		<= BIN_in 	after data_path_delay_g;
								r2_bcd_s		<= (others => '0')	after data_path_delay_g;
								r1_bcd_s		<= (others => '0')	after data_path_delay_g;
								r0_bcd_s		<= (others => '0') 	after data_path_delay_g;
							
								state_s			<=	ST_UPDATE_REG		after data_path_delay_g;
              --no else -> assume state at entry in other cases     
              end if;
            
				
				
				when ST_UPDATE_REG	=>		
							-- done in data path -------------------------------------------->
					r_cnt_s				<=	r_cnt_s-1		after data_path_delay_g;
					if 	r0_bcd_s	> 4 then
								r0_bcd_s 		<= 	r0_bcd_s + 3		after data_path_delay_g;
					end if;
					if 	r1_bcd_s > 4 then
								r1_bcd_s <= r1_bcd_s + 3 after data_path_delay_g;
					end if;
					if 	r2_bcd_s > 4 then
								r2_bcd_s <= r2_bcd_s + 3 after data_path_delay_g;
					end if;
					
							-----------------------------------------------------------------<
              state_s				<=	ST_SHIFT_LEFT		after state_delay_g;  
            
				
				
				
				
				when ST_SHIFT_LEFT	=>
							-- done in data path -------------------------------------------->
							r2_bcd_s	<= 	r2_bcd_s (2 downto 0) & r1_bcd_s (3) 
														after data_path_delay_g;
							r1_bcd_s	<= 	r1_bcd_s (2 downto 0) & r0_bcd_s (3)
														after data_path_delay_g;
							r0_bcd_s	<= 	r0_bcd_s(2 downto 0) & r_bin_s(9)
														after data_path_delay_g;
							r_bin_s		<= 	r_bin_s (8 downto 0) 	& '0'
														after data_path_delay_g;
							-----------------------------------------------------------------<
							
							if r_cnt_s = 0 then
								state_s	<= ST_DONE after state_delay_g;
							else 
								state_s	<= ST_UPDATE_REG after state_delay_g;
							end if;
						
						
						when ST_DONE	=>
							-- moore principle: Tdone_out generated in asn -> no need to clear
							state_s		<= ST_IDLE after state_delay_g;
					end case;
        -- clock_synchronous_frame ============================================<
				-- BEWARE !! don't acess registers (state_s, r_cnt_s, ....) any more !!
        end if;
    end process ESN_REG;
		-- synchronous combinatorial output using concurrent assignements, 
		-- set when state is entered, prefered implementig moore structure	
		 with state_s select
			Tdone_out <= '1' after output_delay_g	when ST_DONE, '0' after output_delay_g when others;
		
		-- transfer to output
		BCD2_out 	<= std_logic_vector (r2_bcd_s) after output_delay_g;
		BCD1_out		<= std_logic_vector (r1_bcd_s) after output_delay_g;
		BCD0_out 	<= std_logic_vector (r0_bcd_s) after output_delay_g;
end rtl;
