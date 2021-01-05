--------------------------------------------------------------------------------
-- Title      : 4-way n-bit mux 
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : muxn4way.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2021-01-04
-- Design     : muxn4way
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: Implementation of a 4-way n-bit mux. Width of mux inputs are 
--              defined using a generic.
--              GENERIC:
--                      width_g : bit width of mux inputs/outputs
--              INPUTS:
--                      a_in  : n-bit input 0 of 4-way mux gate
--                      b_in  : n-bit input 1 of 4-way mux gate
--                      c_in  : n-bit input 2 of 4-way mux gate
--                      d_in  : n-bit input 3 of 4-way mux gate
--                      s_in  : 2-bit selector signal
--              OUTPUTS:
--                      a_out : n-bit output of mux
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-01-04  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY muxn4way IS
  GENERIC (
            width_g : INTEGER RANGE 64 DOWNTO 0 := 8
          );
  PORT (
         a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
         b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
         c_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
         d_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
         s_in  : IN STD_LOGIC_VECTOR (2 - 1 DOWNTO 0);

         a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
       );
END muxn4way;

--------------------------------------------------------------------------------

ARCHITECTURE behavioural OF muxn4way IS
BEGIN 

  mux : PROCESS (a_in, b_in, c_in, d_in, s_in) IS 
  BEGIN

    mux_select : CASE (to_integer(unsigned(s_in))) IS

      WHEN 0      => a_out <= a_in;
      WHEN 1      => a_out <= b_in;
      WHEN 2      => a_out <= c_in;
      WHEN 3      => a_out <= d_in;
      WHEN OTHERS => a_out <= a_in; -- default to setting switch to "00"

    END CASE mux_select;

  END PROCESS mux;
END ARCHITECTURE behavioural;