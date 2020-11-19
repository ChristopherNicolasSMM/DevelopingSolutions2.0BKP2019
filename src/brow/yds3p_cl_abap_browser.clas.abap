class YDS3P_CL_ABAP_BROWSER definition
  public
  final
  create private .

public section.
*"* public components of class YDS3P_CL_ABAP_BROWSER
*"* do not include other source files here!!!
  type-pools ABAP .

  types:
    html_line TYPE c LENGTH 255 .
  types:
    html_table TYPE STANDARD TABLE OF html_line WITH NON-UNIQUE KEY table_line .
  types:
    BEGIN OF load_tab_line,
                   name TYPE string,
                   type TYPE string,
                   dref TYPE REF TO data,
            END OF load_tab_line .
  types:
    load_tab TYPE STANDARD TABLE OF load_tab_line .
  types:
    title TYPE c LENGTH 255 .

  constants:
    navigate_html TYPE c LENGTH 1 value 'X' ##NO_TEXT.
  constants NAVIGATE_HTML_AFTER_SAP_EVENT like NAVIGATE_HTML value 'E' ##NO_TEXT.
  constants NAVIGATE_OFF like NAVIGATE_HTML value ' ' ##NO_TEXT.
  constants SMALL type STRING value 'S' ##NO_TEXT.
  constants MEDIUM type STRING value 'M' ##NO_TEXT.
  constants LARGE type STRING value 'L' ##NO_TEXT.
  constants XLARGE type STRING value 'XL' ##NO_TEXT.
  constants PORTRAIT type STRING value 'P' ##NO_TEXT.
  constants LANDSCAPE type STRING value 'L' ##NO_TEXT.
  constants TOPLEFT type STRING value 'TL' ##NO_TEXT.
  constants MIDDLE type STRING value 'M' ##NO_TEXT.

  class-events SAPEVENT
    exporting
      value(ACTION) type STRING .
  class-events CLOSED .

  class-methods CLASS_CONSTRUCTOR .
  class-methods SHOW_HTML
    importing
      !HTML type CL_ABAP_BROWSER=>HTML_TABLE optional
      !TITLE type CL_ABAP_BROWSER=>TITLE optional
      !SIZE type STRING default CL_ABAP_BROWSER=>MEDIUM
      !MODAL type ABAP_BOOL default ABAP_TRUE
      !HTML_STRING type STRING optional
      !PRINTING type ABAP_BOOL default ABAP_FALSE
      !BUTTONS like NAVIGATE_HTML default NAVIGATE_OFF
      !FORMAT type STRING default CL_ABAP_BROWSER=>LANDSCAPE
      !POSITION type STRING default CL_ABAP_BROWSER=>TOPLEFT
      !DATA_TABLE type LOAD_TAB optional
      !ANCHOR type STRING optional
      !CONTEXT_MENU type ABAP_BOOL default ABAP_FALSE
      !HTML_XSTRING type XSTRING optional
      !CHECK_HTML type ABAP_BOOL default ABAP_TRUE
      !CONTAINER type ref to CL_GUI_CONTAINER optional
    exporting
      !HTML_ERRORS type STANDARD TABLE .
  class-methods SHOW_XML
    importing
      !XML_STRING type STRING optional
      !XML_XSTRING type XSTRING optional
      !TITLE type CL_ABAP_BROWSER=>TITLE optional
      !SIZE type STRING default CL_ABAP_BROWSER=>MEDIUM
      !MODAL type ABAP_BOOL default ABAP_TRUE
      !PRINTING type ABAP_BOOL default ABAP_FALSE
      !BUTTONS like NAVIGATE_HTML default NAVIGATE_OFF
      !FORMAT type STRING default CL_ABAP_BROWSER=>LANDSCAPE
      !POSITION type STRING default CL_ABAP_BROWSER=>TOPLEFT
      !CONTEXT_MENU type ABAP_BOOL default ABAP_FALSE
      !CONTAINER type ref to CL_GUI_CONTAINER optional
    preferred parameter XML_STRING .
  class-methods CLOSE_BROWSER .
  class-methods SHOW_URL
    importing
      !URL type CSEQUENCE
      !TITLE type CL_ABAP_BROWSER=>TITLE optional
      !SIZE type STRING default CL_ABAP_BROWSER=>MEDIUM
      !MODAL type ABAP_BOOL default ABAP_TRUE
      !PRINTING type ABAP_BOOL default ABAP_FALSE
      !BUTTONS like NAVIGATE_HTML default NAVIGATE_OFF
      !FORMAT type STRING default CL_ABAP_BROWSER=>LANDSCAPE
      !POSITION type STRING default CL_ABAP_BROWSER=>TOPLEFT
      !CONTAINER type ref to CL_GUI_CONTAINER optional
      !CONTEXT_MENU type ABAP_BOOL default ABAP_FALSE .
  methods CREATE_BROWSER
    importing
      !CONTAINER type ref to CL_GUI_CONTAINER optional .
  methods CLEAR_BROWSER .
  PROTECTED SECTION.
