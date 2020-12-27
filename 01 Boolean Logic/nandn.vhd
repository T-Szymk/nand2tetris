--------------------------------------------------------------------------------
-- Title      : n-bit nand gate (gate level description)
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : nandn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : nandn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of an n-bit nand gate. The number of bits to be 
--              'nanded' is determined using the generic width_g
--              GENERICS:
--                      width_g : integer defining the number of bits
--              INPUTS:
--                      a_in  : n-bit input of nand gates
--                      b_in  : n-bit input of nand gates
--              OUTPUTS:
--                      a_out : n-bit output of nand gates
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY nandn IS
  GENERIC (
            width_g : INTEGER := 16
          );
  PORT (
          a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
          b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);

          a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
       );
END nandn;

--------------------------------------------------------------------------------

ARCHITECTURE dataflow OF nandn IS

  COMPONENT nand1 IS 
   PORT (
          a_in  : IN STD_LOGIC;
          b_in  : IN STD_LOGIC;
       
          a_out : OUT STD_LOGIC
        );
  END COMPONENT nand1;

BEGIN
  -- generate component instances using width generic
  generate_nands  : FOR i IN width_g - 1 DOWNTO 0 GENERATE
    i_nand1_n : nand1
    PORT MAP (
               a_in  => a_in(i),
               b_in  => b_in(i),
               a_out => a_out(i)
             );
  END GENERATE generate_nands;

END ARCHITECTURE dataflow;

