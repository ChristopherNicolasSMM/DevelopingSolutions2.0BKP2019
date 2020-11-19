*&---------------------------------------------------------------------*
*&  Include           YDS3P_DEMO_MULT_POOL_I0102
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0102  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0102 INPUT.

  CASE OK_CODE.
    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'GO_FICHA_01'.
      g_tabstrip_0102-pressed_tab = 'TBS_0102'.
      g_tabstrip_0102-subscreen   = '0103'.
    WHEN 'GO_FICHA_02'.
      g_tabstrip_0102-pressed_tab = 'TBS_0102'.
      g_tabstrip_0102-subscreen   = '0104'.
*    WHEN 'GO_FICHA_03'.
*      g_tabstrip_0102-pressed_tab = 'TBS_0102'.
*      g_tabstrip_0102-subscreen   = '0105'.
  ENDCASE.

ENDMODULE.
