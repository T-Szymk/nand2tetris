--------------------------------------------------------------------------------
-- Title      : testbench for 1-bit and gate
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_and1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : tb_and1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a 1-bit and gate.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_and1 IS 
END tb_and1;

----------------------------------------------------------------------------

ARCHITECTURE tb OF tb_and1 IS

  COMPONENT and1
    PORT (
           a_in  : IN STD_LOGIC;
           b_in  : IN STD_LOGIC;
 
           a_out : OUT STD_LOGIC
         );
  END COMPONENT and1;

  SIGNAL a_in  : STD_LOGIC := '0';
  SIGNAL b_in  : STD_LOGIC := '0';
  SIGNAL a_out : STD_LOGIC := '0';

BEGIN

  i_and_0 : and1 -- instantiate nand gate
    PORT MAP (
               a_in  => a_in,
               b_in  => b_in,
               a_out => a_out
             ); 

  -- start test
  test : PROCESS IS 
  BEGIN 
    
    WAIT FOR 10 NS;
    ASSERT a_out = '0'
      REPORT "expected output of 0 not met with input [0 0]"
      SEVERITY FAILURE;
  
    a_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '0'
      REPORT "expected output of 0 not met with input [1 0]"
      SEVERITY FAILURE;
    
    a_in <= '0';
    b_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '0'
      REPORT "expected output of 0 not met with input [0 1]"
      SEVERITY FAILURE;
    
    a_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '1'
      REPORT "expected output of 1 not met with input [1 1]"
      SEVERITY FAILURE;

    ASSERT FALSE
      REPORT "Simulation successful!"
      SEVERITY FAILURE;

  END PROCESS test;
END ARCHITECTURE tb;