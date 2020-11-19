*&---------Developing Solutions off people, process and project's-------
*& &
*& & Author...........: Christopher Nicolas Mauricio .'.
*& & Consultancy .....: DS3P
*& & Date develop ....: 10.07.2019
*& & Type of prg .....: Executable
*& & Transaction .....: YDS3P_R001
*&----------------------------------------------------------------------


*   Gerenciamento de Datas
*   ----------------------
*   ADD_DMY_TO_DATE       Adiciona anos, meses, dias a uma data
*   DATE_TO_INTERNAL      Converte uma data ao formato interno do SAP
*   INTERVAL_TO_DMY       Número de anos, meses, dias entre duas datas
*
*   Gestão de RH / PD
*   -------------------
*   ADATA_TO_PAD          Transfere um ADATA para um PAD
*   DELETE_INFTY          Apaga os registros em um infotipo OM
*   EXIST_OBJECT          Verifica a existência de um objeto de PD
*   GET_PLVAR             Retorna a variante de planejamento ativa
*   GET_STEXT             Texto referência de um objeto de PD
*   GET_TEXTS             Retorna o texto curto e longo de um obj de PD
*   INSERT_INFTY          Insere registros em um infotipo de PD
*   PAD_TO_ADATA          Transfere um PAD para um ADATA
*   READ_INFTY            leitura de um infotipo PD com parâmetros.
*   READ_INFTY_OBJECTS    Leitura simultânea de vários objetos de PD
*   READ_INFTY_OBJID      Leitura de um único objeto PD
*   READ_OBJECT           Leitura de um objeto PD
*   READ_OBJECT_SET       Leitura de um conjunto de objetos de PD
*   STRU_AUTHORITY_CHECK  Verificação de autorização em um objeto de PD
*
*   Gestão de RH / PA
*   -------------
*   CHECK_PERNR_EXISTS    Verifica a existência de um PERNR
*   GET_CORPS_GRADE       Retorna o corps/grade de um funcionário.
*   GET_PERNR_CORPS_GRADE Retorna o corps/grade a partir de uma matrícula
*   GET_SEX               Retorna o sexo de um funcionário
*   GET_SUBTY_TEXT        Retorna a descrição de um subtipo de um infotipo
*   READ_INFOTYPE         Leitura de um infotipo de PA
*   GET_EMPLOYEE_DATA     Retorna os dados de um funcionário
*   GET_MOLGA             Retorna o grupo de países
*
*   Popups
*   ------
*   POPUP_TO_CONFIRM      Exibe uma janela de confirmação
*
*   Aides à la recherche
*   --------------------
*   F4_MACO               Código de conversão de um objeto OM em ID
*   F4_OBJID              Ajuda para objetos OM
*
*   Dictionnaire
*   ------------
*   GET_DOMAIN_TEXT       Retorna a descrição de um domínio
*
*   Divers
*   ------
*   CHECK_FILE_EXISTS     Verifica a existência de um arquivo
*   CHECK_ISNUM           Verifica se o valor é numérico
*   CONVERT_TO_CURRENCY   Converte um valor para moeda
*   DYNP_READ             Leutira de áreas a partir de um webdynpro
*   DYNP_UPDATE           Mudança de áreas de tela sem passar pelo PBO
*   PROGRESS              Exibe uma mensagem na barra de status
*
***********************************************************************

REPORT YDS3P_HELPFUL_FUNCTIONS.


*&---------------------------------------------------------------------*
*&      Form  date_to_internal
*&---------------------------------------------------------------------*
*       Converte uma data para o formato interno de datas do SAP
*----------------------------------------------------------------------*
*      -->P_EDATE    Data no formato DDMMAA ou DDMMAAAA
*      <--P_IDATE    Data no formato AAAAMMDD
*----------------------------------------------------------------------*
FORM date_to_internal USING    p_edate TYPE any
                      CHANGING p_idate TYPE any.

  CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
    EXPORTING
      date_external                  = p_edate
*     ACCEPT_INITIAL_DATE            =
    IMPORTING
      date_internal                  = p_idate
    EXCEPTIONS
      date_external_is_invalid       = 1
      OTHERS                         = 2
            .
  IF sy-subrc <> 0.
    CLEAR p_idate.
  ENDIF.

ENDFORM.                    "date_to_internal
*&---------------------------------------------------------------------*
*&      Form  delete_infty
*&---------------------------------------------------------------------*
*       Exclui registros de infotipo OM
*----------------------------------------------------------------------*
*      -->P_PNNNN    Enregistrements à supprimer
*      <--P_SUBRC    Code retour
*----------------------------------------------------------------------*
FORM delete_infty  TABLES   p_pnnnn
                   CHANGING p_subrc TYPE sysubrc.

  CALL FUNCTION 'RH_DELETE_INFTY'
    EXPORTING
*     LOAD                      = 'X'
      vtask                     = 'D'
*     ORDER_FLG                 = 'X'
*     COMMIT_FLG                = 'X'
*     AUTHY                     = 'X'
*     PPPAR_IMP                 =
*     KEEP_LUPD                 =
*     WORKF_ACTV                = 'X'
    TABLES
      innnn                     = p_pnnnn
*     ILFCODE                   =
    EXCEPTIONS
      error_during_delete       = 1
      no_authorization          = 2
      delete_first_record       = 3
      corr_exit                 = 4
      OTHERS                    = 5
            .
  p_subrc = sy-subrc.

ENDFORM.                    "delete_infty
*&---------------------------------------------------------------------*
*&      Form  ADD_DMY_TO_DATE
*&---------------------------------------------------------------------*
*       Adiciona anos, meses, dias em uma determinada data
*----------------------------------------------------------------------*
*      -->P_BEGDA    text
*      -->P_DAYS     text
*      -->P_MONTHS   text
*      -->P_YEARS    text
*      <--P_ENDDA    text
*----------------------------------------------------------------------*
FORM add_dmy_to_date USING    p_begda TYPE datum
                              p_years TYPE any
                              p_months TYPE any
                              p_days TYPE any
                     CHANGING p_endda TYPE datum.

  DATA l_days LIKE t5a4a-dlydy.
  DATA l_months LIKE t5a4a-dlymo.
  DATA l_years LIKE t5a4a-dlyyr.

  l_days = p_days.
  l_months = p_months.
  l_years = p_years.

  CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
    EXPORTING
      date      = p_begda
      days      = l_days
      months    = l_months
      signum    = '+'
      years     = l_years
    IMPORTING
      calc_date = p_endda.

