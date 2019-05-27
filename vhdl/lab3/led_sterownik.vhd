----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:12 10/03/2016 
-- Design Name: 
-- Module Name:    led_sterownik - Behavioral 
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

entity led_sterownik is
    Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           digit_i : in  STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
end led_sterownik;

architecture Behavioral of led_sterownik is

-- aktywny pierwszy segment
signal aktywny_segment : STD_LOGIC_VECTOR (3 downto 0) := "0111";
signal kodzik : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
constant podzial_zegara : INTEGER := 50000;

begin
	mux: process(clk_i) is
		variable x: integer := 0;
		begin
			if rising_edge(clk_i) then
				x := x + 1;
				if x = podzial_zegara then
					case aktywny_segment is
						when "0111" => aktywny_segment <= "1011";
						when "1011" => aktywny_segment <= "1101";
						when "1101" => aktywny_segment <= "1110";
						when "1110" => aktywny_segment <= "0111";
						when others => aktywny_segment <= "0111";
					end case;
					x := 0;
				end if;
			end if; 
		end process;
	led7_seg_o <= kodzik;
	led7_an_o <= aktywny_segment;
	with aktywny_segment select kodzik <=
		digit_i(31 downto 24) when "0111",
		digit_i(23 downto 16) when "1011",
		digit_i(15 downto 8) when "1101",
		digit_i(7 downto 0) when "1110",
		"00000000" when others;
end Behavioral;

