library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clk_div_test is
	 port(
		 clk : in STD_LOGIC;
		 led : out STD_LOGIC
	     );
end clk_div_test;

architecture logic of clk_div_test is 

component freq_div_1hz is
	generic(max_count: integer);
	port(
		 clk : in STD_LOGIC;
		 clkout : out STD_LOGIC
	     );
end component;


begin
	uut: freq_div_1hz
	generic map(max_count => 20)
	port map(clk => clk, clkout => led);

end logic;
