*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_command INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE PROGRAM.
*      CLEAR ok_code.
*      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.                    "exit_command INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'EXPORTAR'.
      CALL SCREEN 0200 STARTING AT 67 3.
    WHEN 'REPROC'.
      PERFORM call_selection.
      PERFORM limpa_objetos.
      PERFORM iniciar_classes.
      PERFORM refresh_screen_funcion.
    WHEN 'SAVE'.

  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE ok_code.
    WHEN 'VIEW'.
     CALL SCREEN '0100'.
    WHEN 'EXIT'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_9000 INPUT.

    CASE ok_code.
    WHEN 'FICHA1'.
      G_FICHAS-pressed_tab = ok_code.
      G_FICHAS-subscreen   = 9001.
    WHEN 'FICHA2'.
      G_FICHAS-pressed_tab = ok_code.
      G_FICHAS-subscreen   = 9002.
    WHEN 'FICHA3'.
      G_FICHAS-pressed_tab = ok_code.
      G_FICHAS-subscreen   = 9003.
    WHEN 'BACK' OR 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
