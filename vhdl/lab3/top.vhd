----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:21:16 10/03/2016 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk_i : in  STD_LOGIC;
           btn_i : in  STD_LOGIC_VECTOR (3 downto 0);
           sw_i : in  STD_LOGIC_VECTOR (7 downto 0);
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
end top; 

architecture Behavioral of top is

	COMPONENT led_sterownik
    Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           digit_i : in  STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
   END COMPONENT;
	
	COMPONENT enc_and_mem
    Port ( clk_i : in  STD_LOGIC;
           btn_i : in  STD_LOGIC_VECTOR (3 downto 0);
           sw_i : in  STD_LOGIC_VECTOR (7 downto 0);
           digit_o : out  STD_LOGIC_VECTOR (31 downto 0));
   END COMPONENT;
	
	signal digitz : STD_LOGIC_VECTOR (31 downto 0);

begin

   led_ster: led_sterownik PORT MAP (clk_i, '0', digitz, led7_an_o, led7_seg_o);
   enc_mem: enc_and_mem PORT MAP (clk_i,btn_i,sw_i,digitz);


end Behavioral;

