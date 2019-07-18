library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity creeping_1_tb is
--  Port ( );
end creeping_1_tb;

architecture Behavioral of creeping_1_tb is
component creeping_1 is
port ( 
    input : in STD_LOGIC_VECTOR (3 downto 0);
           output : out STD_LOGIC_VECTOR (6 downto 0);
           AN:  out STD_LOGIC_VECTOR (7 downto 0)
   
    );
end component;


signal input_tb: std_logic_vector(3 downto 0);
signal output_tb : std_logic_vector(6 downto 0);
signal AN_tb : std_logic_vector(7 downto 0);


begin
UUT: creeping_1 port map(input =>input_tb, output => output_tb, AN=>AN_tb);

stimuli: process
begin
 
input_tb <="0000"; --0
wait for 20ns;
input_tb <="0001"; --1
wait for 20ns;
input_tb<="0010"; --2
wait for 20ns;
input_tb <="0011";  --3
wait for 20ns;
input_tb <="0100"; --4
wait for 20ns;
input_tb <="0101"; --5
wait for 20ns;
input_tb<="0110"; --6
wait for 20ns;
input_tb <="0111";  --7
wait for 20 ns;
input_tb <="1000"; --8
wait for 20ns;
input_tb <="1001";--9
wait for 20ns;
input_tb<="1010";-- a
wait for 20ns;
input_tb <="1011";--b
wait for 20ns;
input_tb <="1100"; --c
wait for 20ns;
input_tb <="1101"; --d
wait for 20ns;
input_tb<="1110"; --e
wait for 20ns;
input_tb <="1111";--f
wait for 20ns;
wait;
end process;
end Behavioral;