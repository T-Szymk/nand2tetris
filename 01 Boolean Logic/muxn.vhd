--------------------------------------------------------------------------------
-- Title      : n-bit mux 
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : muxn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2021-01-02
-- Design     : muxn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a n-bit mux. Width of mux inputs are defined 
--              within by a generic.
--              GENERIC:
--                      width_g : bit width of mux inputs/outputs
--              INPUTS:
--                      a_in  : n-bit input 0 of mux gate
--                      b_in  : n-bit input 1 of mux gate
--                      s_in  : 1-bit selector signal
--              OUTPUTS:
--                      a_out : n-bit output of mux
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-01-02  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY muxn IS
  GENERIC (
            width_g : INTEGER RANGE 64 DOWNTO 0 := 8
          );
  PORT (
         a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
         b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
         s_in  : IN STD_LOGIC;

         a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
       );
END muxn;

--------------------------------------------------------------------------------

ARCHITECTURE behavioural OF muxn IS
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