ENDFORM.                    "add_dmy_to_date
*&---------------------------------------------------------------------*
*&      Form  INTERVAL_TO_DMY
*&---------------------------------------------------------------------*
*       Retorna o número de anos, meses, dias entre duas datas
*----------------------------------------------------------------------*
*   -->p_begda   Date de début
*   -->p_endda   Date de fin
*   <--p_years   Nombre d'années
*   <--p_months  Nombre de mois
*   <--p_days    Nombre de jours
*----------------------------------------------------------------------*
FORM interval_to_dmy USING     p_begda  TYPE datum
                               p_endda  TYPE datum
                     CHANGING  p_years  TYPE any
                               p_months TYPE any
                               p_days   TYPE any.

  DATA l_years LIKE vtbbewe-atage.
  DATA l_months LIKE vtbbewe-atage.
  DATA l_days LIKE vtbbewe-atage.

  CALL FUNCTION 'FIMA_DAYS_AND_MONTHS_AND_YEARS'
    EXPORTING
      i_date_from    = p_begda
      i_date_to      = p_endda
      i_flg_separate = 'X'
    IMPORTING
      e_days         = l_days
      e_months       = l_months
      e_years        = l_years.

  p_years = l_years.
  p_months = l_months.
  p_days = l_days.

ENDFORM.                    "interval_to_dmy
*&---------------------------------------------------------------------*
*&      Form  get_pernr_corps_grade
*&---------------------------------------------------------------------*
*       Retorna o corpo / grade de um número de registro em uma
*       determinada data
*----------------------------------------------------------------------*
*      -->P_PERNR    Matrículo
*      -->P_DATUM    Data de Leitura
*      <--P_CORPS    Corps retornado
*      <--P_GRADE    Grade retornada
*----------------------------------------------------------------------*
FORM get_pernr_corps_grade USING    p_pernr TYPE any
                                    p_datum TYPE sy-datum
                           CHANGING p_corps TYPE any
                                    p_grade TYPE any
                                    p_subrc TYPE any.

  CLEAR: p_corps, p_grade.
  SELECT SINGLE corps grade INTO (p_corps, p_grade)
                            FROM pa0431
                           WHERE pernr EQ p_pernr
                             AND begda LE p_datum
                             AND endda GE p_datum.
  MOVE sy-subrc TO p_subrc.

ENDFORM.                    "get_pernr_corps_grade
*&--------------------------------------------------------------------*
*&      Form  exist_object
*&--------------------------------------------------------------------*
*       Verificar a existência de um objeto de PD
*---------------------------------------------------------------------*
*      -->P_PLVAR    Planejamento ativo
*      -->P_OTYPE    Tipo de Objeto
*      -->P_OBJID    ID do objeto
*      <--P_SUBRC    <>0 = objeto não encontrado
*---------------------------------------------------------------------*
FORM exist_object USING p_plvar TYPE plvar
                        p_otype TYPE any
                        p_objid TYPE any
                  CHANGING p_subrc TYPE any.

  CLEAR p_subrc.
  CALL FUNCTION 'RH_EXIST_OBJECT'
    EXPORTING
      plvar                 = p_plvar
      otype                 = p_otype
      objid                 = p_objid
*     REALO                 = ' '
*   IMPORTING
*     EXTERNAL_OBJECT       =
    EXCEPTIONS
      not_found             = 1
      OTHERS                = 2
            .
  IF sy-subrc <> 0.
    MOVE sy-subrc TO p_subrc.
  ENDIF.

ENDFORM.                    "exist_object
*&--------------------------------------------------------------------*
*&      Form  check_pernr_exists
*&--------------------------------------------------------------------*
*       Verifica a existência de um número de registro no BD
*---------------------------------------------------------------------*
*      -->P_PERNR    Matricule
*      <--P_SUBRC    Code retour
*---------------------------------------------------------------------*
FORM check_pernr_exists USING p_pernr TYPE any
                        CHANGING p_subrc TYPE sysubrc.

  CLEAR p_subrc.

  CALL FUNCTION 'RP_CHECK_PERNR'
    EXPORTING
      beg                     = sy-datum
      pnr                     = p_pernr
*   IMPORTING
*     NAME                    =
*     PERSA                   =
*     BUKRS                   =
*     KOSTL                   =
*     MOLGA                   =
*     PERSONNEL_SUBAREA       =
    EXCEPTIONS
      data_fault              = 1
      person_not_active       = 2
      person_unknown          = 3
      exit_fault              = 4
      pernr_missing           = 5
      date_missing            = 6
      OTHERS                  = 7
            .
  IF sy-subrc <> 0.
    p_subrc = sy-subrc.
  ENDIF.

ENDFORM.                    "check_pernr_exists
*&--------------------------------------------------------------------*
*&      Form  popup_yes_no
*&--------------------------------------------------------------------*
*       text
*---------------------------------------------------------------------*
*      -->P_TITLE    Título do pop-up
*      -->P_TEXT     Texto da pergunta
*      -->P_DEFBTN   Botão padrão (1 ou 2)
*      -->P_CANC     'X'= mostrar botão cancelar
*      <--P_ANSWER   Botão selecionado (1, 2 ou A)
*---------------------------------------------------------------------*
FORM popup_yes_no USING    p_title  TYPE any
                           p_text   TYPE any
                           p_defbtn TYPE c
                           p_canc   TYPE c
                  CHANGING p_answer TYPE c.

  CLEAR p_answer.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar                    = p_title
*     DIAGNOSE_OBJECT             = ' '
      text_question               = p_text
      text_button_1               = 'Oui'
      icon_button_1               = 'ICON_OKAY'
      text_button_2               = 'Non'
*     ICON_BUTTON_2               = ' '
      default_button              = p_defbtn
      display_cancel_button       = 'X'
*     USERDEFINED_F1_HELP         = ' '
*     START_COLUMN                = 25
*     START_ROW                   = 6
*     POPUP_TYPE                  =
*     IV_QUICKINFO_BUTTON_1       = ' '
*     IV_QUICKINFO_BUTTON_2       = ' '
    IMPORTING
      answer                      = p_answer
*   TABLES
*     PARAMETER                   =
    EXCEPTIONS
      text_not_found              = 1
      OTHERS                      = 2
            .
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

ENDFORM.                    "popup_yes_no
*&--------------------------------------------------------------------*
*&      Form  get_subty_text
*&--------------------------------------------------------------------*
*       Retorna a descrição de um subtipo de um infotipo (PA ou PD)
*---------------------------------------------------------------------*
*      -->P_INFTY    Infotipo
*      -->P_SUBTY    Subtipo
*      <--P_STEXT    Descrição do subtipo retornada
*      <--P_SUBRC    Código de retorno
*---------------------------------------------------------------------*
FORM get_subty_text USING    p_infty TYPE any
                             p_subty TYPE any
                    CHANGING p_stext TYPE any
                             p_subrc TYPE sysubrc.

  DATA l_infty TYPE infty.
  DATA l_subty TYPE subty.
  DATA l_stext TYPE sbttx.

  CLEAR p_subrc.
  CLEAR p_stext.

  MOVE p_infty TO l_infty.
  MOVE p_subty TO l_subty.

  IF l_infty = '0431'.
    l_infty = '0008'.
  ENDIF.

  CALL FUNCTION 'HR_GET_SUBTYPE_TEXT'
    EXPORTING
      infty                     = l_infty
      subty                     = l_subty
