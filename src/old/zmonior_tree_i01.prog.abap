*-------------------------------------------------------------------
***INCLUDE column_tree_control_demoI01 .
*-------------------------------------------------------------------
*&---------------------------------------------------------------------*
*&      Module  PAI_0400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_100 INPUT.

  CLEAR ok_code.
  ok_code = sy-ucomm.
  CASE ok_code.
    WHEN 'EXIT' OR 'BACK' .
      PERFORM exit_program.
    WHEN 'BACK1'.
      CALL METHOD tree1->free.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
      CALL METHOD cl_gui_cfw=>dispatch.
  ENDCASE.
  CLEAR ok_code.
  CALL METHOD cl_gui_cfw=>flush.
ENDMODULE.                 " PAI_0100  INPUT
*** INCLUDE column_tree_control_demoI01
