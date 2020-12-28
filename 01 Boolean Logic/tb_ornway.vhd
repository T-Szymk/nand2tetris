--------------------------------------------------------------------------------
-- Title      : testbench for n-way or
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_ornway.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-28
-- Design     : tb_ornway
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a m-way or.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_ornway IS
  GENERIC (
            exponent_g : INTEGER := 4
          );
END tb_ornway;

--------------------------------------------------------------------------------

ARCHITECTURE tb OF tb_ornway IS
  
  -- define components for use in tb
  COMPONENT ornway IS
    GENERIC (
              exponent_g : INTEGER
            );
    PORT (
            a_in  : IN STD_LOGIC_VECTOR (2**exponent_g - 1 DOWNTO 0);
  
            a_out : OUT STD_LOGIC
         );
  END COMPONENT ornway; 
  
  -- array containing widths of each component instance within the tb
  SIGNAL a_in  : UNSIGNED((2**exponent_g) - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL a_out : STD_LOGIC;
  SIGNAL rst_n : STD_LOGIC := '0';  

BEGIN -- architecture

    i_orn_0 : ornway
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

      WAIT FOR 1 NS;
      rst_n <= '1';
      WAIT FOR 1 NS;

    ELSE
      
      ASSERT a_out = '0'
        REPORT "Initial value of 0 is not 0!"
        SEVERITY FAILURE;

      -- for each possible combination, check the output is correct
      -- output should be 1 if any input bits are set
      FOR i IN (2**(2**exponent_g)) - 2 DOWNTO 0 LOOP
        
        a_in <= a_in + 1;
        WAIT FOR 1 NS; -- wait to allow signal update

        IF a_in /= 0 THEN -- assert correct values
          ASSERT a_out = '1'
            REPORT "a_out does not equal 1 when expected!"
            SEVERITY FAILURE;

        ELSE
          ASSERT a_out = '0'
            REPORT "a_out does not equal 0 when expected!"
            SEVERITY FAILURE;
        END IF;
      END LOOP;

    
      ASSERT FALSE -- end test
        REPORT "Simulation successful!."
        SEVERITY FAILURE;

    END IF;
  END PROCESS test;
END ARCHITECTURE tb;