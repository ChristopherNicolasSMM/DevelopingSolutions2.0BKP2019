*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_REL_UNCATE_ALV_P01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE okcode.
    WHEN 'BACK'
      OR 'EXIT'
      OR 'CANCEL'.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'REFRESH'.
      PERFORM data_select_0100.
      go_grid->refresh_table_display( ).
  ENDCASE.
  CLEAR okcode.

ENDMODULE.
