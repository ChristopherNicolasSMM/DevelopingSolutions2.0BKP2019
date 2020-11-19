
REPORT yds3p_mockup_mhtml.

***********************************************************************
* Elementos de dados Globais
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_TOP.

CONTROLS: fichas TYPE TABSTRIP.

DATA:      BEGIN OF g_fichas,
             subscreen   LIKE sy-dynnr VALUE '9001',
             prog        LIKE sy-repid VALUE 'YDS3P_MOCKUP_MHTML',
             pressed_tab LIKE sy-ucomm VALUE 'FICHA1',
           END OF g_fichas.

***********************************************************************
* CLASSES
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_C01.

***********************************************************************
* Tela de seleção 1000
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_SCR.

INITIALIZATION.

START-OF-SELECTION.

  CALL SCREEN 0100.

END-OF-SELECTION.


***********************************************************************
* PBO Modules
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_O01.

***********************************************************************
* INCLUDES for FORM ROUTINES
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_F01.

***********************************************************************
* PAI Modules
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_I01.


***********************************************************************
* Include HTML do menu lateral
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_MENUHTML.


***********************************************************************
* Dastboard página inicial HTML ao abrir cockpit
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_DASH_HTML.

***********************************************************************
* Caso necessário em algum momento trabalhar com texto segue conteiner
***********************************************************************
INCLUDE YDS3P_MOCKUP_MHTML_TEXTEDITOR.
