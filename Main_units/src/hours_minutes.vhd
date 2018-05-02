library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity H_M is
	port(
	SET, INC_HOUR, INC_MIN: in std_logic; --async inputs
	CLK: in std_logic;	-- this has to be a one minute signal
	intCLK: in std_logic; --internal clock for counters, a quarter of a second is enough
	HOUR: out std_logic_vector(7 downto 0); 
	MIN: out std_logic_vector(7 downto 0));
end H_M;

architecture DEF of H_M is
begin
	process(CLK, SET, intCLK)
	variable QTime : std_logic_vector(15 downto 0) := x"2330";	 --internal time
	
	begin
		--if set is 1, we can set the hours and minutes
		if set = '1' then
			--increment hours and minutes using internal clk
			if intCLK = '1' and intCLK'EVENT then
				if INC_HOUR = '1' then
					if QTime(15 downto 8) = x"24" then
						QTime(15 downto 8) := x"00";
					else
						--QTime(15 downto 8) := QTime(15 downto 8) + '1';
						if QTime(11 downto 8) = x"9" then --lower nibble
							QTime(11 downto 8) := x"0";
							QTime(15 downto 12) := QTime(15 downto 12) + '1'; --upper nibble
						else
							QTime(11 downto 8) := QTime(11 downto 8) + '1';	 --lower nibble
						end if;
					end if;
				end if;
				
				if INC_MIN = '1' then
					if QTime(7 downto 0) = x"59" then
						QTime(7 downto 0) := x"00";
					else
						if QTime(3 downto 0) = x"9" then
							QTime(3 downto 0) := x"0";
							QTime(7 downto 4) := QTime(7 downto 4) + '1';
						else
							QTime(3 downto 0) := QTime(3 downto 0) + '1';
						end if;
					end if;
				end if;
			end if;
		
		elsif CLK = '1' and CLK'EVENT then
			--start counting up the minutes, if 60 reset and increment hours
			--if hours = 24, reset everything
			if QTime(7 downto 0) = x"59" then	--need to count up hours
				QTime(7 downto 0) := x"00";	 --reset minutes
				if QTime(11 downto 8) = x"9" then --lower nibble
					QTime(11 downto 8) := x"0";
					QTime(15 downto 12) := QTime(15 downto 12) + '1'; --upper nibble
				else
					QTime(11 downto 8) := QTime(11 downto 8) + '1';	 --lower nibble	
				end if;
				
			else 
				--needs to behave like a decimal counter, can't add directly
				if QTime(3 downto 0) = x"9" then
					QTime(3 downto 0) := x"0";
					QTime(7 downto 4) := QTime(7 downto 4) + '1';
				else
					QTime(3 downto 0) := QTime(3 downto 0) + '1';
				end if;
				
			end if;
			
			if QTime = x"2400" then
				QTime := x"0000";
			end if;
		end if;
		
		HOUR <= QTime(15 downto 8);
		MIN <= QTime(7 downto 0);
	end process;
end DEF;
