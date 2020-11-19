*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZDSOL_CNPJ_CONS
*   generation date: 20.08.2018 at 14:40:17
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZDSOL_CNPJ_CONS    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