*     PERSNR                    =
*     TCLAS                     = 'A'
*     BEGDA                     = SY-DATUM
*     ENDDA                     = SY-DATUM
*     LANGU                     = SY-LANGU
*     MOLGA                     =
    IMPORTING
      stext                     = l_stext
    EXCEPTIONS
      infty_not_found           = 1
      subty_not_found           = 2
      infty_not_supported       = 3
      OTHERS                    = 4
            .
  IF sy-subrc <> 0.
    MOVE sy-subrc TO p_subrc.
  ELSE.
    MOVE l_stext TO p_stext.
  ENDIF.

ENDFORM.                    "get_subty_text
*&--------------------------------------------------------------------*
*&      Form  get_domain_text
*&--------------------------------------------------------------------*
*       Retorna a descrição de um determinado valor em um domínio
*---------------------------------------------------------------------*
*      -->P_DOMNAME  Domínio
*      -->P_DOMVAL   Valor do domínio
*      -->P_TEXT     Descrição do Valor
*---------------------------------------------------------------------*
FORM get_domain_text USING    p_domname TYPE any
                              p_domval  TYPE any
                     CHANGING p_text    TYPE any.

  DATA l_dd07t LIKE dd07t.

  CLEAR p_text.

  SELECT SINGLE * FROM  dd07t INTO l_dd07t
                  WHERE domname EQ p_domname
                    AND ddlanguage EQ sy-langu
                    AND as4local EQ 'A'
                    AND domvalue_l EQ p_domval.
  IF sy-subrc = 0.
    MOVE l_dd07t-ddtext TO p_text.
  ENDIF.

ENDFORM.                    "get_domain_text
*&--------------------------------------------------------------------*
*&      Form  get_corps_grade
*&--------------------------------------------------------------------*
*   Retorna o cargo e a patente de um oficial do infotipo 0431
*---------------------------------------------------------------------*
*      -->P_PERNR    Matricula
*      -->P_DATUM    Data
*      <--P_CORPS    Cargo
*      <--P_GRADE    Patente
*---------------------------------------------------------------------*
FORM get_corps_grade USING    p_pernr TYPE pernr-pernr
                              p_datum TYPE sy-datum
                     CHANGING p_corps TYPE p06_corps
                              p_grade TYPE p06_grade.

  DATA: l_corps TYPE p06_corps,
        l_grade TYPE p06_grade.

  SELECT SINGLE corps grade FROM pa0431
                            INTO (l_corps,l_grade)
         WHERE pernr = p_pernr
          AND  begda =< p_datum
          AND  endda >= p_datum.

  p_corps = l_corps.
  p_grade = l_grade.

ENDFORM.                    "get_corps_grade
*&--------------------------------------------------------------------*
*&      Form  read_infty
*&--------------------------------------------------------------------*
*       Leitura de um infotipo para um determinado objeto
*---------------------------------------------------------------------*
*      <->P_PNNNN    Tabela de destino do infotipo
*      -->P_PLVAR    Planejamento ativo
*      -->P_OTYPE    Tipo de objeto
*      -->P_OBJID    ID do objeto
*      -->P_INFTY    Infotipe
*      -->P_SUBTY    Subtipo
*      -->P_BEGDA    Data de início
*      -->P_ENDDA    Date de fim
*      -->P_SUBRC    Código de retorno
*---------------------------------------------------------------------*
FORM read_infty  TABLES   p_pnnnn
                 USING    p_plvar  LIKE  hrobject-plvar
                          p_otype  LIKE  hrobject-otype
                          p_objid  TYPE  any
                          p_infty  LIKE  t777d-infty
                          p_subty  LIKE  t778u-subty
                          p_begda  LIKE  objec-begda
                          p_endda  LIKE  objec-endda
                 CHANGING p_subrc  LIKE  sy-subrc.

  DATA l_objid LIKE plog-objid.

  l_objid = p_objid.

  CLEAR p_pnnnn.
  REFRESH p_pnnnn.

  CALL FUNCTION 'RH_READ_INFTY'
    EXPORTING
*     AUTHORITY                  = 'DISP'
*     WITH_STRU_AUTH             = 'X'
      plvar                      = p_plvar
      otype                      = p_otype
      objid                      = l_objid
      infty                      = p_infty
*     ISTAT                      = ' '
*     EXTEND                     = 'X'
      subty                      = p_subty
      begda                      = p_begda
      endda                      = p_endda
*     CONDITION                  = '00000'
*     INFTB                      = '1'
*     SORT                       = 'X'
*     VIA_T777D                  = ' '
    TABLES
      innnn                      = p_pnnnn
*     OBJECTS                    =
    EXCEPTIONS
      all_infty_with_subty       = 1
      nothing_found              = 2
      no_objects                 = 3
      wrong_condition            = 4
      wrong_parameters           = 5
      OTHERS                     = 6
            .
  p_subrc = sy-subrc.

ENDFORM.                    " read_infty_objid
*&--------------------------------------------------------------------*
*&      Form  read_infty_objid
*&--------------------------------------------------------------------*
*       Leitura de um infotipo para um determinado objeto a partir
*       de um ID
*---------------------------------------------------------------------*
*      <->P_PNNNN    Tabela de destino do infotipo
*      -->P_PLVAR    Planejamento ativo
*      -->P_OTYPE    Tipo de objeto
*      -->P_OBJID    ID do objeto
*      -->P_INFTY    Infotipo
*      -->P_SUBTY    Subtipo
*      -->P_SUBRC    Código de retorno
*---------------------------------------------------------------------*
FORM read_infty_objid  TABLES   p_pnnnn
                       USING    p_plvar  LIKE  hrobject-plvar
                                p_otype  LIKE  hrobject-otype
                                p_objid  TYPE  any
                                p_infty  LIKE  t777d-infty
                                p_subty  LIKE  t778u-subty
                       CHANGING p_subrc  LIKE  sy-subrc.

  DATA l_objid LIKE plog-objid.

  l_objid = p_objid.

  CLEAR p_pnnnn.
  REFRESH p_pnnnn.

  CALL FUNCTION 'RH_READ_INFTY'
    EXPORTING
*     AUTHORITY                  = 'DISP'
*     WITH_STRU_AUTH             = 'X'
      plvar                      = p_plvar
      otype                      = p_otype
      objid                      = l_objid
      infty                      = p_infty
*     ISTAT                      = ' '
*     EXTEND                     = 'X'
      subty                      = p_subty
