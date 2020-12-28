--------------------------------------------------------------------------------
-- Title      : testbench for 1-bit demux
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_mux.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-28
-- Design     : tb_demux1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a 1-bit demux.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_demux1 IS 
END tb_demux1;

----------------------------------------------------------------------------

ARCHITECTURE tb OF tb_demux1 IS

  COMPONENT demux1
    PORT (
           a_in  : IN STD_LOGIC;
           s_in  : IN STD_LOGIC;
 
           a_out : OUT STD_LOGIC;
           b_out : OUT STD_LOGIC
         );
  END COMPONENT demux1;

  SIGNAL a_in  : STD_LOGIC := '0';
  SIGNAL s_in  : STD_LOGIC := '0';
  SIGNAL a_out : STD_LOGIC := '0';
  SIGNAL b_out : STD_LOGIC := '0';

BEGIN

  i_demux1_0 : demux1 -- instantiate nand gate
    PORT MAP (
               a_in  => a_in,
               s_in  => s_in,
               a_out => a_out,
               b_out => b_out
             ); 

  -- start test
  test : PROCESS IS 
  BEGIN 
    
    WAIT FOR 10 NS;
    ASSERT a_out = '0' AND b_out = '0'
      REPORT "expected out = 0, 0 when, s = 0, a = 0"
      SEVERITY FAILURE;
  
    a_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '1' AND b_out = '0'
      REPORT "expected out = 1, 0 when, s = 0, a = 1"
      SEVERITY FAILURE;
    
    s_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = '0' AND b_out = '1'
      REPORT "expected out = 0, 1 when, s = 1, a = 1"
      SEVERITY FAILURE;
    
    a_in <= '0';
    WAIT FOR 10 NS;
    ASSERT a_out = '0' AND b_out = '0' 
      REPORT "expected out = 0, 0 when, s = 1, a = 0"
      SEVERITY FAILURE;

    ASSERT FALSE
      REPORT "Simulation successful!"
      SEVERITY FAILURE;

  END PROCESS test;
END ARCHITECTURE tb;