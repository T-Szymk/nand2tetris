--------------------------------------------------------------------------------
-- Title      : testbench for n-bit nand
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_mux.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2020-12-26
-- Design     : tb_mux1
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench of a 1-bit mux.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-26  1.0      TZS     Created
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_nandn IS
  GENERIC (
            test_case_count_g : INTEGER := 5;
            max_width_g       : INTEGER := 64
          );
END tb_nandn;

--------------------------------------------------------------------------------

ARCHITECTURE tb OF tb_nandn IS

  COMPONENT nandn IS
    GENERIC (
              width_g : INTEGER
            );
    PORT (
            a_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
            b_in  : IN STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0);
  
            a_out : OUT STD_LOGIC_VECTOR (width_g - 1 DOWNTO 0)
         );
  END COMPONENT nandn;
  
  TYPE WidthArray IS ARRAY(test_case_count_g - 1 DOWNTO 0) OF 
                                     INTEGER RANGE max_width_g - 1 DOWNTO 0;
  TYPE ValArray IS ARRAY(test_case_count_g - 1 DOWNTO 0) OF 
                            SIGNED(2**(test_case_count_g - 1) - 1 DOWNTO 0); 
  
  SIGNAL width_vals                       : WidthArray := (OTHERS => 0);
  SIGNAL rst_n                            : STD_LOGIC := '0';
  SIGNAL a_in_vals, b_in_vals, a_out_vals : ValArray;

BEGIN 

  generate_duv : FOR i IN test_case_count_g - 1 DOWNTO 0 GENERATE

    i_nan_0 : nandn
      GENERIC MAP (
                    width_g => 2**i
                  )
      PORT MAP (
                 a_in => STD_LOGIC_VECTOR(a_in_vals(i)((2**i) - 1 DOWNTO 0)),
                 b_in => STD_LOGIC_VECTOR(b_in_vals(i)((2**i) - 1 DOWNTO 0)),
                 SIGNED(a_out) => a_out_vals(i)((2**i) - 1 DOWNTO 0)
               );

  END GENERATE generate_duv;

  test : PROCESS IS
  BEGIN

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

      FOR i IN test_case_count_g - 1 DOWNTO 0 LOOP -- iterate through elements of val array
        FOR j IN (2**width_vals(i)) - 2 DOWNTO 0 LOOP -- loop for number of possible bit combos 2^n - 1

          a_in_vals(i) <= a_in_vals(i) + 1; -- increment element a
          WAIT FOR 1 NS;

          FOR k IN width_vals(i) - 1 DOWNTO 0 LOOP -- verify bitwise NAND
            ASSERT a_out_vals(i)(k) = (a_in_vals(i)(k) NAND b_in_vals(i)(k))
              REPORT "NAND result does not match expected value."
              SEVERITY FAILURE;

          END LOOP;
        END LOOP;
      END LOOP;

      FOR i IN test_case_count_g - 1 DOWNTO 0 LOOP -- iterate through elements of val array
        FOR j IN (2**width_vals(i)) - 2 DOWNTO 0 LOOP -- loop for number of possible bit combos 2^n - 1
          
          b_in_vals(i) <= b_in_vals(i) + 1; -- increment element b
          WAIT FOR 1 NS;

          FOR k IN width_vals(i) - 1 DOWNTO 0 LOOP
            ASSERT a_out_vals(i)(k) = (a_in_vals(i)(k) NAND b_in_vals(i)(k))
              REPORT "NAND result does not match expected value."
              SEVERITY FAILURE;
          END LOOP;
        END LOOP;
      END LOOP;
    
      ASSERT FALSE
        REPORT "Simulation successful!."
        SEVERITY FAILURE;
    END IF;
  END PROCESS test;
END ARCHITECTURE tb;