private section.
*"* private components of class YDS3P_CL_ABAP_BROWSER
*"* do not include other source files here!!!

  types:
    x255 TYPE x LENGTH 255 .
  types:
    xmltab TYPE STANDARD TABLE OF x255 .
  types:
    BEGIN OF url_line,
          name TYPE string,
          url  TYPE string,
        END OF url_line .
  types:
    url_tab TYPE SORTED TABLE OF url_line WITH UNIQUE KEY name .
  types:
    xhtml_line TYPE x LENGTH 1022 .

  data HTML_ERRORS type HTML_TABLE .
  data BROWSER_BOX type ref to CL_GUI_DIALOGBOX_CONTAINER .
  data BROWSER_BAR type ref to CL_GUI_TOOLBAR .
  data BROWSER_CONTAINER type ref to CL_GUI_CONTAINER .
  data BROWSER_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER .
  data BROWSER_TOOL type ref to CL_GUI_CONTAINER .
  data BROWSER type ref to CL_GUI_HTML_VIEWER .
  class-data BROWSER_TITLE type CHAR255 .
  class-data BROWSER_SIZE type STRING .
  class-data BROWSER_FORMAT type STRING .
  class-data BROWSER_POSITION type STRING .
  class-data:
    nav_tab            TYPE TABLE OF char255 .
  data NAV_INDEX type I .
  data MODAL type ABAP_BOOL .
  class-data HANDLE type ref to yds3p_CL_ABAP_BROWSER .
  class yds3p_CL_ABAP_BROWSER definition load .
  data HTML type yds3p_CL_ABAP_BROWSER=>HTML_TABLE .
  data XML_TAB type XMLTAB .
  data PRINTING type ABAP_BOOL .
  data BUTTONS like NAVIGATE_HTML .
  data DATA_TABLE type LOAD_TAB .
  data URLS type URL_TAB .
  data ANCHOR type STRING .
  data CONTEXT_MENU type ABAP_BOOL .
  data SAP_EVENT_FLAG type ABAP_BOOL .
  data XHTML_SIZE type I .
  data:
    xhtml TYPE TABLE OF xhtml_line .
  data HTML_CHECK type ABAP_BOOL value 'X'. "#EC NOTEXT .
  data CHECKER type ref to CL_HTMLTIDY .
  data EXT_CONTAINER type ref to CL_GUI_CONTAINER .
  data EXT_URL type STRING .

  methods HANDLE_NAV_TAB
    importing
      !ENTRY type CSEQUENCE .
  methods FILL_BROWSER .
  methods FILL_BROWSER_WITH_XML .
  methods HANDLE_BROWSER_BAR
    for event FUNCTION_SELECTED of CL_GUI_TOOLBAR
    importing
      !FCODE .
  methods HANDLE_HTML_LOAD
    for event NAVIGATE_COMPLETE of CL_GUI_HTML_VIEWER
    importing
      !URL .
  methods SET_BUTTONS .
  class yds3p_CL_ABAP_BROWSER definition load .
  methods SET_TITLE_AND_SIZE
    importing
      !TITLE type yds3p_CL_ABAP_BROWSER=>TITLE
      !SIZE type STRING
      !FORMAT type STRING
      !POSITION type STRING .
  methods HANDLE_SAPEVENT
    for event SAPEVENT of CL_GUI_HTML_VIEWER
    importing
      !ACTION .
  methods SHOW_HTML_VIA_HANDLE
    importing
      !HTML type yds3p_CL_ABAP_BROWSER=>HTML_TABLE
      !TITLE type yds3p_CL_ABAP_BROWSER=>TITLE
      !SIZE type STRING
      !MODAL type ABAP_BOOL optional
      !HTML_STRING type STRING optional
      !FORMAT type STRING
      !POSITION type STRING
      !HTML_XSTRING type XSTRING optional .
  methods SHOW_XML_VIA_HANDLE
    importing
      !XML_STRING type STRING optional
      !XML_XSTRING type XSTRING optional
      !TITLE type yds3p_CL_ABAP_BROWSER=>TITLE
      !SIZE type STRING
      !MODAL type ABAP_BOOL optional
      !FORMAT type STRING
      !POSITION type STRING .
  methods PREPARE_BROWSER .
  methods REUSE_BROWSER .
  methods BUILD_HTML
    importing
      !HTML_STRING type STRING .
  methods HANDLE_BROWSER_CLOSE
    for event CLOSE of CL_GUI_DIALOGBOX_CONTAINER .
  methods BUILD_XHTML
    importing
      !HTML_XSTRING type XSTRING .
  methods HANDLE_EXTERNAL_DATA .
  methods CHECK_HTML
    importing
      value(HTML) type HTML_TABLE optional
      value(XHTML) like XHTML optional .
  methods CREATE_CHECKER .
  methods SHOW_URL_VIA_HANDLE
    importing
      !TITLE type yds3p_CL_ABAP_BROWSER=>TITLE
      !SIZE type STRING default yds3p_CL_ABAP_BROWSER=>MEDIUM
      !MODAL type ABAP_BOOL default ABAP_TRUE
      !FORMAT type STRING default yds3p_CL_ABAP_BROWSER=>LANDSCAPE
      !POSITION type STRING default yds3p_CL_ABAP_BROWSER=>TOPLEFT .
  methods FILL_BROWSER_WITH_URL .
