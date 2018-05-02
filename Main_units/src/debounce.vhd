library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity debounce is
	generic(counter_size: integer := 19);
	port(
	clk: in std_logic;
	input: in std_logic;			  
	output: out std_logic);
end debounce;

--}} End of automatically maintained section

architecture logic of debounce is
signal ff : std_logic_vector(1 downto 0) := (others => '0');
signal cnt_reset: std_logic := '0';
signal cnt_out: std_logic_vector(counter_size downto 0) := (others => '0');
begin
	cnt_reset <= ff(1) xor ff(0);	 --start or reset counter
	
	process(clk)
	begin
		if clk'EVENT and clk = '1' then
			ff(0) <= input;
			ff(1) <= ff(0);
			
			if cnt_reset = '1' then	--reset counter because input is changing
				cnt_out <= (others => '0');
			elsif(cnt_out(counter_size) = '0') then --stable time is not reached until the last bit of the counter is 0
				cnt_out <= cnt_out + 1;
			else -- stable input time is met
				output <= ff(1);
			end if;
		end if;
	end process;
end logic;