*     BEGDA                      = '19000101'
*     ENDDA                      = '99991231'
*     CONDITION                  = '00000'
*     INFTB                      = '1'
*     SORT                       = 'X'
*     VIA_T777D                  = ' '
    TABLES
      innnn                      = p_pnnnn
*     OBJECTS                    =
    EXCEPTIONS
      all_infty_with_subty       = 1
      nothing_found              = 2
      no_objects                 = 3
      wrong_condition            = 4
      wrong_parameters           = 5
      OTHERS                     = 6
            .
  p_subrc = sy-subrc.

ENDFORM.                    " read_infty_objid
*&--------------------------------------------------------------------*
*&      Form  read_infty_objects
*&--------------------------------------------------------------------*
*       Leitura de um infotipo para um conjunto de objetos
*---------------------------------------------------------------------*
*      <->P_PNNNN    Tabela destino para o infotipo
*      -->P_OBJECTS  Tabela com os objetos a serem recuperados
*      -->P_INFTY    Infotipo
*      -->P_SUBTY    Subtipo
*      -->P_SUBRC    Código de retorno
*---------------------------------------------------------------------*
FORM read_infty_objects  TABLES   p_pnnnn
                                  p_objects  STRUCTURE  hrobject
                         USING    p_infty  LIKE  t777d-infty
                                  p_subty  LIKE  t778u-subty
                         CHANGING p_subrc  LIKE  sy-subrc.

  CLEAR p_pnnnn.
  REFRESH p_pnnnn.

  CALL FUNCTION 'RH_READ_INFTY'
    EXPORTING
*     AUTHORITY                  = 'DISP'
*     WITH_STRU_AUTH             = 'X'
*     PLVAR                      =
*     OTYPE                      =
*     OBJID                      =
      infty                      = p_infty
*     ISTAT                      = ' '
*     EXTEND                     = 'X'
      subty                      = p_subty
*     BEGDA                      = '19000101'
*     ENDDA                      = '99991231'
*     CONDITION                  = '00000'
*     INFTB                      = '1'
*     SORT                       = 'X'
*     VIA_T777D                  = ' '
    TABLES
      innnn                      = p_pnnnn
      OBJECTS                    = p_objects
    EXCEPTIONS
      all_infty_with_subty       = 1
      nothing_found              = 2
      no_objects                 = 3
      wrong_condition            = 4
      wrong_parameters           = 5
      OTHERS                     = 6
            .
  p_subrc = sy-subrc.

ENDFORM.                    " read_infty_objects
*&--------------------------------------------------------------------*
*&      Form  get_stext
*&--------------------------------------------------------------------*
*       Retorna o texto de um objeto
*---------------------------------------------------------------------*
*      -->P_PLVAR    Planejamento ativo
*      -->P_OTYPE    Tipo de objeto
*      -->P_OBJID    ID do objeto
*      -->P_DATUM    Data
*      <--P_STEXT    Texto de retorno
*---------------------------------------------------------------------*
FORM get_stext  USING    p_plvar LIKE objec-plvar
                         p_otype TYPE any
                         p_objid TYPE any
                         p_datum LIKE sy-datum
                CHANGING p_stext TYPE any.

  DATA l_stext LIKE p1000-stext.

  CALL FUNCTION 'RH_READ_OBJECT'
    EXPORTING
      plvar                 = p_plvar
      otype                 = p_otype
      objid                 = p_objid
*     REALO                 = ' '
*     ISTAT                 = ' '
      begda                 = p_datum
      endda                 = p_datum
*     LANGU                 = SY-LANGU
*     OINTERVAL             = 'X'
*     STORE                 = 'X'
*     CHECK_STRU_AUTH       = 'X'
*     READ_DB               = ' '
    IMPORTING
*     OBEG                  =
*     OEND                  =
*     OSTAT                 =
*     HISTO                 =
*     SHORT                 =
      stext                 = l_stext
*     TISTAT                =
*     TLANGU                =
*     DISPLAY_TEXT          =
*   TABLES
*     EXISTENCE             =
    EXCEPTIONS
      not_found             = 1
      OTHERS                = 2
            .
  IF sy-subrc <> 0.
    CLEAR p_stext.
  ELSE.
    p_stext = l_stext.
  ENDIF.

ENDFORM.                    " get_stext
*&--------------------------------------------------------------------*
*&      Form  get_plvar
*&--------------------------------------------------------------------*
*       Retorna o planejamento ativo
*---------------------------------------------------------------------*
*      <--P_PLVAR    Retorno com o planejamento ativo
*---------------------------------------------------------------------*
FORM get_plvar  CHANGING p_plvar LIKE objec-plvar.

  GET PARAMETER ID 'POP' FIELD p_plvar.
  IF sy-subrc NE 0.
    CALL FUNCTION 'RH_GET_ACTIVE_WF_PLVAR'
      EXPORTING
        ask_plvar_dialog        = 'X'
*       SET_DEFAULT_PLVAR       =
      IMPORTING
        act_plvar               = p_plvar
      EXCEPTIONS
        no_active_plvar         = 1
        OTHERS                  = 2.
    IF sy-subrc NE 0.
*      MESSAGE w508(hrstp).
    ENDIF.
  ENDIF.

ENDFORM.                    " get_plvar
*&--------------------------------------------------------------------*
*&      Form  read_infotype
*&--------------------------------------------------------------------*
*       Lê um infotipo de PA
*---------------------------------------------------------------------*
*      <->P_PNNNN    Tabela do infotipo
*      -->P_PERNR    Matrícula
*      -->P_INFTY    Infotipo
*      -->P_BEGDA    Data de início
*      -->P_ENDDA    Date de fim
*      <--P_SUBRC    Código de retorno
*---------------------------------------------------------------------*
FORM read_infotype  TABLES   p_pnnnn
                    USING    p_pernr TYPE any
                             p_infty LIKE t777d-infty
                             p_begda LIKE pskey-begda
                             p_endda LIKE pskey-endda
                    CHANGING p_subrc LIKE sy-subrc.

  DATA: l_pernr LIKE pernr-pernr.

  CLEAR p_pnnnn.
  REFRESH p_pnnnn.

  l_pernr = p_pernr.

  CALL FUNCTION 'HR_READ_INFOTYPE'
    EXPORTING
*     TCLAS                 = 'A'
      pernr                 = l_pernr
      infty                 = p_infty
      begda                 = p_begda
      endda                 = p_endda
*     BYPASS_BUFFER         = ' '
*     LEGACY_MODE           = ' '
   IMPORTING
     subrc                  = p_subrc
    TABLES
      infty_tab             = p_pnnnn
    EXCEPTIONS
      infty_not_found       = 1
      OTHERS                = 2.

  IF  sy-subrc NE 0.
    p_subrc = sy-subrc.
  ENDIF.