ENDCLASS.



CLASS YDS3P_CL_ABAP_BROWSER IMPLEMENTATION.


  METHOD BUILD_HTML.
    DATA html_line LIKE LINE OF html.
    DATA length TYPE i.
    DATA pos    TYPE i.
    DATA html_str TYPE string.
    CLEAR me->html.
    CLEAR me->xhtml.
    html_str = html_string.
    DESCRIBE FIELD html_line LENGTH length IN CHARACTER MODE.
    pos = strlen( html_str ).
    WHILE pos > length.
      APPEND html_str(length) TO me->html.
      SHIFT html_str LEFT BY length PLACES.
      SUBTRACT length FROM pos.
    ENDWHILE.
    APPEND html_str TO me->html.
  ENDMETHOD.


  METHOD BUILD_XHTML.

    DATA length TYPE i.
    DATA html_xstr TYPE xstring.

    CLEAR me->html.
    CLEAR me->xhtml.
    CLEAR me->xhtml_size.

    html_xstr = html_xstring.
    length = xstrlen( html_xstr ).

    WHILE  length >= 1022.
      APPEND html_xstr(1022) TO xhtml.
      xhtml_size = xhtml_size + 1022.
      SHIFT html_xstr BY 1022 PLACES LEFT IN BYTE MODE.
      length = xstrlen( html_xstr ).
    ENDWHILE.

    IF length > 0.
      APPEND html_xstr TO xhtml.
      xhtml_size = xhtml_size + length.
    ENDIF.

  ENDMETHOD.


  METHOD CHECK_HTML.
    DATA buffer LIKE LINE OF html.
    DATA xbuffer LIKE LINE OF xhtml.
    DATA html_string  TYPE string.
    DATA html_xstring TYPE xstring.
    DATA error_string TYPE string.

    CLEAR html_errors.

    IF html IS NOT INITIAL.
      LOOP AT html INTO buffer.
        CONCATENATE html_string  buffer INTO html_string RESPECTING BLANKS.
      ENDLOOP.
      html_xstring = yds3p_cl_abap_codepage=>convert_to(
        source      = html_string
        codepage    = `UTF-8` ).
    ELSEIF xhtml IS NOT INITIAL.
      LOOP AT xhtml INTO xbuffer.
        CONCATENATE html_xstring  xbuffer INTO html_xstring IN BYTE MODE.
      ENDLOOP.
    ELSE.
      RETURN.
    ENDIF.

    create_checker( ).

    checker->repair( EXPORTING input = html_xstring
                               diagnostics = 'X'
                     IMPORTING errors      = error_string ).

    SPLIT error_string AT '\n' INTO TABLE html_errors.

    DELETE html_errors WHERE table_line IS INITIAL.

    "Show only errors
    DELETE html_errors WHERE table_line NS 'Error:'.        "#EC NOTEXT

    "The following seems to be a bug in the HTMLTIDY accessibility checks, since a given <!doctype> is not recognized
    DELETE html_errors WHERE table_line CS '<doctype> missing'. "#EC NOTEXT

    IF html_errors IS NOT INITIAL.
      APPEND ' ' TO html_errors.
      APPEND 'For more information see documentation of Method SHOW_HTML in CL_ABAP_BROWSER.'
             TO html_errors.                                "#EC NOTEXT
    ENDIF.
  ENDMETHOD.                                             "#EC CI_VALPAR


  METHOD CLASS_CONSTRUCTOR.
    CREATE OBJECT handle TYPE yds3p_cl_abap_browser.
  ENDMETHOD.


  METHOD CLEAR_BROWSER.

    handle_browser_close( ).

  ENDMETHOD.


  METHOD CLOSE_BROWSER.
    "IF handle->browser IS INITIAL.
    "  RETURN.
    "ENDIF.
    IF handle->modal IS INITIAL OR
       handle->ext_container IS NOT INITIAL.
      handle->clear_browser( ).
    ELSE.
      cl_gui_cfw=>set_new_ok_code( 'CANCEL' ).
      cl_gui_cfw=>flush( ).
    ENDIF.
  ENDMETHOD.


  METHOD CREATE_BROWSER.
    DATA: browser_width TYPE i,
          browser_height TYPE i,
          browser_top TYPE i,
          browser_left TYPE i,
          ui_flag TYPE i.

    DATA: events TYPE cntl_simple_events,
          event LIKE LINE OF events,
          quickinfo TYPE iconquick.

    IF container IS INITIAL.
      IF browser_box IS INITIAL.
        CASE browser_position.
          WHEN middle.
            browser_top = 75.
            browser_left = 500.
          WHEN OTHERS.
            browser_top = 10.
            browser_left = 50.
        ENDCASE.
        IF browser_format = portrait.
          CASE browser_size.
            WHEN small.
              browser_width  = 440.
              browser_height = 300.
            WHEN large.
              browser_width  = 830.
              browser_height = 560.
            WHEN xlarge.
              browser_width  = 1000.
              browser_height = 670.
            WHEN OTHERS.
              browser_width  = 660.
              browser_height = 450.
          ENDCASE.
        ELSE.
          CASE browser_size.
            WHEN small.
              browser_width  = 660.
              browser_height = 200.
            WHEN large.
              browser_width  = 1250.
              browser_height = 375.
            WHEN xlarge.
              browser_width  = 1500.
              browser_height = 450.
            WHEN OTHERS.
              browser_width  = 1000.
              browser_height = 300.
          ENDCASE.
        ENDIF.
        CREATE OBJECT browser_box
          EXPORTING
            parent                  = cl_gui_container=>desktop
            width                   = browser_width
            height                  = browser_height
            top                     = browser_top
            left                    = browser_left
            caption                 = browser_title
            no_autodef_progid_dynnr = 'X'.
        SET HANDLER handle_browser_close FOR browser_box ACTIVATION 'X'.
      ENDIF.
    ENDIF.

    IF me->buttons = navigate_off AND me->printing = abap_false.
      IF container IS NOT INITIAL.
        browser_container = container.
      ELSEIF browser_box IS NOT INITIAL.
        browser_container = browser_box.
      ENDIF.

    ELSEIF browser_splitter IS INITIAL.
      IF container IS INITIAL.
        CREATE OBJECT browser_splitter
          EXPORTING
            parent  = browser_box
            rows    = 2
            columns = 1.
      ELSE.
        CREATE OBJECT browser_splitter
          EXPORTING
            parent  = container
            rows    = 2
            columns = 1.
      ENDIF.

      browser_splitter->set_border(
        EXPORTING
          border = cl_gui_cfw=>false
          ).

      browser_splitter->set_row_mode(
        EXPORTING
          mode = browser_splitter->mode_absolute ).

      browser_splitter->set_row_height(
        EXPORTING
          id     = 1
          height = 22 ).

      browser_splitter->set_row_sash(
        EXPORTING
          id           = 1
          type         = browser_splitter->type_movable
          value        = browser_splitter->false  ).

      browser_splitter->set_row_sash(
        EXPORTING
          id           = 2
          type         = browser_splitter->type_movable
          value        = browser_splitter->false ).

      browser_tool =
      browser_splitter->get_container( row = 1 column = 1 ).
      browser_container =
      browser_splitter->get_container( row = 2 column = 1 ).
    ENDIF.

    IF browser_bar IS INITIAL AND browser_tool IS BOUND.
      CREATE OBJECT browser_bar
        EXPORTING
          parent = browser_tool.

      CLEAR events.
      event-eventid = cl_gui_toolbar=>m_id_function_selected.
      event-appl_event = ' '.   "system event, does not trigger PAI
      APPEND event TO events.

      browser_bar->set_registered_events(
        EXPORTING
          events = events
          ).

      SET HANDLER handle_browser_bar FOR browser_bar.

      IF me->printing = abap_true.
        quickinfo = text-pri.
        browser_bar->add_button(
          EXPORTING
            fcode       = 'PRINT'
            butn_type   = 0
            icon        = '@0X@'
            is_disabled = ' '
            quickinfo   = quickinfo
            ).
      ENDIF.

      IF me->buttons <> navigate_off.
        quickinfo = text-bac.
        browser_bar->add_button(
          EXPORTING
            fcode       = 'BACKWARD'
            butn_type   = 0
            icon        = '@0D@'
            is_disabled = 'X'
            quickinfo   = quickinfo
            ).

        quickinfo = text-for.
        browser_bar->add_button(
          EXPORTING
            fcode       = 'FORWARD'
            butn_type   = 0
            icon        = '@0E@'
            is_disabled = 'X'
            quickinfo   = quickinfo
            ).
      ENDIF.
    ENDIF.

    IF browser IS INITIAL.

      IF context_menu IS INITIAL.
        ui_flag = cl_gui_html_viewer=>uiflag_noiemenu.
      ENDIF.

      CREATE OBJECT browser
        EXPORTING
          parent = browser_container
          uiflag = ui_flag.

      CLEAR events.
      event-eventid = browser->m_id_sapevent.
      event-appl_event = ' '.
      APPEND event TO events.

      event-eventid = browser->m_id_navigate_complete.
      event-appl_event = ' '.
      APPEND event TO events.

      browser->set_registered_events(
        EXPORTING
          events = events
          ).
      SET HANDLER handle_sapevent
                  handle_html_load FOR browser.

    ENDIF.

    cl_gui_control=>set_focus( browser ).

    IF html IS NOT INITIAL OR xhtml IS NOT INITIAL.
      fill_browser( ).
    ELSEIF xml_tab IS NOT INITIAL.
      fill_browser_with_xml( ).
    ELSEIF ext_url IS NOT INITIAL.
      fill_browser_with_url( ).
    ENDIF.

  ENDMETHOD.


  METHOD CREATE_CHECKER.
    DATA success        TYPE abap_bool.
    DATA success_string TYPE string.
    DATA cnt            TYPE i.

    checker = cl_htmltidy=>create( ).

    checker->reset_options( IMPORTING success = success ).
    CONCATENATE success_string success INTO success_string.
    cnt = cnt + 1.

    checker->set_option(  EXPORTING option  = 'doctype'
                                    value   = 'strict'
                          IMPORTING success = success ).    "#EC NOTEXT
    CONCATENATE success_string success INTO success_string.
    cnt = cnt + 1.

    checker->set_option(  EXPORTING option  = 'accessibility-check'
                                    value   = '3'
                          IMPORTING success = success ).    "#EC NOTEXT
    CONCATENATE success_string success INTO success_string.
    cnt = cnt + 1.

    checker->set_option(  EXPORTING option  = 'newline'
                                    value   = 'LF'
                          IMPORTING success = success ).    "#EC NOTEXT
    CONCATENATE success_string success INTO success_string.
    cnt = cnt + 1.

    checker->set_option(  EXPORTING option  = 'show-warnings'
                                    value   = '1'
                           IMPORTING success = success ).   "#EC NOTEXT
    CONCATENATE success_string success INTO success_string.
    cnt = cnt + 1.

    checker->set_option(  EXPORTING option  = 'show-errors'
                                    value   = '6'
                           IMPORTING success = success ).   "#EC NOTEXT
    CONCATENATE success_string success INTO success_string.

    cnt = cnt + 1.

    ASSERT strlen( success_string ) = cnt.
  ENDMETHOD.


  METHOD FILL_BROWSER.

    DATA url TYPE c LENGTH 255.

