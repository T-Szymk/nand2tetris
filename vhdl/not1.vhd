--------------------------------------------------------------------------------
-- Title      : 1-bit not gate using nand gates (structural description)
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : not1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : not1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a 1-bit not gate. This is to be constructed
--              from the 1-bit nand gate component as is specified in the 
--              project documentation.
--              INPUTS:
--                      a_in  : 1-bit input of not gate
--              OUTPUTS:
--                      a_out : 1-bit output of not gate
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY not1 IS
  PORT (
         a_in  : IN STD_LOGIC;

         a_out : OUT STD_LOGIC
       );
END not1;

--------------------------------------------------------------------------------

ARCHITECTURE struct OF not1 IS

  COMPONENT nand1
    PORT (
           a_in  : IN STD_LOGIC;
           b_in  : IN STD_LOGIC;
       
           a_out : OUT STD_LOGIC
         );
  END COMPONENT nand1; 

BEGIN 
  -- instantiate and gate with inputs tied together to create inverter
  i_nand_0 : nand1
    PORT MAP (
               a_in  => a_in,
               b_in  => a_in,
               a_out => a_out
             );

END ARCHITECTURE struct;