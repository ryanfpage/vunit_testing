-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2016, Lars Asplund lars.anders.asplund@gmail.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplexer is
  
  port (
    signal clk : in std_logic;
    signal sel : in std_logic_vector(1 downto 0);
    signal input_data : in std_logic_vector(3 downto 0);
    signal output_data : out std_logic
    );

end entity;

architecture behaviour of multiplexer is

begin

  selectmux : process(clk)
  
  begin
    if rising_edge(clk) then
      case( sel ) is 
        when "00" => output_data <= input_data(0);
        when "01" => output_data <= input_data(1);
        when "10" => output_data <= input_data(2);
        when "11" => output_data <= input_data(3);
        when others =>  output_data <= '0';
      end case ;
    end if;

  end process;
  
  
  
end architecture;
