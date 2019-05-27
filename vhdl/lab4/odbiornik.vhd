----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:24:34 10/03/2016 
-- Design Name: 
-- Module Name:    odbiornik - Behavioral 
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

entity odbiornik is
    Port ( clk_i : in  STD_LOGIC;
           RXD_i : in  STD_LOGIC;
           digit_o : out  STD_LOGIC_VECTOR (15 downto 0));
end odbiornik;

architecture Behavioral of odbiornik is

COMPONENT decoder
    Port ( bitz_i : in  STD_LOGIC_VECTOR (3 downto 0);
           num_o : out  STD_LOGIC_VECTOR (7 downto 0));
   END COMPONENT;

signal starszy_nib : STD_LOGIC_VECTOR(3 downto 0);
signal mlodszy_nib : STD_LOGIC_VECTOR(3 downto 0);
signal RXD_internal : STD_LOGIC;

type StateType is (idle, waitforit, recivin, finishin);
signal present_state : StateType;
signal next_state : StateType;
begin

	buforek_odbiorek : process (clk_i) is
	begin
		if rising_edge(clk_i) then
			RXD_internal <= RXD_i;
		end if;
	end process;
	
	stejt_machina_komb : process (clk_i) is
	variable recvcount : integer := 0;
	variable x : integer := 0;
	begin
		if rising_edge(clk_i) then
			present_state <= next_state;
			case present_state is
				when idle =>
					if RXD_internal = '0' then
						next_state <= waitforit;
						x := 0;
					end if;
				when waitforit =>
					x := x + 1;
					if x = 2604 then
						if RXD_internal = '0' then
							next_state <= recivin;
						else
							next_state <= idle;
						end if;
						x := 0;
					end if;
				when recivin =>
					x := x + 1;
					if x = 5208 then
						if recvcount = 8 then
							next_state <= finishin;
						elsif recvcount < 4 then
							mlodszy_nib(recvcount) <= RXD_internal;
							recvcount := recvcount + 1;
						elsif recvcount < 8 then
							starszy_nib(recvcount-4) <= RXD_internal;
							recvcount := recvcount + 1;
						end if;
						x := 0;
					end if;
				when finishin =>
						x := 0;
						recvcount := 0;
						next_state <= idle;
				end case;
			end if;
		end process;
	

	nibble1 : decoder port map (starszy_nib, digit_o(15 downto 8));
	nibble2 : decoder port map (mlodszy_nib, digit_o(7 downto 0));
	
end Behavioral;

