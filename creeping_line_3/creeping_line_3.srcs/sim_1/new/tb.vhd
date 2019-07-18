library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
component creeping_line_3 is
   Port ( rst : in STD_LOGIC;
           clk_100MHz : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (6 downto 0));
end component;
signal rst_tb: std_logic;
signal clk_tb : std_logic;
signal AN_tb : STD_LOGIC_VECTOR (7 downto 0);
signal output_tb : STD_LOGIC_VECTOR (6 downto 0);

begin

UUT:  creeping_line_3 port map( rst=>rst_tb, clk_100MHz=>clk_tb, AN=>AN_tb , output =>output_tb);
clock_process : process
begin
clk_tb <= '1';
wait for 5 ns;
clk_tb <= '0';
wait for 5 ns;
end process;

rest_process : process
begin
rst_tb <= '1';
wait for 1 ns;
rst_tb <= '0';
wait for 100 ms;
wait;
end process;

end behavioral;
