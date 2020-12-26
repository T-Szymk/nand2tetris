--------------------------------------------------------------------------------
-- Title      : 1-bit and gate using nand gates (structural description)
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : and1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : and1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a 1-bit and gate. This is to be constructed
--              from the 1-bit nand gate component as is specified in the 
--              project documentation.
--              INPUTS:
--                      a_in  : 1-bit input of and gate
--                      b_in  : 1-bit input of and gate
--              OUTPUTS:
--                      a_out : 1-bit output of and gate
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY and1 IS
  PORT (
         a_in  : IN STD_LOGIC;
         b_in  : IN STD_LOGIC;

         a_out : OUT STD_LOGIC
       );
END and1;

--------------------------------------------------------------------------------

ARCHITECTURE struct OF and1 IS

  COMPONENT nand1
    PORT (
           a_in  : IN STD_LOGIC;
           b_in  : IN STD_LOGIC;
       
           a_out : OUT STD_LOGIC
         );
  END COMPONENT nand1;

  COMPONENT not1
    PORT (
           a_in  : IN STD_LOGIC;
       
           a_out : OUT STD_LOGIC
         );
  END COMPONENT not1;

  -- intermediate signals between components
  SIGNAL a_nand_0_not_0 : STD_LOGIC;

BEGIN 

  i_nand_0 : nand1
    PORT MAP (
               a_in  => a_in,
               b_in  => b_in,
               a_out => a_nand_0_not_0
             );

  i_not_0 : not1
  PORT MAP (
             a_in  => a_nand_0_not_0,
             a_out => a_out
           );

END ARCHITECTURE struct;