REPORT ZDEVSOL_REQUEST_UPLOAD.

DATA:  v_diretorio2 TYPE c  LENGTH 256.

DATA: it_file_table TYPE TABLE OF sdokpath   INITIAL SIZE 0 WITH HEADER LINE,
      it_dir_table  TYPE TABLE OF sdokpath   INITIAL SIZE 0 WITH HEADER LINE.
DATA: v_filtro TYPE c  LENGTH 256."  VALUE '*.XML*',
DATA:lc_filename  TYPE c LENGTH 256,
     lc_extension TYPE c LENGTH 20.

DATA:lv_path        LIKE sapb-sappfad,
     lv_targetpath  LIKE sapb-sappfad,
     lv_ot_filename TYPE string.

CONSTANTS:c_data_files_path  TYPE string   VALUE 'data',
          c_co_files_path    TYPE string   VALUE 'cofiles',
          c_request_released TYPE c        VALUE 'R',
          c_co_file_prefix   TYPE c        VALUE 'K',
          c_data_file_prefix TYPE c        VALUE 'R',
          c_execute_command  TYPE sy-ucomm VALUE 'ONLI',
          c_dot              TYPE c        VALUE '.',
          c_slash_win        TYPE c        VALUE '\',
          c_slash_lin        TYPE c        VALUE '/'.
DATA:gv_dir_trans TYPE char255.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_arq LIKE rlgrap-filename OBLIGATORY DEFAULT 'C:\TEMP\Requests'.
SELECTION-SCREEN END OF BLOCK b1.


v_diretorio2 = p_arq.


INITIALIZATION.
  CALL 'C_SAPGPARAM' ID 'NAME' FIELD 'DIR_TRANS' ID 'VALUE' FIELD gv_dir_trans.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_arq.
  DATA:lv_selected_folder TYPE string.
  CALL METHOD cl_gui_frontend_services=>directory_browse
    CHANGING
      selected_folder      = lv_selected_folder
    EXCEPTIONS
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
      OTHERS               = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  p_arq = lv_selected_folder.

AT SELECTION-SCREEN.

START-OF-SELECTION.

***---> FUNCAO PARA BUSCA DE ARQUIVOS
  CALL FUNCTION 'TMP_GUI_DIRECTORY_LIST_FILES'
    EXPORTING
      directory  = v_diretorio2
*     filter     = v_filtro
    TABLES
      file_table = it_file_table
      dir_table  = it_dir_table
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.


  LOOP AT it_file_table.
    CONCATENATE v_diretorio2 '\' it_file_table-pathname INTO lc_filename.


    CALL FUNCTION 'TRINT_FILE_GET_EXTENSION'
      EXPORTING
        filename  = lc_filename
        uppercase = 'X'
      IMPORTING
        extension = lc_extension.

    CASE it_file_table-pathname(1).
      WHEN c_co_file_prefix.
        lv_path        = lc_filename.
        CONCATENATE gv_dir_trans '/' c_co_files_path '/' it_file_table-pathname INTO lv_targetpath.
        PERFORM upload USING lv_path lv_targetpath.
      WHEN c_data_file_prefix.
        lv_path        = lc_filename.
        CONCATENATE gv_dir_trans '/' c_data_files_path '/' it_file_table-pathname INTO lv_targetpath.
        PERFORM upload USING lv_path lv_targetpath.
    ENDCASE.
  ENDLOOP.
*&---------------------------------------------------------------------*
*&      Form  show_msg
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM show_msg.
  MESSAGE s398(00) WITH text-004."Files downloaded successfully!
ENDFORM.                    "show_msg
*&---------------------------------------------------------------------*
*&      Form  Upload
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM upload USING p_path TYPE sapb-sappfad
                  p_targetpath TYPE sapb-sappfad.

  CALL FUNCTION 'ARCHIVFILE_CLIENT_TO_SERVER'
    EXPORTING
      path             = p_path
      targetpath       = p_targetpath
    EXCEPTIONS
      error_file       = 1
      no_authorization = 2
      OTHERS           = 3.
ENDFORM.                    "Upload