ENDFORM.                    " read_infotype
*&--------------------------------------------------------------------*
*&      Form  get_sex
*&--------------------------------------------------------------------*
*       Retorna o sexo de um funcionário
*         1 --> Masculino
*         2 --> Feminino
*---------------------------------------------------------------------*
*      -->P_PERNR    Número pessoal
*      -->P_SEX      Código do sexo
*---------------------------------------------------------------------*
FORM get_sex  USING    p_pernr TYPE any
              CHANGING p_sex   TYPE gesch.

  DATA l_it0002 LIKE p0002 OCCURS 0 WITH HEADER LINE.
  DATA l_subrc  LIKE sy-subrc.

  CLEAR p_sex.

  PERFORM read_infotype TABLES l_it0002
                        USING p_pernr '0002' sy-datum sy-datum
                        CHANGING l_subrc.
  CHECK l_subrc IS INITIAL.
  READ TABLE l_it0002 INDEX 1.
  p_sex = l_it0002-gesch.

ENDFORM.                    " get_sex
*&--------------------------------------------------------------------*
*&      Form  get_employee_data
*&--------------------------------------------------------------------*
*       Retorna os dados de um empregado
*---------------------------------------------------------------------*
*      -->P_PERNR    Matricule
*      -->P_BEGDA    Date de início
*      -->P_ENDDA    Date de fim
*      <--P_PERSON   Dados retornados
*      <--P_SUBRC    Código de retorno
*---------------------------------------------------------------------*
FORM get_employee_data USING    p_pernr  TYPE any
                                p_begda  LIKE sy-datum
                                p_endda  LIKE sy-datum
                       CHANGING p_person LIKE person
                                p_subrc  LIKE sy-subrc.

  DATA l_objid LIKE objec-objid.

  l_objid = p_pernr.

  CLEAR p_person.

  CALL FUNCTION 'HR_GET_EMPLOYEE_DATA'
    EXPORTING
      person_id             = l_objid
      selection_begin       = p_begda
      selection_end         = p_endda
    IMPORTING
      personal_data         = p_person
    EXCEPTIONS
      person_not_found      = 1
      no_active_integration = 2
      OTHERS                = 3.
  p_subrc = sy-subrc.
  IF p_person IS INITIAL.
    p_subrc = 4.
  ENDIF.
  CHECK sy-subrc IS INITIAL.

ENDFORM.                    " get_employee_data
*&--------------------------------------------------------------------*
*&      Form  get_molga
*&--------------------------------------------------------------------*
*       Retorna o grupo de países ou quando apropriado um pop-up para
*       escolher o grupo de países
*---------------------------------------------------------------------*
*      -->P_PERNR    Número Pessoal do Funcionário
*      <--P_MOLGA    Grupo de países
*---------------------------------------------------------------------*
FORM get_molga  USING    p_pernr LIKE pernr-pernr
                CHANGING p_molga LIKE t500l-molga.

  GET PARAMETER ID 'MOL' FIELD p_molga.

  IF sy-subrc NE 0.
    CALL FUNCTION 'RH_PM_GET_MOLGA_FROM_PERNR'
      EXPORTING
*       PLVAR                 =
        pernr                 = p_pernr
*       BEGDA                 = '19000101'
*       ENDDA                 = '99991231'
      IMPORTING
        molga                 = p_molga
*       TRFKZ                 =
      EXCEPTIONS
        nothing_found         = 1
        no_active_plvar       = 2
        OTHERS                = 3
              .
    IF sy-subrc <> 0.
      CLEAR p_molga.
    ENDIF.
  ENDIF.

ENDFORM.                    " get_molga
*&---------------------------------------------------------------------*
*&      Form  get_texts
*&---------------------------------------------------------------------*
*       Retorna o texto curto e longo de um objeto de PD
*----------------------------------------------------------------------*
*      -->P_PLVAR     Planejamento Ativo
*      -->P_OTYPE     Type de objeto
*      -->P_OBJID     ID do objeto
*      -->P_DATUM     Date de busca
*      <--P_SHORT     Retorno Código (Texto curto)
*      <--P_STEXT     Retorno com texto descritivo (longo)
*----------------------------------------------------------------------*
FORM get_texts  USING    p_plvar LIKE objec-plvar
                         p_otype TYPE any
                         p_objid TYPE any
                         p_datum TYPE datum
                CHANGING p_short TYPE any
                         p_stext TYPE any.

  DATA l_objid LIKE objec-objid.
  DATA l_short LIKE objec-short.
  DATA l_stext LIKE objec-stext.

  MOVE p_objid TO l_objid.

  CALL FUNCTION 'RH_READ_OBJECT'
    EXPORTING
      plvar                 = p_plvar
      otype                 = p_otype
      objid                 = l_objid
*     REALO                 = ' '
*     ISTAT                 = ' '
      begda                 = p_datum
      endda                 = p_datum
*     LANGU                 = SY-LANGU
*     OINTERVAL             = 'X'
*     STORE                 = 'X'
*     CHECK_STRU_AUTH       = 'X'
*     READ_DB               = ' '
    IMPORTING
*     OBEG                  =
*     OEND                  =
*     OSTAT                 =
*     HISTO                 =
      short                 = l_short
      stext                 = l_stext
*     TISTAT                =
*     TLANGU                =
*     DISPLAY_TEXT          =
*   TABLES
*     EXISTENCE             =
    EXCEPTIONS
      not_found             = 1
      OTHERS                = 2
            .
  IF sy-subrc <> 0.
    CLEAR: p_short, p_stext.
  ELSE.
    p_short = l_short.
    p_stext = l_stext.
  ENDIF.

ENDFORM.                    " get_texts
*&---------------------------------------------------------------------*
*&      Form  stru_authority_check
*&---------------------------------------------------------------------*
*       Realiza uma verificação de um objeto de autorização passado no
*       parâmetro
*----------------------------------------------------------------------*
*      -->P_FCODE     Código de função (tipo de controle)
*      -->P_PLVAR     Planejamento ativo
*      -->P_OTYPE     Type de objeto
*      -->P_OBJID     ID do objeto
*      -->P_BASE_AC   'X' = com controle de autorização
*      <--P_SUBRC     Código de retorno
*----------------------------------------------------------------------*
FORM stru_authority_check  USING    p_fcode   LIKE t77fc-fcode
                                    p_plvar   TYPE plvar
                                    p_otype   TYPE any
                                    p_objid   TYPE any
                                    p_base_ac TYPE c
                           CHANGING p_subrc   TYPE sysubrc.

  CLEAR p_subrc.

  CALL FUNCTION 'RH_STRU_AUTHORITY_CHECK'
    EXPORTING
      fcode                    = p_fcode
      plvar                    = p_plvar
      otype                    = p_otype
      objid                    = p_objid
      with_base_ac             = p_base_ac
    EXCEPTIONS
      no_stru_authority        = 1
      no_stru_authority_hyper  = 2
      no_stru_authority_at_all = 3
      no_base_authority        = 4
      OTHERS                   = 5.
  IF sy-subrc <> 0.
    p_subrc = sy-subrc.
  ENDIF.

