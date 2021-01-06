--------------------------------------------------------------------------------
-- Title      : testbench for 4-way n-bit mux
-- Project    : NAND2TETRIS
--------------------------------------------------------------------------------
-- File       : tb_muxn4way.vhd
-- Author(s)  : T. Szymkowiak
-- Company    : TUNI
-- Created    : 2021-01-04
-- Design     : tb_muxn4way
-- Platform   : -
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: testbench for a 4-way n-bit mux.
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-01-04  1.0      TZS     Created
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_muxn4way IS
  GENERIC (
           tc_count : INTEGER := 4
          );
END tb_muxn4way;

--------------------------------------------------------------------------------

ARCHITECTURE tb OF tb_muxn4way IS

  CONSTANT width_c : INTEGER := 4;

  TYPE InputArray IS ARRAY ((tc_count * 4) - 1 DOWNTO 0) OF INTEGER;
  TYPE OutputArray IS ARRAY (tc_count - 1 DOWNTO 0) OF INTEGER;

  SIGNAL input_vals  : InputArray  := (OTHERS => 0);
  SIGNAL output_vals : OutputArray := (OTHERS => 0);
  SIGNAL s_in        : STD_LOGIC_VECTOR (2 - 1 DOWNTO 0) := (OTHERS => '0'); 

  COMPONENT muxn4way
    GENERIC (
              width_g : INTEGER RANGE 64 DOWNTO 0
            );
    PORT (
           a_in  : IN STD_LOGIC_VECTOR(width_g - 1 DOWNTO 0);
           b_in  : IN STD_LOGIC_VECTOR(width_g - 1 DOWNTO 0);
           c_in  : IN STD_LOGIC_VECTOR(width_g - 1 DOWNTO 0);
           d_in  : IN STD_LOGIC_VECTOR(width_g - 1 DOWNTO 0);
           s_in  : IN STD_LOGIC_VECTOR(2 - 1 DOWNTO 0);
 
           a_out : OUT STD_LOGIC_VECTOR(width_g - 1 DOWNTO 0)
         );
  END COMPONENT muxn4way;

  PROCEDURE check_result (VARIABLE tc : IN INTEGER) IS
  BEGIN
    
    FOR element IN tc_count - 1 DOWNTO 0 LOOP

      ASSERT input_vals((element * 4) + tc) = output_vals(element)
        REPORT "Output value does not match the expected input value"
        SEVERITY FAILURE;

    END LOOP;

  END PROCEDURE check_result;

  BEGIN -- tb

  generate_muxs : FOR id IN tc_count - 1 DOWNTO 0 GENERATE
    i_mux_0 : muxn4way -- instantiate 4-way n-bit mux
      GENERIC MAP (
                    width_g => 2**id
                  )
      PORT MAP (
                 a_in  => STD_LOGIC_VECTOR(TO_UNSIGNED(input_vals(id + 0), 2**id)),
                 b_in  => STD_LOGIC_VECTOR(TO_UNSIGNED(input_vals(id + 1), 2**id)),
                 c_in  => STD_LOGIC_VECTOR(TO_UNSIGNED(input_vals(id + 2), 2**id)),
                 d_in  => STD_LOGIC_VECTOR(TO_UNSIGNED(input_vals(id + 3), 2**id)),
                 s_in  => s_in,

                 UNSIGNED(a_out) => TO_UNSIGNED(output_vals(id), 2**id)
               ); 
  END GENERATE generate_muxs;

  -- start test
  test : PROCESS IS 
  BEGIN 
    
    WAIT FOR 10 NS;
    
    init_loop : FOR element IN (tc_count * 4) - 1 DOWNTO 0 LOOP -- loop to initialise inputs

      input_vals(element) <= element + 1;

    END LOOP init_loop;

    WAIT FOR 10 NS;

    check_result(0);

    count_loop : FOR element IN 1 TO 4 LOOP -- loop to increment switch
      
      s_in <= std_logic_vector(unsigned(element, 2));
      
      WAIT FOR 10 NS;

      check_result(element);

    END LOOP count_loop;
    
    ASSERT FALSE
      REPORT "Simulation successful!"
      SEVERITY FAILURE;

  END PROCESS test;
END ARCHITECTURE tb;