--------------------------------------------------------------------------------
-- Title      : n-bit not gate built from nand gates
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : notn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-28
-- Design     : notn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of an n-bit not gate. The number of bits to be 
--              'inverted' is determined using the generic width_g
--              GENERICS:
--                      width_g : integer defining the number of bits
--              INPUTS:
--                      a_in  : n-bit input of not gates
--                      b_in  : n-bit input of not gates
--              OUTPUTS:
--                      a_out : n-bit output of not gates
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY notn IS
  GENERIC (
            width_g : INTEGER := 16
          );
  PORT (
          a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);

          a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
       );
END notn;

--------------------------------------------------------------------------------

ARCHITECTURE structural OF notn IS

  COMPONENT not1 IS 
   PORT (
          a_in  : IN STD_LOGIC;
       
          a_out : OUT STD_LOGIC
        );
  END COMPONENT not1;

BEGIN
  -- generate component instances using width generic
  generate_nots  : FOR i IN width_g - 1 DOWNTO 0 GENERATE
    i_notn_n : not1
    PORT MAP (
               a_in  => a_in(i),
               a_out => a_out(i)
             );
  END GENERATE generate_nots;

END ARCHITECTURE structural;