* External data

    IF data_table IS NOT INITIAL.
      handle_external_data( ).
    ENDIF.

* Main document

    IF sap_event_flag = abap_false.
      CLEAR: nav_tab, nav_index.
    ENDIF.

    IF xhtml IS INITIAL.
      IF html_check IS NOT INITIAL.
        check_html( html = html ).
      ENDIF.
      browser->load_data(
       IMPORTING
         assigned_url = url
       CHANGING
         data_table   = html ).
    ELSE.
      IF html_check IS NOT INITIAL.
        check_html( xhtml = xhtml ).
      ENDIF.
      browser->load_data(
        EXPORTING
          size         = xhtml_size
        IMPORTING
          assigned_url = url
        CHANGING
          data_table   = xhtml ).
    ENDIF.

    IF NOT me->anchor IS INITIAL.
      CONCATENATE url '#' me->anchor INTO url.
    ENDIF.

    IF html_errors IS NOT INITIAL AND
       yds3p_cl_abap_docu_system=>system_type = yds3p_cl_abap_docu_system=>sap.
      MESSAGE text-err TYPE 'S' DISPLAY LIKE 'W'.
    ENDIF.

    browser->show_url(
       EXPORTING
         url = url ).

    IF sap_event_flag = abap_false.
      APPEND url TO nav_tab.
      nav_index = sy-tabix.
    ELSE.
      handle_nav_tab( url ).
      sap_event_flag = abap_false.
    ENDIF.

    set_buttons( ).

  ENDMETHOD.


  METHOD FILL_BROWSER_WITH_URL.

    DATA url TYPE c LENGTH 255.

    url = ext_url.

    browser->show_data(
       EXPORTING
         url = url ).

    CLEAR ext_url.

  ENDMETHOD.


  METHOD FILL_BROWSER_WITH_XML.

    DATA url TYPE c LENGTH 255.

    CLEAR: nav_tab, nav_index.

    browser->load_data(
      EXPORTING
        subtype = 'xml'
      IMPORTING
       assigned_url = url
     CHANGING
       data_table   = xml_tab ).

    browser->show_data(
       EXPORTING
         url = url ).

  ENDMETHOD.


  METHOD HANDLE_BROWSER_BAR.

    DATA lines TYPE i.
    DATA nav_wa LIKE LINE OF nav_tab.

    "Printing

    IF fcode = 'PRINT'.
      me->browser->execwb(
       EXPORTING
         cmd_id  = me->browser->wb_cmdid_print ).
      RETURN.
    ENDIF.

    "Navigation

    IF fcode = 'BACKWARD'.
      lines = lines( nav_tab ).
      IF nav_index < lines.
        nav_index = nav_index + 1.
        READ TABLE nav_tab INTO nav_wa INDEX nav_index.
        browser->show_url(
          EXPORTING
            url = nav_wa ).
      ENDIF.
    ELSEIF fcode = 'FORWARD'.
      IF nav_index > 1.
        nav_index = nav_index - 1.
        READ TABLE nav_tab INTO nav_wa INDEX nav_index.
        browser->show_url(
          EXPORTING
            url = nav_wa ).
      ENDIF.
    ELSE.
      RETURN.
    ENDIF.

    set_buttons( ).


  ENDMETHOD.


  METHOD HANDLE_BROWSER_CLOSE.
    IF NOT browser IS INITIAL.
      SET HANDLER handle_html_load FOR browser ACTIVATION ' '.
      browser->free( ).
    ENDIF.

    IF NOT browser_bar IS INITIAL.
      SET HANDLER handle_browser_bar FOR browser_bar ACTIVATION ' '.
      browser_bar->free( ).
    ENDIF.

    IF NOT browser_container IS INITIAL AND ( me->buttons <> navigate_off OR me->printing = abap_true ).
      browser_container->free( ).
    ENDIF.

    IF NOT browser_tool IS INITIAL.
      browser_tool->free( ).
    ENDIF.

    IF NOT browser_splitter IS INITIAL.
      browser_splitter->free( ).
    ENDIF.

    IF NOT browser_box IS INITIAL.
      SET HANDLER handle_browser_close FOR browser_box ACTIVATION ' '.
      browser_box->free( ).
    ENDIF.

    CLEAR: browser,
           browser_bar,
           browser_container,
           browser_tool,
           browser_splitter,
           browser_box,
           ext_container,
           html,
           xml_tab,
           buttons,
           printing,
           data_table,
           urls.

    RAISE EVENT closed.

  ENDMETHOD.


  METHOD HANDLE_EXTERNAL_DATA.
    DATA url_line     TYPE url_line.
    DATA url          TYPE c LENGTH 255.
    DATA type         TYPE c LENGTH 10.
    DATA subtype      TYPE c LENGTH 10.
    DATA html_string  TYPE string.
    DATA html_xstring TYPE xstring.
    DATA xname        TYPE xstring.
    DATA xurl         TYPE xstring.
    DATA surl         TYPE string.

    FIELD-SYMBOLS: <data_line> TYPE load_tab_line,
                   <data>      TYPE STANDARD TABLE.

    IF xhtml IS INITIAL.
      CONCATENATE LINES OF html INTO html_string RESPECTING BLANKS.
    ELSE.
      CONCATENATE LINES OF xhtml INTO html_xstring IN BYTE MODE.
    ENDIF.
    LOOP AT data_table ASSIGNING <data_line>.
      READ TABLE urls WITH TABLE KEY name = <data_line>-name INTO url_line.
      IF sy-subrc = 0.
        url = url_line-url.
      ELSE.
        type    = <data_line>-type.
