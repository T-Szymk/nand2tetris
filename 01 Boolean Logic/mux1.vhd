--------------------------------------------------------------------------------
-- Title      : 1-bit mux 
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : mux1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : mux1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a 1-bit mux. 
--              INPUTS:
--                      a_in  : 1-bit input 0 of mux gate
--                      b_in  : 1-bit input 1 of mux gate
--                      s_in  : 1-bit selector signal
--              OUTPUTS:
--                      a_out : 1-bit output of and gate
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux1 IS
  PORT (
         a_in  : IN STD_LOGIC;
         b_in  : IN STD_LOGIC;
         s_in  : IN STD_LOGIC;

         a_out : OUT STD_LOGIC
       );
END mux1;

--------------------------------------------------------------------------------

ARCHITECTURE behavioural OF mux1 IS
BEGIN 

  mux : PROCESS (a_in, b_in, s_in) IS 
  BEGIN

    IF (s_in = '0') THEN

      a_out <= a_in;

    ELSE

      a_out <= b_in;

    END IF;
  END PROCESS mux;
END ARCHITECTURE behavioural;