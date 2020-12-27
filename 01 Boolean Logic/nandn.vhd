--------------------------------------------------------------------------------
-- Title      : n-bit nand gate (gate level description)
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : nand1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : nand1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a 1-bit nand gate. This is to be the primitive
--              block that is used within the remaining implementations through-
--              out the project.
--              INPUTS:
--                      a_in  : 1-bit input of nand gate
--                      b_in  : 1-bit input of nand gate
--              OUTPUTS:
--                      a_out : 1-bit output of nand gate
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY nand1 IS 
  PORT (
          a_in  : IN STD_LOGIC;
          b_in  : IN STD_LOGIC;

          a_out : OUT STD_LOGIC
       );
END nand1;

--------------------------------------------------------------------------------

ARCHITECTURE dataflow OF nand1 IS
BEGIN

  a_out <= a_in NAND b_in;

END ARCHITECTURE dataflow;

