library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity segmentdecoder is
	port(
	Digit: in std_logic_vector(3 downto 0);
	A: out std_logic;
	B: out std_logic;
	C: out std_logic;
	D: out std_logic;
	E: out std_logic;
	F: out std_logic;
	G: out std_logic);
end segmentdecoder;

architecture logic of segmentdecoder is

begin
	process(Digit)
	variable Decode_data: std_logic_vector(6 downto 0);
	begin
		case Digit is
			when X"0" => Decode_data := "1111110";
			when X"1" => Decode_data := "0110000";
			when X"2" => Decode_data := "1101101";
			when X"3" => Decode_data := "1111001";
			when X"4" => Decode_data := "0110011";
			when X"5" => Decode_data := "1011011";
			when X"6" => Decode_data := "1011111";
			when X"7" => Decode_data := "1110000";
			when X"8" => Decode_data := "1111111";
			when X"9" => Decode_data := "1111011";
			when others => Decode_data := "0000000";
		end case;
		
		A <= not Decode_data(6);
		B <= not Decode_data(5);
		C <= not Decode_data(4);
		D <= not Decode_data(3);
		E <= not Decode_data(2);
		F <= not Decode_data(1);
		G <= not Decode_data(0);
	end process;
end logic;

			