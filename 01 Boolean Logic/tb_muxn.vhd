--------------------------------------------------------------------------------
-- Title      : testbench for n-bit mux
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_muxn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2021-01-02
-- Design     : tb_muxn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a n-bit mux.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-01-02  1.0      TZS     Created
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_muxn IS
  GENERIC (
            width_g_tb : INTEGER RANGE 64 DOWNTO 0 := 8
          );
END tb_muxn;

--------------------------------------------------------------------------------

ARCHITECTURE tb OF tb_muxn IS

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

  SIGNAL a_in    : STD_LOGIC_VECTOR (width_g_tb - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL b_in    : STD_LOGIC_VECTOR (width_g_tb - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL s_in    : STD_LOGIC := '0'; 
  SIGNAL a_out   : STD_LOGIC_VECTOR (width_g_tb - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL zeros_n : STD_LOGIC_VECTOR (width_g_tb - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL ones_n  : STD_LOGIC_VECTOR (width_g_tb - 1 DOWNTO 0) := (OTHERS => '1');

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