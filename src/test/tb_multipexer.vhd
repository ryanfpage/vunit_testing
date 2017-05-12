-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2016, Lars Asplund lars.anders.asplund@gmail.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;



entity tb_multiplexer is
  generic (
    runner_cfg : string);
end entity;

architecture tb of tb_multiplexer is

  signal clk : std_logic := '0';
  signal output_data : std_logic := '0';
  signal input_data : std_logic_vector(3 downto 0) := (others => '0');
  signal sel : std_logic_vector(1 downto 0) := (others => '0');
  signal start, data_check_done, stimuli_done : boolean := false;

begin


  main : process
    
    procedure run_test is
    begin
      wait until rising_edge(clk);
      start <= true;
      wait until rising_edge(clk);
      start <= false;

      wait until (stimuli_done and
                  data_check_done and
                  rising_edge(clk));
    end procedure;


  begin

    test_runner_setup(runner, runner_cfg);
    run_test
    test_runner_cleanup(runner);
    wait;
  end process;

  stimuli_process : process
  begin
    wait until start and rising_edge(clk);
    stimuli_done <= false;

    input_data <= "1101"
    sel <= "01";

    wait until rising_edge(clk);
    
    stimuli_done <= true;
  end process;

  data_check_process : process
  begin
    wait until start and rising_edge(clk);
    data_check_done <= false;
    check_equal(output_data, '0');
    data_check_done <= true;
  end process;

  clk <= not clk after 1 ns;

  dut : entity work.multiplexer  
    port map (
      clk => clk,
      sel => sel,
      input_data => input_data,
      output_data => output_data );

end architecture;
