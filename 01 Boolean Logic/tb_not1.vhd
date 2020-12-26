--------------------------------------------------------------------------------
-- Title      : testbench for 1-bit not gate
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_not1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : tb_not1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a 1-bit not gate.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_not1 IS 
END tb_not1;

----------------------------------------------------------------------------

ARCHITECTURE tb OF tb_not1 IS

  COMPONENT not1
    PORT(
          a_in  : IN STD_LOGIC;

          a_out : OUT STD_LOGIC
        );
  END COMPONENT not1;

  SIGNAL a_in  : STD_LOGIC := '0';
  SIGNAL a_out : STD_LOGIC := '0';

BEGIN

  i_not_0 : not1 -- instantiate not gate
    PORT MAP (
               a_in  => a_in,
               a_out => a_out
             ); 

  -- start test
  test : PROCESS IS 
  BEGIN 
    
    WAIT FOR 10 NS;
    ASSERT a_out = '1'
      REPORT "expected output of 1 not met with input 0"
      SEVERITY FAILURE;
  
    a_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '0'
      REPORT "expected output of 1 not met with input [1 0]"
      SEVERITY FAILURE;

    ASSERT FALSE
      REPORT "Simulation successful!"
      SEVERITY FAILURE;

  END PROCESS test;
END ARCHITECTURE tb;