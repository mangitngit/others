--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:20:36 10/05/2017
-- Design Name:   
-- Module Name:   /home/lab790/project1/top_tb.vhd
-- Project Name:  project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         sw_i : IN  std_logic_vector(7 downto 0);
         pb_i : IN  std_logic;
         led7_an_o : OUT  std_logic_vector(3 downto 0);
         led7_seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sw_i : std_logic_vector(7 downto 0) := (others => '0');
   signal pb_i : std_logic := '0';

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          sw_i => sw_i,
          pb_i => pb_i,
          led7_an_o => led7_an_o,
          led7_seg_o => led7_seg_o
        );
 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period := 1ns;
-- 
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
--      wait for 100ms;	

--      wait for <clock>_period*10;

      -- insert stimulus here 
	sw_i <= "11111111";
	wait for 1 ms;
	sw_i <= "01111111";
   wait for 1 ms;
	sw_i <= "00111111";
   wait for 1 ms;
	sw_i <= "00011111";
   wait for 1 ms;
	sw_i <= "00001111";
   wait for 1 ms;
	sw_i <= "00000111";
   wait for 1 ms;
	sw_i <= "00000011";
   wait for 1 ms;
	sw_i <= "00000001";
   wait for 1 ms;
	sw_i <= "00000000";
	wait;
   end process;

END;
