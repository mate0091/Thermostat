---------------------------------------------------------------------------------------------------
--
-- Title       : clock_divider
-- Design      : Main_units
-- Author      : mate
-- Company     : lolz
--
---------------------------------------------------------------------------------------------------
--
-- File        : clock_divider.vhd
-- Generated   : Mon Apr 30 17:20:30 2018
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {clock_divider} architecture {logic}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clock_divider is
	 port(
		 clk : in STD_LOGIC;
		 enable : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 Data : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end clock_divider;

--}} End of automatically maintained section

architecture logic of clock_divider is
begin
	process(clk, reset)
	variable Q: std_logic_vector(15 downto 0) := (others => '0');
	begin
		if reset = '1' then
			Q := (others => '0');
		elsif enable = '1' and clk'EVENT and clk = '1' then
			Q := Q + '1';
		end if;
		Data <= Q;
	end process;
end logic;