*        subtype = segment( val = <data_line>-name index = 2 sep = '.' ).
        ASSIGN <data_line>-dref->* TO <data>.
        browser->load_data(
           EXPORTING
             type         = type
             subtype      = subtype
           IMPORTING
             assigned_url = url
           CHANGING
             data_table   = <data> ).
        url_line-name = <data_line>-name.
        url_line-url  = url.
        INSERT url_line INTO TABLE urls.
      ENDIF.
      IF xhtml IS INITIAL.
        REPLACE ALL OCCURRENCES OF <data_line>-name IN html_string WITH url.
      ELSE.
        xname = yds3p_cl_abap_codepage=>convert_to(
          source      = <data_line>-name
          codepage    = `UTF-8` ).
        surl = url.
        xurl = yds3p_cl_abap_codepage=>convert_to(
          source      = surl
          codepage    = `UTF-8` ).
        REPLACE ALL OCCURRENCES OF xname IN html_xstring WITH xurl IN BYTE MODE.
      ENDIF.
    ENDLOOP.
    IF xhtml IS INITIAL.
      build_html( html_string ).
    ELSE.
      build_xhtml( html_xstring ).
    ENDIF.

  ENDMETHOD.


  METHOD HANDLE_HTML_LOAD.

    handle_nav_tab( url ).

    set_buttons( ).

  ENDMETHOD.


  METHOD HANDLE_NAV_TAB.
    DATA  nav_wa  LIKE LINE OF nav_tab.

    IF nav_index > 0.
      READ TABLE nav_tab INTO nav_wa INDEX nav_index.
      IF nav_wa <> entry.
        INSERT entry INTO nav_tab INDEX nav_index.
        nav_index = sy-tabix.
        IF nav_index > 1.
          nav_index = nav_index - 1.
          DELETE nav_tab TO nav_index.
          nav_index = 1.
        ENDIF.
      ENDIF.
    ELSE.
      APPEND entry TO nav_tab.
      nav_index = sy-tabix.
    ENDIF.
  ENDMETHOD.


  METHOD HANDLE_SAPEVENT.
    DATA action_string TYPE string.
    action_string = action.
    IF buttons = navigate_html_after_sap_event.
      sap_event_flag = abap_true.
    ENDIF.
    RAISE EVENT sapevent EXPORTING action = action_string.
  ENDMETHOD.


  METHOD PREPARE_BROWSER.

    IF me->ext_container IS INITIAL.
      IF modal IS INITIAL.
        IF browser IS INITIAL.
          create_browser( ).
        ENDIF.
      ELSE.
        CALL FUNCTION 'ABAP_BROWSER_WINDOW'
          EXPORTING
            handle = me
            title  = me->browser_title
            size   = me->browser_size
            format = me->browser_format.
      ENDIF.
    ELSE.
      create_browser( me->ext_container ).
    ENDIF.

  ENDMETHOD.


  METHOD REUSE_BROWSER.
    IF sap_event_flag = abap_false.
      CLEAR: nav_tab, nav_index.
    ENDIF.
    IF html IS NOT INITIAL OR xhtml IS NOT INITIAL.
      fill_browser( ).
    ELSEIF xml_tab IS NOT INITIAL.
      fill_browser_with_xml( ).
    ELSEIF ext_url IS NOT INITIAL.
      fill_browser_with_url( ).
    ELSE.
      RETURN.
    ENDIF.
    cl_gui_control=>set_focus( browser ).
    cl_gui_cfw=>flush( ).
  ENDMETHOD.


  METHOD SET_BUTTONS.

    CHECK buttons <> navigate_off.

    IF nav_index < lines( nav_tab ).
      browser_bar->set_button_state(
        EXPORTING
          fcode            = 'BACKWARD'
          enabled          = 'X'
        EXCEPTIONS
          cntb_error_fcode = 4 ).
    ELSE.
      browser_bar->set_button_state(
         EXPORTING
           fcode            = 'BACKWARD'
           enabled          = ' '
         EXCEPTIONS
           cntb_error_fcode = 4 ).
    ENDIF.
    IF nav_index > 1.
      browser_bar->set_button_state(
        EXPORTING
          fcode            = 'FORWARD'
          enabled          = 'X'
        EXCEPTIONS
          cntb_error_fcode = 4 ).
    ELSE.
      browser_bar->set_button_state(
        EXPORTING
          fcode            = 'FORWARD'
          enabled          = ' '
        EXCEPTIONS
          cntb_error_fcode = 4 ).
    ENDIF.

    cl_gui_cfw=>flush( ).


  ENDMETHOD.


  METHOD SET_TITLE_AND_SIZE.

    IF title IS INITIAL.
      browser_title = text-tit.
    ELSE.
      browser_title = title.
    ENDIF.

    browser_size   = size.

    browser_format = format.

    browser_position = position.

  ENDMETHOD.


  METHOD SHOW_HTML.

    handle->printing = printing.

    handle->buttons = buttons.

    handle->data_table = data_table.

    handle->anchor = anchor.

    handle->context_menu = context_menu.

    handle->html_check = check_html.

    handle->ext_container = container.

    handle->show_html_via_handle( html                = html
                                  html_string         = html_string
                                  html_xstring        = html_xstring
                                  title               = title
                                  size                = size
                                  format              = format
                                  position            = position
                                  modal               = modal ).

    html_errors = handle->html_errors.

  ENDMETHOD.


  METHOD SHOW_HTML_VIA_HANDLE.

    CLEAR: me->html, me->xml_tab, me->xhtml.

    CLEAR html_errors.

    IF html_string IS INITIAL AND html_xstring IS INITIAL AND html IS NOT INITIAL.
      me->html = html.
    ELSEIF html_string IS NOT INITIAL AND html IS INITIAL AND html_xstring IS INITIAL.
      build_html( html_string ).
    ELSEIF html_string IS INITIAL AND html IS INITIAL AND html_xstring IS NOT INITIAL.
      build_xhtml( html_xstring ).
    ELSEIF html_string IS INITIAL AND html IS INITIAL AND html_xstring IS INITIAL.
      MESSAGE text-xm3 TYPE 'I' DISPLAY LIKE 'E'.
      RETURN.
    ELSE.
      MESSAGE text-xm1 TYPE 'I' DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.

    CLEAR: me->browser.
    FREE: me->browser.
    IF me->browser IS NOT INITIAL.
      reuse_browser( ).
      RETURN.
    ENDIF.

    IF me->ext_container IS INITIAL.
      set_title_and_size( title    = title
                          size     = size
                          format   = format
                          position = position ).
      me->modal = modal.
    ENDIF.


    prepare_browser( ).

  ENDMETHOD.


  METHOD SHOW_URL.

    handle->ext_url = url.

    handle->printing = printing.

    handle->buttons = buttons.

    handle->ext_container = container.

    handle->context_menu = context_menu.

    handle->show_url_via_handle(  title               = title
                                  size                = size
                                  format              = format
                                  position            = position
                                  modal               = modal ).


  ENDMETHOD.


  METHOD SHOW_URL_VIA_HANDLE.

    IF me->browser IS NOT INITIAL.
      reuse_browser( ).
      RETURN.
    ENDIF.

    IF me->ext_container IS INITIAL.
      set_title_and_size( title    = title
                          size     = size
                          format   = format
                          position = position ).
      me->modal = modal.
    ENDIF.

    prepare_browser( ).

  ENDMETHOD.


  METHOD SHOW_XML.

    handle->printing = printing.

    handle->buttons = buttons.

    handle->context_menu = context_menu.

    handle->ext_container = container.

    handle->show_xml_via_handle( xml_string  = xml_string
                                 xml_xstring = xml_xstring
                                 title       = title
                                 size        = size
                                 format      = format
                                 position    = position
                                 modal       = modal ).

  ENDMETHOD.


  METHOD SHOW_XML_VIA_HANDLE.

    CLEAR: me->html, me->xml_tab, me->xhtml.
    TRY.
        IF xml_string IS INITIAL AND xml_xstring IS NOT INITIAL.
          CALL TRANSFORMATION id
               SOURCE XML xml_xstring
               RESULT XML me->xml_tab.
        ELSEIF xml_string IS NOT INITIAL AND xml_xstring IS INITIAL.
          CALL TRANSFORMATION id
               SOURCE XML xml_string
               RESULT XML me->xml_tab.
        ELSEIF xml_string IS INITIAL AND xml_xstring IS INITIAL.
          MESSAGE text-xm3 TYPE 'I' DISPLAY LIKE 'E'.
          RETURN.
        ELSE.
          MESSAGE text-xm1 TYPE 'I' DISPLAY LIKE 'E'.
          RETURN.
        ENDIF.
      CATCH cx_xslt_exception.
        MESSAGE text-xm2 TYPE 'I' DISPLAY LIKE 'E'.
        RETURN.
    ENDTRY.

    IF me->browser IS NOT INITIAL.
      reuse_browser( ).
      RETURN.
    ENDIF.

    IF me->ext_container IS INITIAL.
      set_title_and_size( title    = title
                          size     = size
                          format   = format
                          position = position ).
      me->modal = modal.
    ENDIF.


    prepare_browser( ).

  ENDMETHOD.
ENDCLASS.
