*&---------------------------------------------------------------------*
*&  Include           YDS3P_PANEL_VIEW_DEF
*&---------------------------------------------------------------------*

DEFINE makeimg.
  IF I_DATA CS &1.
    MOVE O_BDS->MAKE_FILE( KWRD = &2 ) TO V_URLM.
    V_LEN = STRLEN( V_URLM ).
    IF NOT V_LEN IS INITIAL.
      REPLACE &1 WITH V_URLM(V_LEN) INTO I_DATA.
    ENDIF.
    MODIFY I_DATA.
  ENDIF.
END-OF-DEFINITION.

DEFINE makeconf.
  IF I_DATA CS &1.
    V_LEN = STRLEN( &2 ).
    IF NOT V_LEN IS INITIAL.
      REPLACE &1 WITH &2(V_LEN) INTO I_DATA.
    ENDIF.
    MODIFY I_DATA.
  ENDIF.
END-OF-DEFINITION.
