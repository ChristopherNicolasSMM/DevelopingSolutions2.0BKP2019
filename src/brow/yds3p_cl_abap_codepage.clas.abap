class YDS3P_CL_ABAP_CODEPAGE definition
  public
  final
  create public .

public section.

  class-methods CONVERT_TO
    importing
      !SOURCE type STRING
      !CODEPAGE type STRING default `UTF-8`
      value(ENDIAN) type ABAP_ENDIAN optional
      value(REPLACEMENT) type ABAP_REPL default '#'
      value(IGNORE_CERR) type ABAP_BOOL default ABAP_FALSE
    returning
      value(RESULT) type XSTRING
    raising
      CX_PARAMETER_INVALID_RANGE
      CX_SY_CODEPAGE_CONVERTER_INIT
      CX_SY_CONVERSION_CODEPAGE
      CX_PARAMETER_INVALID_TYPE .
  class-methods CONVERT_FROM
    importing
      !SOURCE type XSTRING
      !CODEPAGE type STRING default `UTF-8`
      value(ENDIAN) type ABAP_ENDIAN optional
      value(REPLACEMENT) type ABAP_REPL default '#'
      value(IGNORE_CERR) type ABAP_BOOL default ABAP_FALSE
    returning
      value(RESULT) type STRING
    raising
      CX_PARAMETER_INVALID_RANGE
      CX_SY_CODEPAGE_CONVERTER_INIT
      CX_SY_CONVERSION_CODEPAGE
      CX_PARAMETER_INVALID_TYPE .
  class-methods CURRENT
    importing
      value(HTTP_NAME) type ABAP_BOOL default ABAP_FALSE
      value(JAVA_NAME) type ABAP_BOOL default ABAP_FALSE
      value(SAP_NAME) type ABAP_BOOL default ABAP_FALSE
    returning
      value(CODEPAGE) type STRING .
  class-methods SAP_CODEPAGE
    importing
      !CODEPAGE type STRING
    returning
      value(SAPCP) type CPCODEPAGE
    raising
      CX_PARAMETER_INVALID .
  class-methods FOR_LANGUAGE
    importing
      !LANGUAGE like SY-LANGU
      !HTTP_NAME type ABAP_BOOL default ABAP_FALSE
      !JAVA_NAME type ABAP_BOOL default ABAP_FALSE
      !SAP_NAME type ABAP_BOOL default ABAP_FALSE
    returning
      value(CODEPAGE) type STRING .
  class-methods SAP_TO_HTTP
    importing
      value(SAPCP) type CPCODEPAGE
    returning
      value(HTTP_NAME) type STRING
    raising
      CX_PARAMETER_INVALID .
  class-methods SAP_TO_JAVA
    importing
      !SAPCP type CPCODEPAGE
    returning
      value(JAVA_NAME) type STRING
    raising
      CX_PARAMETER_INVALID .
protected section.
*"* protected components of class YDS3P_CL_ABAP_CODEPAGE
*"* do not include other source files here!!!
private section.
*"* private components of class YDS3P_CL_ABAP_CODEPAGE
*"* do not include other source files here!!!
ENDCLASS.



CLASS YDS3P_CL_ABAP_CODEPAGE IMPLEMENTATION.


method CONVERT_FROM.
* convert source to result using codepage
  data: x2c type ref to cl_abap_conv_in_ce,
        scp type abap_encod.
  scp = sap_codepage( codepage ).
  x2c = cl_abap_conv_in_ce=>create( encoding = scp
         endian = endian replacement = replacement
         ignore_cerr = ignore_cerr ).
  x2c->convert( exporting input = source
                importing data  = result ).
endmethod.


method CONVERT_TO.
* convert source to result using codepage
  data: c2x  type ref to cl_abap_conv_out_ce,
        scp  type abap_encod.
  scp = sap_codepage( codepage ).
  c2x = cl_abap_conv_out_ce=>create( encoding = scp
          endian = endian replacement = replacement
          ignore_cerr = ignore_cerr ).
  c2x->convert( exporting data   = source
                importing buffer = result ).
endmethod.


method CURRENT.
  codepage = for_language( language = sy-langu
                          http_name = http_name
                          java_name = java_name
                           sap_name = sap_name ).
endmethod.


method FOR_LANGUAGE.
  data: sapcp TYPE cpcodepage.
  call function 'SCP_CODEPAGE_FOR_LANGUAGE'
    exporting language = language
    importing codepage = sapcp
    exceptions  others = 1.
  if sy-subrc = 0.
    if http_name = abap_true.
      codepage = sap_to_http( sapcp = sapcp ).
    elseif java_name = abap_true.
      codepage = sap_to_java( sapcp = sapcp ).
    elseif sap_name = abap_true.
      codepage = sapcp. " codepage number
    else.
      codepage = sap_to_http( sapcp = sapcp ).
    endif.
  endif.
endmethod.


method SAP_CODEPAGE.
  if codepage is initial.
*   return current codepage
    call function 'SCP_GET_CODEPAGE_NUMBER'
      EXPORTING database_also = space
      IMPORTING appl_codepage = sapcp
      EXCEPTIONS others = 1.
    if sy-subrc <> 0.
      clear sapcp.
    endif.
  else.
*   seach http codepages
    data: name type string. name = codepage.
    translate name to upper case.
    call function 'SCP_CODEPAGE_BY_EXTERNAL_NAME'
      exporting  external_name = name kind = 'H'
      importing  sap_codepage  = sapcp
     exceptions not_found = 1 others = 2.
    if sy-subrc = 0. exit. endif.
*   seach java codepages
    call function 'SCP_CODEPAGE_BY_EXTERNAL_NAME'
      exporting  external_name = name kind = 'J'
      importing  sap_codepage  = sapcp
     exceptions not_found = 1 others = 2.
    if sy-subrc = 0. exit. endif.
    if codepage = 'UTF-16'.
*     assume platform byte order
      if cl_abap_char_utilities=>endian = 'L'.
        sapcp = sap_codepage( `UTF-16LE` ).
      else.
        sapcp = sap_codepage( `UTF-16BE` ).
      endif.
    else.
*     raise exception, unknown codepage
      raise exception type cx_parameter_invalid_range
            exporting parameter = 'CODEPAGE' value = codepage.
    endif.
  endif.
endmethod.


method SAP_TO_HTTP.
  call function 'SCP_GET_HTTP_NAME'
    exporting sap_codepage = sapcp
    importing name = http_name
    exceptions others = 1.
  if sy-subrc <> 0.
    data: val type string. val = sapcp.
    raise exception type cx_parameter_invalid_range
          exporting parameter = 'SAPCP' value = val.
  endif.
endmethod.


method SAP_TO_JAVA.
  call function 'SCP_GET_JAVA_NAME'
    exporting sap_codepage = sapcp
    importing name = java_name
    exceptions others = 1.
  if sy-subrc <> 0.
*   raise exception
    data: val type string. val = sapcp.
    raise exception type cx_parameter_invalid_range
          exporting parameter = 'SAPCP' value = val.
  endif.
endmethod.
ENDCLASS.
