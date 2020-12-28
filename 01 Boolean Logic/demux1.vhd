--------------------------------------------------------------------------------
-- Title      : 1-bit demux 
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : demux1.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-28
-- Design     : demux1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a 1-bit mux. 
--              INPUTS:
--                      a_in  : 1-bit input of mux gate
--                      s_in  : 1-bit selector signal
--              OUTPUTS:
--                      a_out : 1-bit output 0 of and gate
--                      b_out : 1-bit output 1 of and gate
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY demux1 IS
  PORT (
         a_in  : IN STD_LOGIC;
         s_in  : IN STD_LOGIC;

         a_out : OUT STD_LOGIC;
         b_out : OUT STD_LOGIC
       );
END demux1;

--------------------------------------------------------------------------------

ARCHITECTURE behavioural OF demux1 IS
BEGIN 

  demux : PROCESS (a_in, s_in) IS 
  BEGIN

    IF (s_in = '0') THEN

      a_out <= a_in;
      b_out <= '0';

    ELSE

      b_out <= a_in;
      a_out <= '0';

    END IF;
  END PROCESS demux;
END ARCHITECTURE behavioural;