ENDFORM.                    " stru_authority_check
*&--------------------------------------------------------------------*
*&      Form  check_isnum
*&--------------------------------------------------------------------*
*       Verifica se uma string é numérica
*---------------------------------------------------------------------*
*      -->P_NUMC     Sequência de caracteres
*      -->P_SUBRC    Código de retorno (0=numérico; 4=não numérico)
*---------------------------------------------------------------------*
FORM check_isnum USING    p_numc  TYPE c
                 CHANGING p_subrc TYPE sysubrc.

  DATA l_i TYPE i.                                          "#EC NEEDED

  CATCH SYSTEM-EXCEPTIONS convt_no_number = 4.
    l_i = p_numc.
  ENDCATCH.
  p_subrc = sy-subrc.

ENDFORM.                               " check_isnum
*&---------------------------------------------------------------------*
*&      Form  read_object
*&---------------------------------------------------------------------*
*       Lê os dados de um objeto de PD
*----------------------------------------------------------------------*
*      -->P_PLVAR     Planejamento ativo
*      -->P_OTYPE     Type de objeto
*      -->P_OBJID     ID de objeto
*      -->P_DATUM     Date de busca
*      <--P_OBJEC     Dados do objeto retornado
*----------------------------------------------------------------------*
FORM read_object  USING    p_plvar LIKE objec-plvar
                           p_otype TYPE any
                           p_objid TYPE any
                           p_datum TYPE datum
                  CHANGING p_objec TYPE objec.

  DATA l_objid LIKE objec-objid.
  DATA l_begda LIKE objec-begda.
  DATA l_endda LIKE objec-endda.
  DATA l_istat LIKE objec-istat.
  DATA l_histo LIKE objec-histo.
  DATA l_short LIKE objec-short.
  DATA l_stext LIKE objec-stext.

  MOVE p_objid TO l_objid.

  CALL FUNCTION 'RH_READ_OBJECT'
    EXPORTING
      plvar                 = p_plvar
      otype                 = p_otype
      objid                 = l_objid
*     REALO                 = ' '
*     ISTAT                 = ' '
      begda                 = p_datum
      endda                 = p_datum
*     LANGU                 = SY-LANGU
*     OINTERVAL             = 'X'
*     STORE                 = 'X'
*     CHECK_STRU_AUTH       = 'X'
*     READ_DB               = ' '
    IMPORTING
      obeg                  = l_begda
      oend                  = l_endda
      ostat                 = l_istat
      histo                 = l_histo
      short                 = l_short
      stext                 = l_stext
*     TISTAT                =
*     TLANGU                =
*     DISPLAY_TEXT          =
*   TABLES
*     EXISTENCE             =
    EXCEPTIONS
      not_found             = 1
      OTHERS                = 2
            .
  IF sy-subrc <> 0.
    CLEAR p_objec.
  ELSE.
    MOVE p_plvar TO p_objec-plvar.
    MOVE p_otype TO p_objec-otype.
    MOVE p_objid TO p_objec-objid.
    MOVE l_begda TO p_objec-begda.
    MOVE l_endda TO p_objec-endda.
    MOVE l_istat TO p_objec-istat.
    MOVE l_histo TO p_objec-histo.
    MOVE l_short TO p_objec-short.
    MOVE l_stext TO p_objec-stext.
  ENDIF.

ENDFORM.                    " read_object
*&---------------------------------------------------------------------*
*&      Form  read_object_set
*&---------------------------------------------------------------------*
*       Lê um conjunto de objetos PD
*----------------------------------------------------------------------*
*      -->P_OBJID[fusion_builder_container hundred_percent="yes" overflow="visible"]
*[fusion_builder_row][fusion_builder_column type="1_1" background_position="left top"
* background_color="" border_size="" border_color="" border_style="solid"
*spacing="yes" background_image="" background_repeat="no-repeat" padding="" margin_top="0px"
* margin_bottom="0px" class="" id="" animation_type="" animation_speed="0.3"
* animation_direction="left" hide_on_mobile="no" center_content="no"
*min_height="none"][]
*Lista de objetos para ler
*      -->P_BEGDA       Date de início
*      -->P_ENDDA       Date de fim
*      <--P_OBJEC[]     Lista de objetos retornada
*      <--P_SUBRC       Código de retorno
*----------------------------------------------------------------------*
FORM read_object_set  USING    p_objid   TYPE hrtb_objkey
                               p_begda   TYPE sydatum
                               p_endda   TYPE sydatum
                      CHANGING p_objec   TYPE objec_t
                               p_subrc   TYPE sysubrc.

  CALL FUNCTION 'RH_READ_OBJECT_SET'
    EXPORTING
      objid_tab                 = p_objid
*     REALO_TAB                 =
      begda                     = p_begda
      endda                     = p_endda
*     LANGU                     = SY-LANGU
*     CHECK_STRU_AUTH           = 'X'
*     READ_DB                   = ' '
    IMPORTING
      text_tab                  = p_objec
    EXCEPTIONS
      no_objects_supplied       = 1
      nothing_found             = 2
      OTHERS                    = 3
            .
  p_subrc = sy-subrc.
  IF sy-subrc <> 0.
    CLEAR p_objec.
    REFRESH p_objec.
  ENDIF.

ENDFORM.                    " read_object_set
*&--------------------------------------------------------------------*
*&      Form  PROGRESS
*&--------------------------------------------------------------------*
*       Exibe uma mensagem na barra de status
*---------------------------------------------------------------------*
*      -->P_TEXT     Texte à afficher
*---------------------------------------------------------------------*
FORM progress USING p_text TYPE c.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
*     PERCENTAGE       = 0
      text             = p_text
            .

ENDFORM.                               " PROGRESS
*&--------------------------------------------------------------------*
*&      Form  convert_to_currency
*&--------------------------------------------------------------------*
*       Realizar uma conversão de moeda para uma determinada quantidade
*---------------------------------------------------------------------*
*      -->P_FROM_WAERS   Moeda original
*      -->P_FROM_AMOUNT  Valor original
*      -->P_TO_WAERS     Moeda a ser convertida
*      <--P_TO_AMOUNT    Valor convertido
*      <--P_SUBRC        Código de retorno
*---------------------------------------------------------------------*
FORM convert_to_currency  USING    p_from_waers  TYPE waers
                                   p_from_amount TYPE any
                                   p_to_waers    TYPE waers
                          CHANGING p_to_amount   TYPE any
                                   p_subrc       TYPE sysubrc.

  CHECK p_from_waers NE p_to_waers.

  CALL FUNCTION 'CONVERT_TO_FOREIGN_CURRENCY'
    EXPORTING
