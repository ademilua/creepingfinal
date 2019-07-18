----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2018 17:48:55
-- Design Name: 
-- Module Name: decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
Port (input0 : in STD_LOGIC_VECTOR (3 downto 0);
    input1 : in STD_LOGIC_VECTOR (3 downto 0);
    input2 : in STD_LOGIC_VECTOR (3 downto 0);
        input3 : in STD_LOGIC_VECTOR (3 downto 0);
        reset : in STD_LOGIC;
                   clock_100MHz : in STD_LOGIC;
                   AN : out STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (6 downto 0));
end decoder;

architecture Behavioral of decoder is
signal input : std_logic_vector(3 downto 0);
signal Q: std_logic_vector(1 downto 0);
signal clock_250Hz: std_logic;
signal counter: integer range 0 to 400000; 
signal tmp :  std_logic;

begin

clock_divider:process (clock_100MHz)
begin
   if clock_100MHz'event and clock_100MHz = '1' then 
      if counter < 40000 then 
         counter <= counter + 1;
         clock_250Hz <= '0';
      else
         counter <= 0;
         clock_250Hz <= '1';
      end if;
   end if;
end process;

---- counter 
Counting: process (clock_100MHz)
 begin
    if clock_100MHz'event and clock_100MHz = '1' then
      if reset = '1' then
        Q <= "00";
      elsif clock_250Hz = '1' then     
        Q <= std_logic_vector(unsigned(Q) + 1);
       end if;
    end if;
end process;

with Q select
input <= input0 when "00", -- for input digit 1
         input1 when "01", -- for input digit 2
         input2 when "10", -- for input digit 3
         input3 when "11", -- for input digit 4
         input when others; --default


with Q  select
AN<="11111110" when "00", -- 1 digit 
    "11111101" when "01", --2 digit 
    "11111011" when "10", --3 digit 
    "11110111" when "11", --4 digit 
    "11111111" when others; --default

with input 
select
output<="0000001" when "0000", --0 
        "1001111" when "0001",--1
        "0010010" when "0010",--2
        "0000110" when "0011",--3
        "1001100" when "0100",--4
        "0100100" when "0101",--5
        "0100000" when "0110",--6 --
        "0001111" when "0111",--7
        "0000000" when "1000",--8
        "0000100" when "1001",--9
        "0001000" when "1010",--a
        "1100000" when "1011",--b
        "0110001" when "1100",--c
        "1000010" when "1101",--d
       "0110000" when "1110",--e -- 
        "0111000" when "1111",--f
        "1111111" when others; --default
        end Behavioral;




