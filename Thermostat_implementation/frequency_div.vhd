library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity freq_div_1hz is
	generic(max_count: integer:= 50000000);
	port(
		 clk : in STD_LOGIC;
		 clkout : out STD_LOGIC
	     );
end freq_div_1hz;

architecture logic of freq_div_1hz is
begin
	process(clk)
	variable count: integer range 0 to max_count:= 0;
	begin
		if clk'EVENT and clk = '1' then
			count := count + 1;
			if count = max_count - 1 then
				count := 0;
			end if;
			
			if count < max_count / 2 then --50% duty cycle
				clkout <= '0';
			else
				clkout <= '1';
			end if;
		end if;
	end process;
end logic;
