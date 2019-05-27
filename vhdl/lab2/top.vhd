----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:21:54 10/12/2017 
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
use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( rst_i : in  STD_LOGIC;
           clk_i : in  STD_LOGIC;
           led_o : out  STD_LOGIC_VECTOR (2 downto 0));
end top;

architecture Behavioral of top is

signal pb : std_logic_vector(2 downto 0);
signal jp2 : std_logic;

begin

process (clk_i, rst_i) is
variable x:std_logic_vector(2 downto 0);
variable y:std_logic_vector(2 downto 0);
variable z:std_logic_vector(2 downto 0);
begin
  if rst_i = '1' then
    y := "000";
	 x := "000";
  elsif rising_edge(clk_i) then
    --x := data(15 downto 13) & data(2 downto 0);
	 x := x + 1; -- binarny
	 y(0) := x(0) xor x(1);
	 y(1) := x(1) xor x(2);
	 y(2) := x(2) xor '0';
    --x := x * "10";
  end if;
  
  led_o <= y;
end process;

end Behavioral;



