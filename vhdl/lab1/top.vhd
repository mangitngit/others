----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:44 10/05/2017 
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
    Port ( sw_i : in  STD_LOGIC_VECTOR (7 downto 0);
           pb_i : in  STD_LOGIC;
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

signal pb : std_logic_vector(7 downto 0);
signal jp2 : std_logic;

-- signal gmd : std_logic

begin
	-- pb <= pb_i & pb_i & pb_i & pb_i & pb_i & pb_i & pb_i & pb_i;
	-- led7_seg_o <= "11111100"; -- zero
	-- led7_seg_o <= "
	-- led7_seg_o <= sw_i;
	-- led7_seg_o(6 downto 0) <= sw_i (6 downto 0);
	-- led7_seg_o <= sw_i and pb;
--	led7_seg_o <= "11111100"; -- litera 'O'00000011
--	led7_seg_o <= "11110010"; -- litera 'E'
	jp2 <= sw_i(0) xor sw_i(1) xor sw_i(2) xor sw_i(3) xor sw_i(4) xor sw_i(5) xor sw_i(6) xor sw_i(7);
	led7_seg_o <= "00000011" when jp2 = '1' else "01100001";-- litera 'O'
	--led7_seg_o <= "11110010" when jp2 = 0-- litera 'E'
	
		
		
	led7_an_o <= "0110";

end Behavioral;

