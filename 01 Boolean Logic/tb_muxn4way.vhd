--------------------------------------------------------------------------------
-- Title      : testbench for 4-way n-bit mux
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_muxn4way.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2021-01-04
-- Design     : tb_muxn4way
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench for a 4-way n-bit mux.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-01-04  1.0      TZS     Created
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_muxn4way IS
END tb_muxn4way;

--------------------------------------------------------------------------------

ARCHITECTURE tb OF tb_muxn4way IS

  CONSTANT width_1 : INTEGER := 1;
  CONSTANT width_4 : INTEGER := 4;
  CONSTANT width_8 : INTEGER := 8;
  CONSTANT width_s : INTEGER := 2;

  SIGNAL a1_in  : STD_LOGIC_VECTOR (width_1 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL b1_in  : STD_LOGIC_VECTOR (width_1 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL c1_in  : STD_LOGIC_VECTOR (width_1 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL d1_in  : STD_LOGIC_VECTOR (width_1 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a1_out : STD_LOGIC_VECTOR (width_1 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a4_in  : STD_LOGIC_VECTOR (width_4 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL b4_in  : STD_LOGIC_VECTOR (width_4 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL c4_in  : STD_LOGIC_VECTOR (width_4 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL d4_in  : STD_LOGIC_VECTOR (width_4 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a4_out : STD_LOGIC_VECTOR (width_4 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a8_in  : STD_LOGIC_VECTOR (width_8 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL b8_in  : STD_LOGIC_VECTOR (width_8 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL c8_in  : STD_LOGIC_VECTOR (width_8 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL d8_in  : STD_LOGIC_VECTOR (width_8 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a8_out : STD_LOGIC_VECTOR (width_8 - 1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL s_in    : STD_LOGIC_VECTOR (width_s - 1 DOWNTO 0) := '0'; 

  SIGNAL zeros_n : STD_LOGIC_VECTOR (width_g_tb - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL ones_n  : STD_LOGIC_VECTOR (width_g_tb - 1 DOWNTO 0) := (OTHERS => '1');

  COMPONENT muxn
    GENERIC (
              width_g : INTEGER RANGE 64 DOWNTO 0
            );
    PORT (
           a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
           b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
           s_in  : IN STD_LOGIC;
 
           a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
         );
  END COMPONENT muxn;

BEGIN

  i_mux1_0 : muxn -- instantiate nand gate
    GENERIC MAP (
                  width_g => width_g_tb
                )
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
    ASSERT a_out = zeros_n
      REPORT "expected out = zeros when, s = 0, a = zeros, b = zeros"
      SEVERITY FAILURE;
  
    a_in <= (OTHERS => '1');
    WAIT FOR 10 NS;
    ASSERT a_out = ones_n
      REPORT "expected out = ones when, s = 0, a = ones, b = zeros"
      SEVERITY FAILURE;
    
    a_in <= (OTHERS => '0');
    s_in <= '1';
    WAIT FOR 10 NS;
    ASSERT a_out = zeros_n
      REPORT "expected out = zeros when, s = 1, a = zeros, b = zeros"
      SEVERITY FAILURE;
    
    b_in <= (OTHERS => '1');
    WAIT FOR 10 NS;
    ASSERT a_out = ones_n
      REPORT "expected out = ones when, s = 1, a = zeros, b = ones"
      SEVERITY FAILURE;

    ASSERT FALSE
      REPORT "Simulation successful!"
      SEVERITY FAILURE;

  END PROCESS test;
END ARCHITECTURE tb;