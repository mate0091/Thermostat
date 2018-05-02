library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity selector is
	 port(
		 clk : in STD_LOGIC;
		 mode : in STD_LOGIC;
		 set : in STD_LOGIC;
		 disp_prog : in STD_LOGIC_VECTOR(15 downto 0);
		 disp_h_m : in STD_LOGIC_VECTOR(15 downto 0);
		 disp_temp : in STD_LOGIC_VECTOR(15 downto 0);
		 s0 : out STD_LOGIC;
		 s1 : out STD_LOGIC;
		 disp : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end selector;

--}} End of automatically maintained section

architecture logic of selector is
begin
	process(clk)
	variable intMode: integer range 0 to 3 := 0;
	begin
		if clk'EVENT and clk = '1' then
			if mode = '1' then
				intMode := intMode + 1;
				
				if intMode = 3 then
					intMode := 0;
				end if;
			end if;
		end if;
		
		case intMode is
			when 0 => disp <= disp_temp;
			s0 <= '0';
			s1 <= '0';
			when 1 => disp <= disp_prog;
			s0 <= set;
			s1 <= '0';
			when 2 => disp <= disp_h_m;
			s0 <= '0';
			s1 <= set;
			when others => null;
		end case;
	end process;
end logic;
