--------------------------------------------------------------------------------
-- Title      : 1-bit xor gate using nand gates (structural description)
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : xor1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : xor1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a 1-bit xor gate. This is to be constructed
--              from the 1-bit nand gate component as is specified in the 
--              project documentation.
--              INPUTS:
--                      a_in  : 1-bit input of xor gate
--                      b_in  : 1-bit input of xor gate
--              OUTPUTS:
--                      a_out : 1-bit output of xor gate
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY xor1 IS
  PORT (
         a_in  : IN STD_LOGIC;
         b_in  : IN STD_LOGIC;

         a_out : OUT STD_LOGIC
       );
END xor1;

--------------------------------------------------------------------------------

ARCHITECTURE struct OF xor1 IS

  COMPONENT and1
    PORT (
           a_in  : IN STD_LOGIC;
           b_in  : IN STD_LOGIC;
       
           a_out : OUT STD_LOGIC
         );
  END COMPONENT and1;

  COMPONENT or1
    PORT (
           a_in  : IN STD_LOGIC;
           b_in  : IN STD_LOGIC;
       
           a_out : OUT STD_LOGIC
         );
  END COMPONENT or1;

  COMPONENT not1
    PORT (
           a_in  : IN STD_LOGIC;
       
           a_out : OUT STD_LOGIC
         );
  END COMPONENT not1;

  -- intermediate signals between components
  SIGNAL a_not_0_and_0 : STD_LOGIC;
  SIGNAL b_not_1_and_1 : STD_LOGIC;
  SIGNAL a_and_0_or_0  : STD_LOGIC;
  SIGNAL a_and_1_or_0  : STD_LOGIC;

BEGIN 

  i_and_0 : and1
    PORT MAP (
               a_in  => a_not_0_and_0,
               b_in  => b_in,
               a_out => a_and_0_or_0
             );

  i_and_1 : and1
  PORT MAP (
             a_in  => a_in,
             b_in  => b_not_1_and_1,
             a_out => a_and_1_or_0
           );
  
  i_or_0 : or1
  PORT MAP (
             a_in  => a_and_0_or_0,
             b_in  => a_and_1_or_0,
             a_out => a_out
           );

  i_not_0 : not1
  PORT MAP (
             a_in  => a_in,
             a_out => a_not_0_and_0
           );

  i_not_1 : not1
  PORT MAP (
             a_in  => b_in,
             a_out => b_not_1_and_1
           );

END ARCHITECTURE struct;