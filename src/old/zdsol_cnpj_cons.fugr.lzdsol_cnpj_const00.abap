*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 20.08.2018 at 14:40:21
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZDSOL_CNPJ_CONS.................................*
DATA:  BEGIN OF STATUS_ZDSOL_CNPJ_CONS               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDSOL_CNPJ_CONS               .
CONTROLS: TCTRL_ZDSOL_CNPJ_CONS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDSOL_CNPJ_CONS               .
TABLES: ZDSOL_CNPJ_CONS                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
