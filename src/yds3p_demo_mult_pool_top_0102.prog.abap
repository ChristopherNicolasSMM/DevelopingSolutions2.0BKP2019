*&---------------------------------------------------------------------*
*&  Include           YDS3P_DEMO_MULT_POOL_TOP_0102
*&---------------------------------------------------------------------*

CONTROLS: tbs_0102 TYPE TABSTRIP.

DATA:  BEGIN OF g_tabstrip_0102,
         subscreen   LIKE sy-dynnr VALUE '0103',
         prog        LIKE sy-repid VALUE 'YDS3P_DEMO_MULT_POOL',
         pressed_tab LIKE sy-ucomm VALUE 'TBS_0102',
       END OF g_tabstrip_0102.
