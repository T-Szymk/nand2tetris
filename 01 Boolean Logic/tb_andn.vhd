--------------------------------------------------------------------------------
-- Title      : testbench for n-bit and
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_andn.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-28
-- Design     : tb_andn
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a n-bit and.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-28  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_andn IS
  GENERIC (
            test_case_count_g : INTEGER := 5;
            max_width_g       : INTEGER := 64
          );
END tb_andn;

--------------------------------------------------------------------------------

ARCHITECTURE tb OF tb_andn IS
  
  -- define components for use in tb
  COMPONENT andn IS
    GENERIC (
              width_g : INTEGER
            );
    PORT (
            a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
            b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
  
            a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
         );
  END COMPONENT andn;
  
  -- declare required custom types and signals
  TYPE WidthArray IS ARRAY(test_case_count_g - 1 DOWNTO 0) OF 
                                     INTEGER RANGE max_width_g - 1 DOWNTO 0;
  TYPE ValArray IS ARRAY(test_case_count_g - 1 DOWNTO 0) OF 
                          UNSIGNED(2**(test_case_count_g - 1) - 1 DOWNTO 0); 
  
  -- array containing widths of each component instance within the tb
  SIGNAL width_vals                       : WidthArray := (OTHERS => 0);
  SIGNAL rst_n                            : STD_LOGIC := '0';
  -- signals containing inputs and outputs for each component
  SIGNAL a_in_vals, b_in_vals, a_out_vals : ValArray;

BEGIN -- architecture

  -- generate instances of device under verification, number controlled by 
  -- generic 'test_case_count_g'
  generate_duv : FOR i IN test_case_count_g - 1 DOWNTO 0 GENERATE

    i_and_0 : andn
      GENERIC MAP (
                    width_g => 2**i
                  )
      PORT MAP (
                 a_in => STD_LOGIC_VECTOR(a_in_vals(i)((2**i) - 1 DOWNTO 0)),
                 b_in => STD_LOGIC_VECTOR(b_in_vals(i)((2**i) - 1 DOWNTO 0)),
                 UNSIGNED(a_out) => a_out_vals(i)((2**i) - 1 DOWNTO 0)
               );

  END GENERATE generate_duv;

  test : PROCESS IS -- process to run through testing logic
    
  -- procedure for asserting outputs are correct
    PROCEDURE checkVals IS 
    BEGIN
      -- Assert NAND of inputs and outputs is correct
      FOR tc IN test_case_count_g - 1 DOWNTO 0 LOOP
        FOR k IN width_vals(tc) - 1 DOWNTO 0 LOOP

          ASSERT a_out_vals(tc)(k) = (a_in_vals(tc)(k) AND b_in_vals(tc)(k))
            REPORT "NAND result does not match expected value."
            SEVERITY FAILURE;

        END LOOP;
      END LOOP;
    END PROCEDURE checkVals;

    -- procedure used to flip bits within ValArray
    PROCEDURE flipBits (SIGNAL val_array : INOUT ValArray) IS
    BEGIN 

      test_case_loop : FOR tc IN test_case_count_g - 1 DOWNTO 0 LOOP
          
          val_array(tc) <= val_array(tc) + ((2**width_vals(tc)) - 1);
          WAIT FOR 1 NS;

      END LOOP test_case_loop;
    END PROCEDURE flipBits;

  BEGIN -- test process

    ASSERT (width_vals(test_case_count_g - 1) <= max_width_g)
      REPORT "Max width value is exceeded!"
      SEVERITY FAILURE;
  
    IF (rst_n = '0') THEN -- initialise test vectors

      FOR i IN test_case_count_g - 1 DOWNTO 0 LOOP
        width_vals(i) <= 2**i;
        a_in_vals(i)  <= (OTHERS => '0');
        b_in_vals(i)  <= (OTHERS => '0');
      END LOOP;

      WAIT FOR 1 NS;
      rst_n <= '1';
      WAIT FOR 1 NS;

    ELSE
      
      checkVals; -- assert output is correct
      flipBits(a_in_vals); -- flip bits in a
      checkVals; -- assert output is correct

      flipBits(b_in_vals); -- flip bits in b
      checkVals; -- assert output is correct
    
      ASSERT FALSE -- end test
        REPORT "Simulation successful!."
        SEVERITY FAILURE;

    END IF;
  END PROCESS test;
END ARCHITECTURE tb;