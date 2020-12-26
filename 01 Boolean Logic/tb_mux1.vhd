--------------------------------------------------------------------------------
-- Title      : testbench for 1-bit mux
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_mux.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : tb_mux1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a 1-bit mux.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_mux1 IS 
END tb_mux1;

----------------------------------------------------------------------------

ARCHITECTURE tb OF tb_mux1 IS

  COMPONENT mux1
    PORT (
           a_in  : IN STD_LOGIC;
           b_in  : IN STD_LOGIC;
           s_in  : IN STD_LOGIC;
 
           a_out : OUT STD_LOGIC
         );
  END COMPONENT mux1;

  SIGNAL a_in  : STD_LOGIC := '0';
  SIGNAL b_in  : STD_LOGIC := '0';
  SIGNAL s_in  : STD_LOGIC := '0';
  SIGNAL a_out : STD_LOGIC := '0';

BEGIN

  i_mux1_0 : mux1 -- instantiate nand gate
    PORT MAP (
               a_in  => a_in,
               b_in  => b_in,
               s_in  => s_in,
               a_out => a_out
             ); 

  -- start test
  test : PROCESS IS 
  BEGIN 
    
    WAIT FOR 10 NS;
    ASSERT a_out = '0'
      REPORT "expected out = 0 when, s = 0, a = 0, b = 0"
      SEVERITY FAILURE;
  
    a_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '1'
      REPORT "expected out = 1 when, s = 0, a = 1, b = 0"
      SEVERITY FAILURE;
    
    a_in <= '0';
    s_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '0'
      REPORT "expected out = 0 when, s = 1, a = 0, b = 0"
      SEVERITY FAILURE;
    
    b_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '1'
      REPORT "expected out = 1 when, s = 1, a = 0, b = 1"
      SEVERITY FAILURE;

    ASSERT FALSE
      REPORT "Simulation successful!"
      SEVERITY FAILURE;

  END PROCESS test;
END ARCHITECTURE tb;