
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity creeping_line_3 is
    Port ( rst : in STD_LOGIC;
           clk_100MHz : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (6 downto 0));
end creeping_line_3;

architecture Behavioral of creeping_line_3 is


signal input : std_logic_vector(3 downto 0);
signal Y: std_logic_vector(2 downto 0);
signal clk250Hz: std_logic; -- clock for counter
signal clk_1Hz: std_logic; --clock for register
signal counter: integer range 0 to 40000000; 
signal cntr_for_reg_clk: integer range 0 to 99999999; 
signal circulr_shft_reg : std_logic_vector(0 to 31) := "00000000000000101101000100100011";


begin       

cntr_clk_divider:process (clk_100MHz)
begin
   if clk_100MHz'event and clk_100MHz = '1' then 
      if counter < 40000 then 
         counter <= counter + 1;
         clk250Hz <= '0';
      else
         counter <= 0;
         clk250Hz <= '1';
      end if;
   end if;
end process;


regstr_clk_divider:process (clk_100MHz)
begin
   if clk_100MHz'event and clk_100MHz = '1' then 
      if cntr_for_reg_clk < 99999999 then 
         cntr_for_reg_clk <= cntr_for_reg_clk + 1;
         clk_1Hz <= '0';
      else
         cntr_for_reg_clk <= 0;
         clk_1Hz <= '1';
      end if;
   end if;
end process;


Circlr_shift_reg: process(clk_100MHz)
begin
 if clk_100MHz'event and clk_100MHz = '1' then 
    if clk_1Hz = '1' then     
          circulr_shft_reg(4 to 31) <= circulr_shft_reg(0 to 27); 
          circulr_shft_reg(0 to 3) <= circulr_shft_reg(28 to 31);
    end if;
 end if;
end process;


Cnt: process (clk_100MHz)
 begin
    if clk_100MHz'event and clk_100MHz = '1' then
      if rst = '1' then
        Y <= "000";
      elsif clk250Hz = '1' then     
        Y <= std_logic_vector(unsigned(Y) + 1);
       end if;
    end if;
end process;


with Y select
input <= circulr_shft_reg(0 to 3)     when "000", --  1
         circulr_shft_reg(4 to 7)     when "001", --  2
         circulr_shft_reg(8 to 11)    when "010", --  3
         circulr_shft_reg(12 to 15)   when "011", --  4
         circulr_shft_reg(16 to 19)   when "100", --  5
         circulr_shft_reg(20 to 23)   when "101", --  6
         circulr_shft_reg(24 to 27)   when "110", --  7
         circulr_shft_reg(28 to 31)   when "111", --  8
        "0000" when others; --default


with Y  select

AN<="11111110" when "000", -- 1
    "11111101" when "001", -- 2
    "11111011" when "010", -- 3
    "11110111" when "011", -- 4
    "11101111" when "100", -- 1
    "11011111" when "101", -- 2
    "10111111" when "110", -- 3
    "01111111" when "111", -- 4
    "11111111" when others; --default

-- 7-SEG Decoder
with input
select
output<="0000001" when "0000", --0
        "1001111" when "0001",--1
        "0010010" when "0010",--2
        "0000110" when "0011",--3
        "1001100" when "0100",--4
        "0100100" when "0101",--5
        "0100000" when "0110",--6
        "0001111" when "0111",--7
        "0000000" when "1000",--8
        "0000100" when "1001",--9
        "0001000" when "1010",--a
        "1100000" when "1011",--b
        "0110001" when "1100",--c
        "1000010" when "1101",--d
        "0110000" when "1110",--e
        "0111000" when "1111",--f
        "1111111" when others; --default

end Behavioral;
