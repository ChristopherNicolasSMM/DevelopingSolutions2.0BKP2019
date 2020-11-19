*&---------------------------------------------------------------------*
*&  Include           YDS3P_PANEL_VIEW_CLS
*&---------------------------------------------------------------------*


*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
*---------------------------------------------------------------------*
*                            C L A S S E S                            *
*---------------------------------------------------------------------*
*---------------------------------------------------------------------*
*                                kHTML                                *
*---------------------------------------------------------------------*
* Definição
*=====================================================================*
CLASS khtml DEFINITION INHERITING FROM cl_gui_html_viewer.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING  parent TYPE REF TO cl_gui_container
                         EXCEPTIONS no_html,

      callback FOR EVENT sapevent
                    OF cl_gui_html_viewer
        IMPORTING action
                    frame
                    getdata
                    postdata
                    query_table,

      get_prefix RETURNING VALUE(ret) TYPE char255.
ENDCLASS.                    "khtml DEFINITION

*---------------------------------------------------------------------*
*                              kHandle                                *
*---------------------------------------------------------------------*
* Implementação
*=====================================================================*
CLASS khtml IMPLEMENTATION.

  METHOD constructor.

    DATA: i_event TYPE cntl_simple_events,
          e_event TYPE cntl_simple_event.

    CALL METHOD super->constructor
      EXPORTING
        parent             = parent
*       SAPHTMLP           = 'X'
      EXCEPTIONS
        cntl_error         = 1
        cntl_install_error = 2
        dp_install_error   = 3
        dp_error           = 4.
    IF sy-subrc NE 0.
      RAISE no_html.
    ENDIF.

    MOVE me->m_id_sapevent TO e_event-eventid.
    APPEND e_event TO i_event.

    CALL METHOD me->set_registered_events
      EXPORTING
        events = i_event[].

    SET HANDLER me->callback FOR me.

  ENDMETHOD.                    "constructor

  METHOD callback.

    DATA: e_postdata LIKE LINE OF postdata,

          i_split    TYPE TABLE OF char256,
          e_split    TYPE char256,

          v_ucomm    TYPE syucomm.

    LOOP AT postdata INTO e_postdata.

      SPLIT e_postdata AT 'FCODE' INTO TABLE i_split.
      LOOP AT i_split INTO e_split.
        IF e_split(1) EQ '='.
          EXIT.
        ENDIF.
      ENDLOOP.

      IF e_split CA space.
        SUBTRACT 1 FROM sy-fdpos.
        IF sy-fdpos GT 0.
          MOVE e_split+1(sy-fdpos) TO v_ucomm.
        ELSE.
          EXIT.
        ENDIF.
      ENDIF.

    ENDLOOP.

    IF sy-subrc NE 0.
      MOVE action TO v_ucomm.
    ENDIF.

    CHECK NOT v_ucomm IS INITIAL.
    PERFORM ucomm USING v_ucomm.

  ENDMETHOD.                    "callback

  METHOD get_prefix.
    CALL METHOD me->get_property
      EXPORTING
        property   = 'URLPrefixLocal'
        queue_only = ' '
      IMPORTING
        value      = ret
      EXCEPTIONS
        OTHERS     = 1.
    IF sy-subrc NE 0.
    ENDIF.
  ENDMETHOD.                    "get_prefix

ENDCLASS.                    "khtml IMPLEMENTATION

*---------------------------------------------------------------------*
*                                                                     *
*                               kBDS                                  *
*                                                                     *
*---------------------------------------------------------------------*
*
*=====================================================================*
CLASS kbds DEFINITION.

  PUBLIC SECTION.

    TYPE-POOLS sbdst.

    METHODS: constructor IMPORTING cname  TYPE sbdst_classname
                                   ctype  TYPE sbdst_classtype
                                   objkey TYPE sbdst_object_key,

      load_image IMPORTING kwrd       TYPE bds_propva
                           hctr       TYPE REF TO cl_gui_html_viewer
                 RETURNING VALUE(ret) TYPE bds_compid,

      get_url IMPORTING kwrd       TYPE bds_propva
              RETURNING VALUE(url) TYPE localfile,

      make_file IMPORTING kwrd       TYPE bds_propva
                RETURNING VALUE(url) TYPE localfile.

  PRIVATE SECTION.

    DATA: mybds  TYPE REF TO cl_bds_document_set,

          mycomp TYPE sbdst_components,
          mysign TYPE sbdst_signature,

          cname  TYPE sbdst_classname,
          ctype  TYPE sbdst_classtype,
          objkey TYPE sbdst_object_key.

ENDCLASS.                    "kbds DEFINITION

