*----------------------------------------------------------------------*
*       CLASS test_abap_browser DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS test_abap_browser DEFINITION FOR TESTING.
*   DURATION SHORT RISK LEVEL HARMLESS FINAL.
  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS test_browser FOR TESTING.
    METHODS handle_sapevent FOR EVENT sapevent OF yds3p_cl_abap_browser.
    DATA handle_flag TYPE abap_bool.
ENDCLASS.                    "test_abap_browser DEFINITION
*----------------------------------------------------------------------*
*       CLASS test_abap_browser IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS test_abap_browser IMPLEMENTATION.
  METHOD test_browser.

    DATA test_handle TYPE REF TO yds3p_cl_abap_browser.
    DATA html_string TYPE string.
    DATA initial_flag TYPE abap_bool.
    DATA linhas TYPE i.

    "SET Title and Size

    test_handle = yds3p_cl_abap_browser=>handle.

    test_handle->set_title_and_size( title    = 'Title'
                                     size     = 'Size'
                                     format   = 'Format'
                                     position = 'Position' ).

    cl_aunit_assert=>assert_equals(
        act   = yds3p_cl_abap_browser=>browser_title
        exp   = 'Title'
        msg   = 'Attribute not set'                         "#EC NOTEXT
        level = cl_aunit_assert=>critical ).

    cl_aunit_assert=>assert_equals(
        act   = yds3p_cl_abap_browser=>browser_size
        exp   = 'Size'
        msg   = 'Attribute not set'                         "#EC NOTEXT
        level = cl_aunit_assert=>critical ).

    cl_aunit_assert=>assert_equals(
        act   = yds3p_cl_abap_browser=>browser_format
        exp   = 'Format'
        msg   = 'Attribute not set'                         "#EC NOTEXT
        level = cl_aunit_assert=>critical ).

    cl_aunit_assert=>assert_equals(
        act   = yds3p_cl_abap_browser=>browser_position
        exp   = 'Position'
        msg   = 'Attribute not set'                         "#EC NOTEXT
        level = cl_aunit_assert=>critical ).

    CLEAR test_handle.

    " Build HTML
    CONCATENATE   '<HTML><BODY>'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  'Test Test Test Test Test Test Test Test Test Test Test'
                  '</BODY></HTML>' INTO html_string.

    test_handle = yds3p_cl_abap_browser=>handle.

    test_handle->build_html( html_string ).

    DESCRIBE TABLE test_handle->html LINES linhas.

    cl_aunit_assert=>assert_equals(
        act   = linhas
        exp   = 3
        msg   = 'HTML table not accurately built'           "#EC NOTEXT
        level = cl_aunit_assert=>critical ).

    CLEAR test_handle.

    " Sapevent

    test_handle = yds3p_cl_abap_browser=>handle.
    SET HANDLER handle_sapevent ACTIVATION 'X'.
    test_handle->handle_sapevent( 'Action' ).

    cl_aunit_assert=>assert_initial(
    act   =  initial_flag
    msg   = 'SAPEvent not handled'                          "#EC NOTEXT
    level = cl_aunit_assert=>critical ).

    CLEAR test_handle.

    " Close Browser

    test_handle = yds3p_cl_abap_browser=>handle.
    test_handle->clear_browser( ).

    IF test_handle->browser IS NOT INITIAL OR
       test_handle->browser_bar IS NOT INITIAL OR
       test_handle->browser_container IS NOT INITIAL OR
       test_handle->browser_tool IS NOT INITIAL OR
       test_handle->browser_splitter IS NOT INITIAL OR
       test_handle->browser_box IS NOT INITIAL OR
       test_handle->html IS NOT INITIAL OR
       test_handle->xml_tab IS NOT INITIAL OR
       test_handle->buttons IS NOT INITIAL OR
       test_handle->data_table IS NOT INITIAL OR
       test_handle->urls IS NOT INITIAL.
      initial_flag = 'X'.
    ENDIF.

    cl_aunit_assert=>assert_not_initial(
    act   =  handle_flag
    msg   = 'Browser not initialized'                       "#EC NOTEXT
    level = cl_aunit_assert=>critical ).

    CLEAR test_handle.


  ENDMETHOD.                    "test_browser
  METHOD handle_sapevent.
    handle_flag = 'X'.
  ENDMETHOD.                    "handle_sapevent
ENDCLASS.                    "test_abap_browser IMPLEMENTATION
