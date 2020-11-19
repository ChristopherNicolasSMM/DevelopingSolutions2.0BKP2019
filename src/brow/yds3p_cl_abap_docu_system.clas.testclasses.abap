* Use this include for your local test classes
* ----------------------------------------------------------------------
CLASS test_abap_docu_system DEFINITION FOR TESTING.
*  DURATION SHORT RISK LEVEL HARMLESS FINAL.
  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS test FOR TESTING.
ENDCLASS.
CLASS test_abap_docu_system IMPLEMENTATION.
  METHOD test.
    DATA l_system   TYPE sy-sysid.
    CALL 'C_SAPGPARAM' ID 'NAME'  FIELD 'transport/systemtype' "#EC CI_CCALL
                       ID 'VALUE' FIELD l_system.
    cl_aunit_assert=>assert_equals(
       act   = /dhpb/cl_abap_docu_system=>system_type
       exp   = l_system
       msg   = 'Wrong system type'                          "#EC NOTEXT
       level = cl_aunit_assert=>critical ).
    IF l_system = /dhpb/cl_abap_docu_system=>sap AND
                  sy-sysid(1) = 'B'.
      cl_aunit_assert=>assert_equals(
        act   = /dhpb/cl_abap_docu_system=>techdev
        exp   = abap_true
        msg   = 'Techdev system not detected'               "#EC NOTEXT
        level = cl_aunit_assert=>critical ).
    ELSE.
      cl_aunit_assert=>assert_equals(
        act   = /dhpb/cl_abap_docu_system=>techdev
        exp   = abap_false
        msg   = 'Techdev system wrongly detected'           "#EC NOTEXT
        level = cl_aunit_assert=>critical ).
    ENDIF.

    /dhpb/cl_abap_docu_system=>send_error( LANGU = 'E'
                                     KEY   = 'Test' ).
    "No assertion, since error leads to message
  ENDMETHOD.
ENDCLASS.
