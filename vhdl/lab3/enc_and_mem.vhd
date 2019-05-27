----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:24:34 10/03/2016 
-- Design Name: 
-- Module Name:    enc_and_mem - Behavioral 
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

entity enc_and_mem is
    Port ( clk_i : in  STD_LOGIC;
           btn_i : in  STD_LOGIC_VECTOR (3 downto 0);
           sw_i : in  STD_LOGIC_VECTOR (7 downto 0);
           digit_o : out  STD_LOGIC_VECTOR (31 downto 0));
end enc_and_mem;

architecture Behavioral of enc_and_mem is

signal digitz : STD_LOGIC_VECTOR(31 downto 0);
signal cyfra : STD_LOGIC_VECTOR(6 downto 0);
begin

dzialanko : process(clk_i) is
	begin
		if rising_edge(clk_i) then
			case sw_i(3 downto 0) is
				when "0000" => cyfra <= "0000001";
				when "0001" => cyfra <= "1001111";
				when "0010" => cyfra <= "0010010";
				when "0011" => cyfra <= "0000110";
				when "0100" => cyfra <= "1001100";
				when "0101" => cyfra <= "0100100";
				when "0110" => cyfra <= "0100000";
				when "0111" => cyfra <= "0001111";
				when "1000" => cyfra <= "0000000";
				when "1001" => cyfra <= "0000100";
				when "1010" => cyfra <= "0001000";
				when "1011" => cyfra <= "1100000";
				when "1100" => cyfra <= "0110001";
				when "1101" => cyfra <= "1000010";
				when "1110" => cyfra <= "0110000";
				when "1111" => cyfra <= "0111000";
				when others => cyfra <= "1111111";
			end case;
			case btn_i is
				when "1000" => digitz(31 downto 25) <= cyfra;
				when "0100" => digitz(23 downto 17) <= cyfra;
				when "0010" => digitz(15 downto 9) <= cyfra;
				when "0001" => digitz(7 downto 1) <= cyfra;
				when others => digitz <= digitz;
			end case;
			digitz(0) <= not sw_i(4);
			digitz(8) <= not sw_i(5);
			digitz(16) <= not sw_i(6);
			digitz(24) <= not sw_i(7);
		end if;
	end process;
digit_o <= digitz;
end Behavioral;

