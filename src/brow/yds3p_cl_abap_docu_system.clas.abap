class YDS3P_CL_ABAP_DOCU_SYSTEM definition
  public
  final
  create public .

public section.

*"* public components of class YDS3P_CL_ABAP_DOCU_SYSTEM
*"* do not include other source files here!!!
  constants SAP type SY-SYSID value 'SAP' ##NO_TEXT.
  constants UNKNOWN type SY-SYSID value 'UNKNOWN' ##NO_TEXT.
  class-data SYSTEM_TYPE type SY-SYSID value yds3p_cl_abap_docu_system=>UNKNOWN ##NO_TEXT.
  class-data TECHDEV type ABAP_BOOL value ' ' ##NO_TEXT.

  class-methods CLASS_CONSTRUCTOR .
  class-methods SEND_ERROR
    importing
      !LANGU type SY-LANGU
      !KEY type CSEQUENCE
      !FIELD1 type CSEQUENCE optional
      !FIELD2 type CSEQUENCE optional
      !FIELD3 type CSEQUENCE optional .
protected section.
*"* protected components of class YDS3P_CL_ABAP_DOCU_SYSTEM
*"* do not include other source files here!!!
private section.
*"* private components of class YDS3P_CL_ABAP_DOCU_SYSTEM
*"* do not include other source files here!!!
ENDCLASS.



CLASS YDS3P_CL_ABAP_DOCU_SYSTEM IMPLEMENTATION.


METHOD CLASS_CONSTRUCTOR.

* Get SAP or customer system

  CALL 'C_SAPGPARAM' ID 'NAME'  FIELD 'transport/systemtype'
                     ID 'VALUE' FIELD system_type.        "#EC CI_CCALL

* Get Techdev System

  IF sy-subrc = 0 AND
     system_type = /dhpb/cl_abap_docu_system=>sap AND
     sy-sysid(1) = 'B'.
    techdev = abap_true.
  ENDIF.

ENDMETHOD.


method SEND_ERROR.
   DATA msg TYPE c LENGTH 72.
    IF /dhpb/cl_abap_docu_system=>system_type = /dhpb/cl_abap_docu_system=>sap AND
       /dhpb/cl_abap_docu_system=>techdev     = abap_true and
       langu = 'D'.
      CONCATENATE 'Problem in'(prb) ` ` key `: ` field1 `, ` field2  `, ` field3 INTO msg.
      MESSAGE msg TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.
*    LOG-POINT ID abap_docu_converter SUBKEY key FIELDS field1 field2.
endmethod.
ENDCLASS.
