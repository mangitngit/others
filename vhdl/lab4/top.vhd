----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:31:59 10/10/2016 
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
           rst_i : in  STD_LOGIC;
           RXD_i : in  STD_LOGIC;
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
	
	COMPONENT odbiornik
    Port (	clk_i : in  STD_LOGIC;
				RXD_i : in STD_LOGIC;
				digit_o : out  STD_LOGIC_VECTOR (15 downto 0));
   END COMPONENT;
	
	signal digitz : STD_LOGIC_VECTOR (31 downto 0);
	signal recieved : STD_LOGIC_VECTOR(15 downto 0); 

begin

   led_ster: led_sterownik PORT MAP (clk_i, '0', digitz, led7_an_o, led7_seg_o);
   obornik: odbiornik PORT MAP (clk_i,RXD_i,recieved);
	digitz(31 downto 16) <= "1111111111111111";
	digitz(15 downto 0) <= recieved;
end Behavioral;
