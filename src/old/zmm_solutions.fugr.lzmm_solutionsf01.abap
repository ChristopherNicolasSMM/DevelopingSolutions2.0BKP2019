*----------------------------------------------------------------------*
***INCLUDE LZMM_SOLUTIONSF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  AJUSTAR_RANGE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_R_DT_PED  text
*      -->P_0120   text
*      -->P_0121   text
*      -->P_0122   text
*      -->P_0123   text
*----------------------------------------------------------------------*
FORM AJUSTAR_RANGE  USING    VALUE(P_TYPE)
                             VALUE(P_SIGN)
                             VALUE(P_OPTION)
                             VALUE(P_LOW)
                             VALUE(P_HIGH)
                   CHANGING P_RANGE.
FIELD-SYMBOLS: <fs_range> type any.



ASSIGN COMPONENT P_TYPE OF STRUCTURE 'MARA' TO <fs_range>.

*    P_RANGE-SIGN   = P_SIGN.
*    P_RANGE-OPTION = P_OPTION.
*    P_RANGE-LOW    = P_LOW.
*    P_RANGE-HIGH   = P_HIGH.


ENDFORM.
