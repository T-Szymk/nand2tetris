--------------------------------------------------------------------------------
-- Title      : testbench for m-bit nand
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_nandn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-27
-- Design     : tb_nandn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a n-bit nand.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_andnway IS
  GENERIC (
            exponent_g : INTEGER := 5
          );
END tb_andnway;

--------------------------------------------------------------------------------

ARCHITECTURE tb OF tb_andnway IS
  
  -- define components for use in tb
  COMPONENT andnway IS
    GENERIC (
              exponent_g : INTEGER
            );
    PORT (
            a_in  : IN STD_LOGIC_VECTOR (2**exponent_g - 1 DOWNTO 0);
  
            a_out : OUT STD_LOGIC
         );
  END COMPONENT andnway; 
  
  -- array containing widths of each component instance within the tb
  SIGNAL a_in  : UNSIGNED((2**exponent_g) - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a_out : STD_LOGIC := 0;
  SIGNAL rst_n : STD_LOGIC := '0';  

BEGIN -- architecture

    i_nan_0 : nandn
      GENERIC MAP (
                    exponent_g => exponent_g
                  )
      PORT MAP (
                 a_in  => STD_LOGIC_VECTOR(a_in),
                 a_out => a_out
               );

  test : PROCESS IS -- process to run through testing logic

  BEGIN -- test process
  
    IF (rst_n = '0') THEN -- initialise test vectors

        a_in   <= (OTHERS => '0');
        a_out  <= '0';

      WAIT FOR 1 NS;
      rst_n <= '1';
      WAIT FOR 1 NS;

    ELSE
      
      ASSERT a_out = '0'
        REPORT "Initial value of 0 is not 0!"
        SEVERITY FAILURE;

      FOR i IN (2**exponent_g) - 2 DOWNTO 0 LOOP
       --increment value of a_in until == (2**exponent) - 1
      END LOOP;

    
      ASSERT FALSE -- end test
        REPORT "Simulation successful!."
        SEVERITY FAILURE;

    END IF;
  END PROCESS test;
END ARCHITECTURE tb;