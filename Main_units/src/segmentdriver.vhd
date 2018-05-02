library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity segment_driver is
	 port(
		 clk : in STD_LOGIC;
		 disp_A : in STD_LOGIC_VECTOR(3 downto 0);
		 disp_C : in STD_LOGIC_VECTOR(3 downto 0);
		 disp_D : in STD_LOGIC_VECTOR(3 downto 0);
		 disp_B : in STD_LOGIC_VECTOR(3 downto 0);
		 A : out STD_LOGIC;
		 B : out STD_LOGIC;
		 C : out STD_LOGIC;
		 D : out STD_LOGIC;
		 E : out STD_LOGIC;
		 F : out STD_LOGIC;
		 G : out STD_LOGIC;
		 sel_disp_A : out STD_LOGIC;
		 sel_disp_B : out STD_LOGIC;
		 sel_disp_C : out STD_LOGIC;
		 sel_disp_D : out STD_LOGIC
	     );
end segment_driver;

architecture logic of segment_driver is
--Internal signals for divided clock, temp_digit_data and temp_cnt_data
signal temp_digit: std_logic_vector(3 downto 0);
signal temp_cnt_data: std_logic_vector(15 downto 0);
signal divided_clock: std_logic;
--Components
component segmentdecoder is
	port(
	Digit: in std_logic_vector(3 downto 0);
	A: out std_logic;
	B: out std_logic;
	C: out std_logic;
	D: out std_logic;
	E: out std_logic;
	F: out std_logic;
	G: out std_logic);
end component;

component clock_divider is
	 port(
		 clk : in STD_LOGIC;
		 enable : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 Data : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end component;

begin
--Component instantiation
uut: segmentdecoder port map(
Digit => temp_digit,
A => A,
B => B,
C => C,
D => D,
E => E,
F => F,
G => G);

uut1: clock_divider port map(
clk => clk,
enable => '1',
reset => '0',
Data => temp_cnt_data);

divided_clock <= temp_cnt_data(15); --15 mhz

DRIVER: process(divided_clock)
variable sel: std_logic_vector(1 downto 0) := "00";

begin
	if divided_clock'EVENT and divided_clock = '1' then
		case sel is
			when "00" => temp_digit <= disp_A;
			sel_disp_A <= '0';
			sel_disp_B <= '1';
			sel_disp_C <= '1';
			sel_disp_D <= '1';
			sel := sel + '1';
			when "01" => temp_digit <= disp_B;
			sel_disp_A <= '1';
			sel_disp_B <= '0';
			sel_disp_C <= '1';
			sel_disp_D <= '1';
			sel := sel + '1';
			when "10" => temp_digit <= disp_C;
			sel_disp_A <= '1';
			sel_disp_B <= '1';
			sel_disp_C <= '0';
			sel_disp_D <= '1';
			sel := sel + '1';
			when "11" => temp_digit <= disp_D;
			sel_disp_A <= '1';
			sel_disp_B <= '1';
			sel_disp_C <= '1';
			sel_disp_D <= '0';
			sel := sel + '1';
			when others => null;
		end case;
	end if;
end process DRIVER;
end logic;
