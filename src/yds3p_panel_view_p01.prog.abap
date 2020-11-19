*&---------------------------------------------------------------------*
*&  Include           YDS3P_PANEL_VIEW_P01
*&---------------------------------------------------------------------*


*---------------------------------------------------------------------*
*      Module  pai0100  INPUT
*---------------------------------------------------------------------*
MODULE pai0100 INPUT.
  CALL METHOD cl_gui_cfw=>flush.
  PERFORM ucomm USING sy-ucomm.
ENDMODULE.                 " pai0100  INPUT

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  PERFORM ucomm USING sy-ucomm.
ENDMODULE.                 " USER_COMMAND_0100  INPUT

*---------------------------------------------------------------------*
*      Form  ucomm
*---------------------------------------------------------------------*
FORM ucomm USING p_ucomm TYPE syucomm.

  DATA: v_ucomm TYPE syucomm.
  MOVE  p_ucomm TO v_ucomm.
  DO.
    CASE v_ucomm.
      WHEN 'BACK' OR 'EXIT' OR 'CANC'.
        LEAVE PROGRAM.
      WHEN ''.
      WHEN OTHERS.
*        CALL TRANSACTION v_ucomm.
    ENDCASE.
    CLEAR v_ucomm.
    EXIT.
  ENDDO.
ENDFORM.                    " ucomm