*     CLIENT                  = SY-MANDT
      date                    = sy-datum
      foreign_currency        = p_to_waers
      local_amount            = p_from_amount
      local_currency          = p_from_waers
*     RATE                    = 0
*     TYPE_OF_RATE            = 'M'
*     READ_TCURR              = 'X'
    IMPORTING
*     EXCHANGE_RATE           =
      foreign_amount          = p_to_amount
*     FOREIGN_FACTOR          =
*     LOCAL_FACTOR            =
*     EXCHANGE_RATEX          =
*     DERIVED_RATE_TYPE       =
*     FIXED_RATE              =
    EXCEPTIONS
      no_rate_found           = 1
      overflow                = 2
      no_factors_found        = 3
      no_spread_found         = 4
      derived_2_times         = 5
      OTHERS                  = 6
            .
  p_subrc = sy-subrc.

ENDFORM.                    " convert_to_currency
*&--------------------------------------------------------------------*
*&      Form  insert_infty
*&--------------------------------------------------------------------*
*       Insere dados em um infotipo
*---------------------------------------------------------------------*
*      -->P_PNNNN    Dados do infotipo
*      <--P_SUBRC    Código de retorno
*---------------------------------------------------------------------*
FORM insert_infty  TABLES   p_pnnnn
                   CHANGING p_subrc TYPE sysubrc.

  CALL FUNCTION 'RH_INSERT_INFTY'
    EXPORTING
*     FCODE                     = 'INSE'
      vtask                     = 'D'
*     ORDER_FLG                 = 'X'
*     COMMIT_FLG                = 'X'
*     AUTHY                     = 'X'
*     PPPAR_IMP                 =
*     OLD_TABNR                 = ' '
*     REPID                     = ' '
*     FORM                      = ' '
*     KEEP_LUPD                 =
*     WORKF_ACTV                = 'X'
    TABLES
      innnn                     = p_pnnnn
*     ILFCODE                   =
    EXCEPTIONS
      no_authorization          = 1
      error_during_insert       = 2
      repid_form_initial        = 3
      corr_exit                 = 4
      begda_greater_endda       = 5
      OTHERS                    = 6
            .
  p_subrc = sy-subrc.

ENDFORM.                    " insert_infty
*&--------------------------------------------------------------------*
*&      Form  adata_to_pad
*&--------------------------------------------------------------------*
*       Transferência de um tipo ADATA para uma estrutura do tipo PAD
*---------------------------------------------------------------------*
*      -->P_ADATA    Tipo de dados ADATA
*      -->P_PADNN    Estrutura do tipo PAD
*---------------------------------------------------------------------*
FORM adata_to_pad  USING    p_adata TYPE adata
                   CHANGING p_padnn TYPE any.

  CALL METHOD cl_hr_adata_type_cast=>adata_to_padnn
    EXPORTING
      adata = p_adata
    IMPORTING
      padnn = p_padnn.

ENDFORM.                    " adata_to_pad
*&--------------------------------------------------------------------*
*&      Form  pad_to_adata
*&--------------------------------------------------------------------*
*       Transferência de um tipo PAD para um tipo ADATA
*---------------------------------------------------------------------*
*      -->P_PADNN    Estrutura do tipo PAD
*      -->P_ADATA    Tipo de dados ADATA
*---------------------------------------------------------------------*
FORM pad_to_adata  USING    p_padnn TYPE any
                   CHANGING p_adata TYPE adata.

  CALL METHOD cl_hr_adata_type_cast=>padnn_to_adata
    EXPORTING
      padnn = p_padnn
    IMPORTING
      adata = p_adata.

ENDFORM.                    " pad_to_adata
*&---------------------------------------------------------------------*
*&      Form  check_file_exists
*&---------------------------------------------------------------------*
*       Veririca a existência de um arquivo, tanto no servidor de
*       aplicação ou de apresentação
*----------------------------------------------------------------------*
*      -->P_FNAME    Nome do arquivo
*      -->P_PC       'X'= arquivo local
*      <--P_SUBRC    <>0 = o arquivo não existe
*----------------------------------------------------------------------*
FORM check_file_exists  USING    p_fname TYPE any
                                 p_pc TYPE c
                        CHANGING p_subrc TYPE sysubrc.

  DATA l_flag TYPE xflag.
  DATA l_fname TYPE dxfilename.

  p_subrc = 4.
  l_fname = p_fname.

  CALL FUNCTION 'DX_FILE_EXISTENCE_CHECK'
    EXPORTING
      filename             = l_fname
      pc                   = p_pc
*     SERVER               =
    IMPORTING
      file_exists          = l_flag
    EXCEPTIONS
      rfc_error            = 1
      frontend_error       = 2
      no_authority         = 3
      OTHERS               = 4
          .
  IF sy-subrc <> 0.
    MOVE sy-subrc TO p_subrc.
  ELSE.
    IF l_flag NE space.
      CLEAR p_subrc.
    ENDIF.
  ENDIF.

ENDFORM.                    " check_file_exists
*&---------------------------------------------------------------------*
*&      Form  f4_objid
*&---------------------------------------------------------------------*
*       Ajuda de Pesquisa em todos os tipos de objetos OM
*----------------------------------------------------------------------*
*      -->P_PLVAR    Planejamento ativo
*      -->P_OTYPE    Tipo de objeto
*      -->P_SEARK    Sequência de busca
*      -->P_BEGDA    Data de início
*      -->P_ENDDA    Date de fim
*      <--P_OBJEC    Objeto retornado
*      <--P_SUBRC    Código de retorno
*----------------------------------------------------------------------*
FORM f4_objid USING    p_plvar TYPE plvar
                       p_otype TYPE any
                       p_seark TYPE any
                       p_begda TYPE begda
                       p_endda TYPE endda
              CHANGING p_objec TYPE objec
                       p_subrc TYPE sysubrc.

  DATA l_otype TYPE otype.
  DATA l_seark TYPE seark.

  MOVE p_otype TO l_otype.
  MOVE p_seark TO l_seark.

  CALL FUNCTION 'RH_OBJID_REQUEST'
    EXPORTING
      plvar                   = p_plvar
      otype                   = l_otype
      seark                   = l_seark
      seark_begda             = p_begda
      seark_endda             = p_endda
*     SET_MODE                = ' '
*     DYNPRO_REPID            = ' '
*     DYNPRO_DYNNR            = ' '
*     DYNPRO_PLVARFIELD       = ' '
*     DYNPRO_OTYPEFIELD       = ' '
*     DYNPRO_SEARKFIELD       = ' '
*     CALLBACK_PROG           = ' '
*     CALLBACK_FORM           = ' '
*     RESTRICT_FB             = ' '
*     RESTRICT_DATA           = ' '
*     WITHOUT_RSIGN           =
*     WITHOUT_RELAT           =
*     WITHOUT_SCLAS           =
*     ORGBEG                  = SY-DATUM
*     ORGEND                  = SY-DATUM
*     WIN_TITLE               =
*     APP_DATA                =
    IMPORTING
