--------------------------------------------------------------------------------
-- Title      : n-bit and gate built from nand gates
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : andn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-27
-- Design     : andn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of an n-bit and gate. The number of bits to be 
--              'anded' is determined using the generic width_g
--              GENERICS:
--                      width_g : integer defining the number of bits
--              INPUTS:
--                      a_in  : n-bit input of and gates
--                      b_in  : n-bit input of and gates
--              OUTPUTS:
--                      a_out : n-bit output of and gates
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-27  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY andn IS
  GENERIC (
            width_g : INTEGER := 16
          );
  PORT (
          a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
          b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);

          a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
       );
END andn;

--------------------------------------------------------------------------------

ARCHITECTURE structural OF andn IS

  COMPONENT and1 IS 
   PORT (
          a_in  : IN STD_LOGIC;
          b_in  : IN STD_LOGIC;
       
          a_out : OUT STD_LOGIC
        );
  END COMPONENT and1;

BEGIN
  -- generate component instances using width generic
  generate_ands  : FOR i IN width_g - 1 DOWNTO 0 GENERATE
    i_and1_n : and1
    PORT MAP (
               a_in  => a_in(i),
               b_in  => b_in(i),
               a_out => a_out(i)
             );
  END GENERATE generate_ands;

END ARCHITECTURE structural;

