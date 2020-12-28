--------------------------------------------------------------------------------
-- Title      : n-bit or gate built from nand gates
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : orn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-28
-- Design     : orn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of an n-bit or gate. The number of bits to be 
--              'or'd' is determined using the generic width_g
--              GENERICS:
--                      width_g : integer defining the number of bits
--              INPUTS:
--                      a_in  : n-bit input of or gates
--                      b_in  : n-bit input of or gates
--              OUTPUTS:
--                      a_out : n-bit output of or gates
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY orn IS
  GENERIC (
            width_g : INTEGER := 16
          );
  PORT (
          a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
          b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);

          a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
       );
END orn;

--------------------------------------------------------------------------------

ARCHITECTURE structural OF orn IS

  COMPONENT or1 IS 
   PORT (
          a_in  : IN STD_LOGIC;
          b_in  : IN STD_LOGIC;
       
          a_out : OUT STD_LOGIC
        );
  END COMPONENT or1;

BEGIN
  -- generate component instances using width generic
  generate_ors  : FOR i IN width_g - 1 DOWNTO 0 GENERATE
    i_or1_n : or1
    PORT MAP (
               a_in  => a_in(i),
               b_in  => b_in(i),
               a_out => a_out(i)
             );
  END GENERATE generate_ors;

END ARCHITECTURE structural;