*     SEL_PLVAR               =
*     SEL_OTYPE               =
      sel_object              = p_objec
*   TABLES
*     OTYPE_TABLE             =
*     CONDITION               =
*     BASE_OBJECTS            =
*     MARKED_OBJECTS          =
*     SEL_OBJECTS             =
*     SEL_HROBJECT_TAB        =
*     SEL_HRSOBID_TAB         =
    EXCEPTIONS
      cancelled               = 1
      wrong_condition         = 2
      nothing_found           = 3
      internal_error          = 4
      illegal_mode            = 5
      OTHERS                  = 6
            .
  IF sy-subrc <> 0.
    MOVE sy-subrc TO p_subrc.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ELSE.
    CLEAR p_subrc.
  ENDIF.

ENDFORM.                                                    "f4_objid
*&---------------------------------------------------------------------*
*&      Form  f4_maco
*&---------------------------------------------------------------------*
*       Conversão de um objeto de código para um objeto identificador OM
*----------------------------------------------------------------------*
*      -->P_PLVAR  Planejamento ativo
*      -->P_OTYPE  Tipo de objeto
*      -->P_SEARK  Texto de pesquisa retornado pelo objeto pesquisado
*      <--P_OBJEC  Objeto retornado
*      <--P_SUBRC  Código de retorno
*----------------------------------------------------------------------*
FORM f4_maco  USING    p_plvar TYPE plvar
                       p_otype TYPE any
                       p_seark TYPE any
              CHANGING p_objec TYPE objec
                       p_subrc TYPE sysubrc.

  DATA l_otype TYPE otype.
  DATA l_seark TYPE seark.

  p_subrc = 4.

  CHECK p_seark IS NOT INITIAL.

  MOVE p_otype TO l_otype.
  MOVE p_seark TO l_seark.

  CALL FUNCTION 'RH_MACO'
    EXPORTING
      seark                     = l_seark
*     SEARK_TEXT                = ' '
*     WIN_TITLE                 = ' '
*     LIST_HEADER               = ' '
      plvar                     = p_plvar
      otype                     = l_otype
*     CALLBACK_PROG             = ' '
*     CALLBACK_FORM             = ' '
*     RESTRICT_FB               = ' '
*     RESTRICT_DATA             = ' '
*     FORGET_BASE_OBJECTS       = ' '
*     PFKEY                     = ' '
*     LANGU                     = SY-LANGU
*     LANGU_MODE                = ' '
*     SET_MODE                  = ' '
*     SELECT_MESSAGE            = ' '
*     NO_DIALOG                 = ' '
*     NO_GENERIC_WARNING        = ' '
*     ORGBEG                    = SY-DATUM
*     ORGEND                    = SY-DATUM
*     NO_NEW_ENTRIES            = ' '
*     ENABLE_NEW_SHELP          = ' '
    IMPORTING
      sel_object                = p_objec
*     USED_FCODE                =
*   TABLES
*     OTYPE_TAB                 =
*     CONDITION                 =
*     BASE_OBJECTS              =
*     SEL_OBJECTS               =
*     MARKED_OBJECTS            =
*     F4_LIST                   =
    EXCEPTIONS
      f15                       = 1
      wrong_condition           = 2
      nothing_found             = 3
      OTHERS                    = 4
            .
  IF sy-subrc <> 0.
    MOVE sy-subrc TO p_subrc.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ELSE.
    CLEAR p_subrc.
  ENDIF.

ENDFORM.                                                    " f4_maco
*&---------------------------------------------------------------------*
*&      Form  dynp_read
*&---------------------------------------------------------------------*
*       Lendo as áreas de conteúdo a partir de um Dynpro
*----------------------------------------------------------------------*
*      -->P_REPID    Programa em questão
*      -->P_DYNNR    Dynpro em questão
*      <--P_FIELDS   Áreas de tela para ler, então leia
*      <--P_SUBRC    Código de retorno
*----------------------------------------------------------------------*
FORM dynp_read USING    p_repid TYPE syrepid
                        p_dynnr TYPE sydynnr
               CHANGING p_fields TYPE dynpread_tabtype
                        p_subrc TYPE sysubrc.

  CALL FUNCTION 'DYNP_VALUES_READ'
    EXPORTING
      dyname                       = p_repid
      dynumb                       = p_dynnr
*     TRANSLATE_TO_UPPER           = ' '
*     REQUEST                      = ' '
*     PERFORM_CONVERSION_EXITS     = ' '
*     PERFORM_INPUT_CONVERSION     = ' '
*     DETERMINE_LOOP_INDEX         = ' '
  TABLES
    dynpfields                     = p_fields
  EXCEPTIONS
    invalid_abapworkarea           = 1
    invalid_dynprofield            = 2
    invalid_dynproname             = 3
    invalid_dynpronummer           = 4
    invalid_request                = 5
    no_fielddescription            = 6
    invalid_parameter              = 7
    undefind_error                 = 8
    double_conversion              = 9
    stepl_not_found                = 10
    OTHERS                         = 11
            .
  IF sy-subrc <> 0.
    MOVE sy-subrc TO p_subrc.
  ELSE.
    CLEAR p_subrc.
  ENDIF.

ENDFORM. "dynp_read
*&---------------------------------------------------------------------*
*&      Form  dynp_update
*&---------------------------------------------------------------------*
*       Atualização de áreas de tela sem passar pelo PBO
*----------------------------------------------------------------------*
*      -->P_REPID    Programa em questão
*      -->P_DYNNR    Dynpro em questão
*      -->P_FIELDS   Áreas de tela para atualizar
*      <--P_SUBRC    Código de retorno
*----------------------------------------------------------------------*
FORM dynp_update USING    p_repid TYPE syrepid
                          p_dynnr TYPE sydynnr
                          p_fields TYPE dynpread_tabtype
                 CHANGING p_subrc TYPE sysubrc.

  CALL FUNCTION 'DYNP_VALUES_UPDATE'
    EXPORTING
      dyname               = p_repid
      dynumb               = p_dynnr
    TABLES
      dynpfields           = p_fields
    EXCEPTIONS
      invalid_abapworkarea = 1
      invalid_dynprofield  = 2
      invalid_dynproname   = 3
      invalid_dynpronummer = 4
      invalid_request      = 5
      no_fielddescription  = 6
      undefind_error       = 7
      OTHERS               = 8.
  IF sy-subrc <> 0.
    MOVE sy-subrc TO p_subrc.
  ELSE.
    CLEAR p_subrc.
  ENDIF.

ENDFORM. "dynp_update
