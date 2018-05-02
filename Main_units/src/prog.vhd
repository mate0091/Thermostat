library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use WORK.helper_pack.all;

entity prog is
	generic(lower_bound: unsigned(7 downto 0) := x"05"; default_temp: unsigned(7 downto 0) := x"15");
	port(
	HOUR_IN: in std_logic_vector(7 downto 0);
	THERM_IN: in std_logic_vector(7 downto 0);
	SET: in std_logic;
	INC_HOUR, INC_TEMP: in std_logic;
	HEAT_ENABLE: out std_logic;
	DISPLAY_DATA_HOUR: out std_logic_vector(7 downto 0);
	DISPLAY_DATA_TEMP: out std_logic_vector(7 downto 0);
	CLK: in std_logic);
end prog;

architecture def of prog is
type memory is array(0 to 23) of std_logic_vector(7 downto 0);

begin
	process(SET, CLK)

	variable SET_TEMP: std_logic_vector(7 downto 0) := std_logic_vector(default_temp); --15
	variable SET_HOUR: std_logic_vector(7 downto 0) := (others => '0');
	
	variable mem: memory := (others => SET_TEMP);
	
	begin
	if SET = '1' then  --device is in set mode
		if CLK'EVENT and CLK = '1' then
			--user can program the device with inc_hour and inc_temp
			--save the results into set_temp and set_hour
			if INC_HOUR = '1' then
				if SET_HOUR = x"23" then
					SET_HOUR := x"00";
				else
					if SET_HOUR(3 downto 0) = x"9" then --lower nibble
						SET_HOUR(3 downto 0) := x"0";
						SET_HOUR(7 downto 4) := SET_HOUR(7 downto 4) + '1'; --upper nibble
					else
						SET_HOUR(3 downto 0) := SET_HOUR(3 downto 0) + '1';	 --lower nibble
					end if;
				end if;
			end if;
			
			if INC_TEMP = '1' then
				if SET_TEMP = x"32" then
					SET_TEMP := x"00";
				else
					if SET_TEMP(3 downto 0) = x"9" then --lower nibble
						SET_TEMP(3 downto 0) := x"0";
						SET_TEMP(7 downto 4) := SET_TEMP(7 downto 4) + '1'; --upper nibble
					else
						SET_TEMP(3 downto 0) := SET_TEMP(3 downto 0) + '1';	 --lower nibble
					end if;
				end if;
			end if;
		end if;
	
	else  --set = 0, if set'event, save data, else operate on automatic mode
		if SET'EVENT and SET = '0' then
			--save data
			mem(BCD_to_int(SET_HOUR)) := SET_TEMP;
			
		elsif CLK'EVENT and CLK = '1' then --automatic mode
			--if the thermistor input is less than the data saved at the address of the hour input then heat enable
			
			if THERM_IN >= mem(BCD_to_int(HOUR_IN)) - std_logic_vector(lower_bound) then
				HEAT_ENABLE <= '0';
			elsif THERM_IN < mem(BCD_to_int(HOUR_IN)) then
				HEAT_ENABLE <= '1';
			end if;
		end if;
	end if;
	
	DISPLAY_DATA_HOUR <= SET_HOUR;
	DISPLAY_DATA_TEMP <= SET_TEMP;		
	
	end process;
end def;
			
			
