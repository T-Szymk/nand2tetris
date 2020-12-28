--------------------------------------------------------------------------------
-- Title      : n-way and gate built from nand gates
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : andnway.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-28
-- Design     : andnway
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of an n-way and gate. The number of bits to be 
--              'anded' is determined using the generic width_c
--              GENERICS:
--                      exponent_g : power of 2 to set gate width to
--              INPUTS:
--                      a_in  : n-bit input of and gates
--              OUTPUTS:
--                      a_out : n-bit output of and gates
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY andnway IS
  GENERIC (
            exponent_g : INTEGER := 1 -- default 8-bit
          );
  PORT (
          a_in  : IN STD_LOGIC_VECTOR (2**exponent_g - 1 DOWNTO 0);

          a_out : OUT STD_LOGIC
       );
END andnway;

--------------------------------------------------------------------------------

ARCHITECTURE structural OF andnway IS

  COMPONENT and1 IS 
   PORT (
          a_in  : IN STD_LOGIC;
          b_in  : IN STD_LOGIC;
       
          a_out : OUT STD_LOGIC
        );
  END COMPONENT and1;
  
  CONSTANT width_c : INTEGER := 2**exponent_g;

  SIGNAL val_arr : STD_LOGIC_VECTOR((width_c - 1) - 1 DOWNTO 0);

BEGIN

  ASSERT exponent_g /= 0
    REPORT "Exponent of n-way gat must be greater than 0!"
    SEVERITY FAILURE;

  i_and1_0 : and1
  PORT MAP (
             a_in  => a_in(width_c - 1),
             b_in  => a_in((width_c - 1) - 1),
             a_out => val_arr((width_c - 1) - 1)
           );

  -- generate component instances using width generic
  -- generic only called if the width is great than 2
  check_size : IF width_c /= 2 GENERATE
    generate_ands  : FOR i IN (width_c - 1) - 2 DOWNTO 0 GENERATE
      i_and1_n : and1
      PORT MAP (
                 a_in  => a_in(i),
                 b_in  => val_arr(i + 1),
                 a_out => val_arr(i)
               );
    END GENERATE generate_ands;
  END GENERATE check_size;

  a_out <= val_arr(0);

END ARCHITECTURE structural;

