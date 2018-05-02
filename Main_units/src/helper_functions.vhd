library IEEE;
use IEEE.STD_LOGIC_1164.all;

package helper_pack is
	function BCD_to_int(bcd: std_logic_vector(7 downto 0)) return integer;
end helper_pack;

package body helper_pack is

	function BCD_to_int(bcd: std_logic_vector(7 downto 0)) return integer is
	variable value: integer;
	begin
		case bcd is
			when x"00" => value := 0;
			when x"01" => value := 1;
			when x"02" => value := 2;
			when x"03" => value := 3;
			when x"04" => value := 4;
			when x"05" => value := 5;
			when x"06" => value := 6;
			when x"07" => value := 7;
			when x"08" => value := 8;
			when x"09" => value := 9;
			when x"10" => value := 10;
			when x"11" => value := 11;
			when x"12" => value := 12;
			when x"13" => value := 13;
			when x"14" => value := 14;
			when x"15" => value := 15;
			when x"16" => value := 16;
			when x"17" => value := 17;
			when x"18" => value := 18;
			when x"19" => value := 19;
			when x"20" => value := 20;
			when x"21" => value := 21;
			when x"22" => value := 22;
			when x"23" => value := 23;
			when others => value := 0;
		end case;
	return value;
	end BCD_to_int;
end helper_pack;