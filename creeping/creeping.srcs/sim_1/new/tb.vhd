library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
component decoder is
Port (input0 : in STD_LOGIC_VECTOR (3 downto 0);
    input1 : in STD_LOGIC_VECTOR (3 downto 0);
    input2 : in STD_LOGIC_VECTOR (3 downto 0);
        input3 : in STD_LOGIC_VECTOR (3 downto 0);
        reset : in STD_LOGIC;
                   clock_100MHz : in STD_LOGIC;
                   AN : out STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (6 downto 0));
end component;
signal input0_tb, input1_tb,input2_tb,input3_tb : std_logic_vector(3 downto 0);
signal reset_tb: std_logic;
signal clock_tb : std_logic;
signal output_tb : std_logic_vector(6 downto 0);
signal AN_tb : std_logic_vector(7 downto 0);
begin
UUT: decoder port map(input0 =>input0_tb,input1 =>input1_tb,input2 =>input2_tb,
input3 =>input3_tb, reset=>reset_tb, clock_100MHz=>clock_tb, output => output_tb, AN=>AN_tb);
clock_process : process
begin
clock_tb <= '0';
wait for 5 ns;
clock_tb <= '1';
wait for 5 ns;
end process;

switchpr: process
begin
input0_tb <="0000"; --0
input1_tb <="0001"; --1
input2_tb<="0010"; --2
input3_tb <="0011"; --3
wait for  50ms;
end process;

reset_proc: process
begin
reset_tb <= '1';
wait for 10 ns;
reset_tb <= '0';
wait for 10 ns;
wait;
end process;
end Behavioral;