*---------------------------------------------------------------------*
* Implementação
*=====================================================================*
CLASS kbds IMPLEMENTATION.

  METHOD constructor.

    CREATE OBJECT mybds.

    CALL METHOD cl_bds_document_set=>get_info
      EXPORTING
        classname  = cname
        classtype  = ctype
        object_key = objkey
      CHANGING
        components = me->mycomp
        signature  = me->mysign.

    MOVE: cname  TO me->cname,
          ctype  TO me->ctype,
          objkey TO me->objkey.

  ENDMETHOD.                    "constructor

  METHOD load_image.

    DATA: e_comp LIKE LINE OF mycomp,
          e_sign LIKE LINE OF mysign,

          v_url  TYPE sbdst_url.

    READ TABLE me->mysign INTO e_sign
                          WITH KEY prop_name  = 'BDS_KEYWORD'
                                   prop_value = kwrd.
    IF NOT sy-subrc IS INITIAL.
      EXIT.
    ENDIF.

    READ TABLE me->mycomp INTO e_comp
                          WITH KEY doc_count = e_sign-doc_count.

    CALL METHOD hctr->generate_new_url
      EXPORTING
        relative_url = e_comp-comp_id
      IMPORTING
        assigned_url = v_url.

    CALL METHOD mybds->get_with_own_url
      EXPORTING
        classname  = me->cname
        classtype  = me->ctype
        object_key = me->objkey
        doc_id     = e_sign-doc_id
        doc_ver_no = e_sign-doc_ver_no
        doc_var_id = e_sign-doc_var_id
        url        = v_url.

    MOVE e_comp-comp_id TO ret.

  ENDMETHOD.                    "load_image

  METHOD get_url.

    DATA: i_uris  TYPE TABLE OF bapiuri,
          e_uris  TYPE bapiuri,

          i_split TYPE TABLE OF localfile,
          e_split TYPE localfile,

          e_sign  LIKE LINE OF me->mysign.
    READ TABLE me->mysign INTO e_sign
                          WITH KEY prop_name  = 'BDS_CONN05'
                                   prop_value = kwrd.

    CALL FUNCTION 'BDS_BUSINESSDOCUMENT_GET_URL'
      EXPORTING
        classname    = me->cname
        classtype    = me->ctype
        object_key   = me->objkey
        url_lifetime = 'T'
      TABLES
        uris         = i_uris.

    READ TABLE i_uris INTO e_uris WITH KEY doc_count = e_sign-doc_count.
    IF sy-subrc EQ 0.
      MOVE e_uris-uri TO url.
    ENDIF.

  ENDMETHOD.                    "get_url


  METHOD make_file.
    DATA: i_uris  TYPE TABLE OF bapiuri,
          e_uris  TYPE bapiuri,

          i_data  TYPE TABLE OF char256,
          e_data  TYPE char256,

          i_split TYPE TABLE OF localfile,
          e_split TYPE localfile,

          i_sign  TYPE sbdst_signature,
          e_sign  LIKE LINE OF me->mysign,

          i_comp  TYPE TABLE OF bapicompon,
          e_comp  TYPE bapicompon,

          i_bpfl  TYPE TABLE OF bapifiles,
          e_bpfl  TYPE bapifiles,
          v_path  TYPE string.
    APPEND e_sign TO i_sign.

    CALL FUNCTION 'BDS_BUSINESSDOCUMENT_GET_INFO'
      EXPORTING
        classname       = me->cname
        classtype       = me->ctype
        object_key      = me->objkey
      TABLES
        components      = i_comp
        signature       = i_sign
      EXCEPTIONS
        nothing_found   = 1
        parameter_error = 2
        not_allowed     = 3
        error_kpro      = 4
        internal_error  = 5
        not_authorized  = 6
        OTHERS          = 7.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    CLEAR v_path.
    CALL METHOD cl_gui_frontend_services=>get_sapgui_workdir
      CHANGING
        sapworkdir            = v_path
      EXCEPTIONS
        get_sapworkdir_failed = 1
        cntl_error            = 2
        error_no_gui          = 3
        not_supported_by_gui  = 4
        OTHERS                = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    READ TABLE i_comp INTO e_comp INDEX 1.

    e_bpfl-doc_count  = e_comp-doc_count.
    e_bpfl-comp_count = e_comp-comp_count.
    e_bpfl-comp_id    = e_comp-comp_id.
    e_bpfl-directory  = v_path.
    APPEND e_bpfl TO i_bpfl.

    CALL FUNCTION 'BDS_BUSINESSDOCUMENT_GET_FILES'
      EXPORTING
        classname       = me->cname
        classtype       = me->ctype
        object_key      = me->objkey
      TABLES
        files           = i_bpfl
        signature       = i_sign
      EXCEPTIONS
        nothing_found   = 1
        parameter_error = 2
        not_allowed     = 3
        error_kpro      = 4
        internal_error  = 5
        not_authorized  = 6
        OTHERS          = 7.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


    CONCATENATE 'FILE://' v_path '\' e_comp-comp_id INTO url.

  ENDMETHOD.                    "get_url

ENDCLASS.                    "kbds IMPLEMENTATION
