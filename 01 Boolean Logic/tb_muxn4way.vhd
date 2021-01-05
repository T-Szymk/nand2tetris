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

  CONSTANT width_c : INTEGER := 4;

  SIGNAL a_in  : STD_LOGIC_VECTOR (width_c - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL b_in  : STD_LOGIC_VECTOR (width_c - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL c_in  : STD_LOGIC_VECTOR (width_c - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL d_in  : STD_LOGIC_VECTOR (width_c - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a_out : STD_LOGIC_VECTOR (width_c - 1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL s_in  : STD_LOGIC_VECTOR (2 - 1 DOWNTO 0) := (OTHERS => '0'); 

  COMPONENT muxn4way
    GENERIC (
              width_g : INTEGER RANGE 64 DOWNTO 0
            );
    PORT (
           a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
           b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
           c_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
           d_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
           s_in  : IN STD_LOGIC_VECTOR (2 - 1 DOWNTO 0);
 
           a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
         );
  END COMPONENT muxn4way;

  BEGIN -- tb

  i_mux_0 : muxn4way -- instantiate 4-way n-bit mux
    GENERIC MAP (
                  width_g => width_c
                )
    PORT MAP (
               a_in  => a_in,
               b_in  => b_in,
               c_in  => c_in,
               d_in  => d_in,
               s_in  => s_in,

               a_out => a_out
             ); 

  -- start test
  test : PROCESS IS 
  BEGIN 
    
    WAIT FOR 10 NS;
    
    a_in <= X"1";
    b_in <= X"2";
    c_in <= X"3";
    d_in <= X"4";

    WAIT FOR 10 NS;

    ASSERT a_out = X"1"
      REPORT "a_out not equal to 1 when s = 0!"
      SEVERITY FAILURE;

    s_in <= "01";

    WAIT FOR 10 NS;

    ASSERT a_out = X"2"
      REPORT "a_out not equal to 2 when s = 1!"
      SEVERITY FAILURE;

    s_in <= "10";

    WAIT FOR 10 NS;

    ASSERT a_out = X"3"
      REPORT "a_out not equal to 3 when s = 2!"
      SEVERITY FAILURE;

    s_in <= "11";

    WAIT FOR 10 NS;

    ASSERT a_out = X"4"
      REPORT "a_out not equal to 4 when s = 3!"
      SEVERITY FAILURE;

    ASSERT FALSE
      REPORT "Simulation successful!"
      SEVERITY FAILURE;

  END PROCESS test;
END ARCHITECTURE tb;