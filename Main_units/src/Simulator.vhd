library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SIM is
	port(
	EN_HEAT: in std_logic;
	CLK: in std_logic;
	THERM_OUT: out std_logic_vector(7 downto 0));
end SIM;

architecture DEF of SIM is
begin
	process(CLK)
	variable Q: std_logic_vector(7 downto 0) := x"01"; --init to 15
	
	begin
		if CLK'EVENT and CLK = '1' then
			if Q >= x"00" and Q <= x"32" then --only count when temp is greater than 0 and less than 32
				if EN_HEAT = '1' then
					--count upwards, only if not 32
					if Q < x"32" then
						if Q(3 downto 0) = X"9" then --null lower 4 bits, increment upper 4 bits
							Q(7 downto 4) := Q(7 downto 4) + '1';
							Q(3 downto 0) := X"0";
						else
							Q(3 downto 0) := Q(3 downto 0) + '1';
						end if;
					end if;
				else
					if Q(3 downto 0) = X"0" then --decrement first half, lower half = 9
						--Q(3 downto 0) := X"0";
						
						if Q(7 downto 4) = X"0" then
							Q(7 downto 4) := x"0";
							Q(3 downto 0) := x"0";
						else
							Q(7 downto 4) := Q(7 downto 4) - '1';
							Q(3 downto 0) := x"9";
						end if;
					else
						Q(3 downto 0) := Q(3 downto 0) - '1'; 
					end if;
					
				end if;
			end if;
		end if;
		THERM_OUT <= Q;
	end process;
end DEF;
			
				