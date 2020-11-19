*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_TREE_ALV_F01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  BUILD_FIELDCATALOG
*&---------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
FORM build_fieldcatalog.

  DATA ls_fieldcatalog TYPE lvc_s_fcat.

*& Estrutura criada para os campos da tela
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      ct_fieldcat      = gt_fieldcatalog.

*& Ajustar campos
  LOOP AT gt_fieldcatalog INTO ls_fieldcatalog.
    CASE ls_fieldcatalog-fieldname.
      WHEN 'CARRID' OR 'CONNID' OR 'FLDATE'.
        ls_fieldcatalog-no_out = 'X'.
        ls_fieldcatalog-key    = ''.
    ENDCASE.
    MODIFY gt_fieldcatalog FROM ls_fieldcatalog.
  ENDLOOP.

ENDFORM.                               " BUILD_FIELDCATALOG
*&---------------------------------------------------------------------*
*&      Form  build_header
*&---------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM build_comment USING
      pt_list_commentary TYPE slis_t_listheader
      p_logo             TYPE sdydo_value.

  DATA: ls_line TYPE slis_listheader.

*& Cabeçalho

  CLEAR ls_line.

  ls_line-typ  = 'H'.
*& ls_line-key:  not used for this type
  ls_line-info = 'ALV-tree-Demo: flight-overview'.
  APPEND ls_line TO pt_list_commentary.
*& status line: type s

  CLEAR ls_line.

  ls_line-typ  = 'S'.
  ls_line-key  = 'valid to'.
  ls_line-info = 'January 29 1999'.
  APPEND ls_line TO pt_list_commentary.

  ls_line-key  = 'time'.
  ls_line-info = '2.00 pm'.
  APPEND ls_line TO pt_list_commentary.

*& action line: type a
  CLEAR ls_line.
  ls_line-typ  = 'A'.
*& ls_line-key:  not used for this type
  ls_line-info = 'up-to-date data'.
  APPEND ls_line TO pt_list_commentary.

  IF p_logo IS INITIAL.
    p_logo = 'ENJOYSAP_LOGO'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  create_container
*&---------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_container.
  CREATE OBJECT g_custom_container
    EXPORTING
      container_name              = 'TREE1'
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  exit_program
*&---------------------------------------------------------------------*
*       free object and leave program
*----------------------------------------------------------------------*
FORM exit_program.                                          "#EC CALLED

  CALL METHOD g_tree->free.
  LEAVE PROGRAM.

ENDFORM.                               " exit_program
*&---------------------------------------------------------------------*
*&      Form  define_hierarchy_header
*&---------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*      <--P_L_HIERHDR  text
*----------------------------------------------------------------------*
FORM define_hierarchy_header CHANGING p_hierhdr TYPE treev_hhdr.
*& Cabeçalho dos nós na tree principal
  p_hierhdr-heading = 'Carr/Nr/Flugdatum'.
  p_hierhdr-tooltip = 'Carr/Nr/Flugdatum'.
  p_hierhdr-width = 35.
  p_hierhdr-width_pix = space.
ENDFORM.                               " define_hierarchy_header
*&---------------------------------------------------------------------*
*&      Form  select_data_and_fill_col_tree
*&---------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_data_and_fill_col_tree.

  DATA: ls_sflight     TYPE sflight,
        l_node_text    TYPE lvc_value,
        l_carrid_key   TYPE lvc_nkey,
        l_root_key     TYPE lvc_nkey,
        l_connid_key   TYPE lvc_nkey,
        lt_layout_item TYPE lvc_t_layi.

*& Espaço para seleção de dados.
  SELECT * FROM sflight INTO TABLE gt_sflight.
  SORT gt_sflight BY carrid connid fldate.

*& Tratativa dos nós e de dados para exibição.
  LOOP AT gt_sflight INTO ls_sflight.

*& adicionar codigo como nó
    ON CHANGE OF ls_sflight-carrid.
      l_node_text = ls_sflight-carrid.
      CALL METHOD g_tree->add_node
        EXPORTING
          i_relat_node_key = l_root_key
          i_relationship   = cl_gui_column_tree=>relat_last_child
          i_node_text      = l_node_text
          it_item_layout   = lt_layout_item
        IMPORTING
          e_new_node_key   = l_carrid_key.
    ENDON.

*& adicionar connid como nó
    ON CHANGE OF ls_sflight-connid.
      PERFORM create_item_layouts CHANGING lt_layout_item.
      l_node_text = ls_sflight-connid.
      CALL METHOD g_tree->add_node
        EXPORTING
          i_relat_node_key = l_carrid_key
          i_relationship   = cl_gui_column_tree=>relat_last_child
          i_node_text      = l_node_text
          it_item_layout   = lt_layout_item
        IMPORTING
          e_new_node_key   = l_connid_key.
    ENDON.

    PERFORM create_item_layouts CHANGING lt_layout_item.

*& adicionar fldate como nó
    WRITE ls_sflight-fldate TO l_node_text MM/DD/YYYY.
    CALL METHOD g_tree->add_node
      EXPORTING
        i_relat_node_key = l_connid_key
        i_relationship   = cl_gui_column_tree=>relat_last_child
        is_outtab_line   = ls_sflight
        i_node_text      = l_node_text
        it_item_layout   = lt_layout_item.
  ENDLOOP.

*& Executa os metodos abaixo:

  CALL METHOD g_tree->update_calculations.
*& Atualiza calculos de totais
  CALL METHOD g_tree->frontend_update.
*& Atualiza o frontend
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  create_item_layouts
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_item_layouts CHANGING pt_item_layout TYPE lvc_t_layi.

  DATA: ls_fieldcatalog TYPE lvc_s_fcat,
        ls_item_layout  TYPE lvc_s_layi.

  CLEAR pt_item_layout.

  LOOP AT gt_fieldcatalog INTO ls_fieldcatalog.

    CLEAR ls_item_layout.

    IF ls_fieldcatalog-no_out EQ space.
      ls_item_layout-fieldname = ls_fieldcatalog-fieldname.
      APPEND ls_item_layout TO pt_item_layout.
    ENDIF.
  ENDLOOP.

  CLEAR ls_item_layout.

  ls_item_layout-fieldname = g_tree->c_hierarchy_column_name.

  APPEND ls_item_layout TO pt_item_layout.
ENDFORM.                               " create_item_layouts
*&---------------------------------------------------------------------*
*&      Form  init_tree
*&---------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM init_tree.
  DATA: l_hierhdr          TYPE treev_hhdr,
        ls_variant         TYPE disvariant,
        lt_list_commentary TYPE slis_t_listheader,
        l_logo             TYPE sdydo_value.

*& Construir e ajustar fieldcatalog.
  PERFORM build_fieldcatalog.

*& Legenda para o cabeçalho dos nós na arvore macro
  PERFORM define_hierarchy_header CHANGING l_hierhdr.

*& Iniciar container
  PERFORM create_container.

*& Criar controle da Tree ( g_tree )
  CREATE OBJECT g_tree
    EXPORTING
      parent              = g_custom_container
      node_selection_mode = cl_gui_column_tree=>node_sel_mode_multiple.

*& Monta o cabeçalho
  PERFORM build_comment USING
                 lt_list_commentary
                 l_logo.

  ls_variant-report = sy-repid.

*& Cria a tela da ALV com os campos, falta apenas dados.
  CALL METHOD g_tree->set_table_for_first_display
    EXPORTING
      is_variant          = ls_variant
      i_save              = 'A'
      i_default           = 'X'
      is_hierarchy_header = l_hierhdr
      it_list_commentary  = lt_list_commentary
      i_logo              = l_logo
**      i_background_id     = 'ALV_BACKGROUND'
    CHANGING
      it_outtab           = gt_outtab
      it_fieldcatalog     = gt_fieldcatalog.

*& Início da adição dos componentes e evendos a ALV com ela criada.

*& register item_cxt_menu_request.
  SET HANDLER lcl_event_handler=>on_item_cxt_menu_request FOR g_tree.
  SET HANDLER lcl_event_handler=>on_item_cxt_menu_request FOR g_tree.
  SET HANDLER lcl_event_handler=>on_item_cxt_menu_selected FOR g_tree.


  DATA: lt_events TYPE cntl_simple_events,
        l_event   TYPE cntl_simple_event.

*& Busca eventos registrados por padrão
  CALL METHOD g_tree->get_registered_events
    IMPORTING
      events = lt_events.

*& Adicionar eventos novos
  l_event-eventid = cl_gui_column_tree=>eventid_item_context_menu_req.
  APPEND l_event TO lt_events.

*& Efetua o registro dos eventos
  CALL METHOD g_tree->set_registered_events
    EXPORTING
      events = lt_events.

*& Adiciona funções na toolbar
  PERFORM add_function_to_toolbar.

*& Preenche a tree com dados
  PERFORM select_data_and_fill_col_tree.
  CALL METHOD cl_gui_cfw=>flush.

ENDFORM.
*---------------------------------------------------------------------*
*       FORM change
*---------------------------------------------------------------------*
FORM change USING type TYPE i value TYPE i.
  DATA: lt_selected_nodes   TYPE lvc_t_nkey,
        ls_selected_node    TYPE lvc_nkey,
        lt_item_layout      TYPE lvc_t_layi,
        ls_item_layout_wa   TYPE lvc_s_layi,
        lt_change_layout    TYPE lvc_t_laci,
        ls_change_layout_wa TYPE lvc_s_laci,
        l_fieldname         TYPE lvc_fname,
        ls_outtab           TYPE sflight.

*& Busca qual foi o nó (linha) selecionado
  CALL METHOD g_tree->get_selected_nodes
    CHANGING
      ct_selected_nodes = lt_selected_nodes.

*& Caso não seja varios itens selecionados buscará
*& o item selecionado
  IF lt_selected_nodes IS INITIAL.
    CALL METHOD g_tree->get_selected_item
      IMPORTING
        e_selected_node = ls_selected_node
        e_fieldname     = l_fieldname.
*& Irá apendar qual foi a linha selecionada
    APPEND ls_selected_node TO lt_selected_nodes.
  ENDIF.

*& Realiza um loop no(s) item(ns) selecionados
  LOOP AT lt_selected_nodes INTO ls_selected_node.

*& Busca o layout da linha selecionada.
    CALL METHOD g_tree->get_outtab_line
      EXPORTING
        i_node_key     = ls_selected_node
      IMPORTING
        e_outtab_line  = ls_outtab
        et_item_layout = lt_item_layout.

    CLEAR lt_change_layout. "Limpa a configuração que retornou.

*& Realiza um loop em todos os campos do catalogo
    LOOP AT lt_item_layout INTO ls_item_layout_wa.
      IF l_fieldname IS INITIAL OR
         ls_item_layout_wa-fieldname EQ l_fieldname.

        MOVE-CORRESPONDING ls_item_layout_wa TO ls_change_layout_wa.

*& Realiza os ajustes conforme inficado no botão de Change.
        CASE type.
          WHEN 0.
            ls_change_layout_wa-class = value.
            ls_change_layout_wa-u_class = 'X'.
            IF value EQ cl_gui_column_tree=>item_class_checkbox.
              ls_change_layout_wa-editable = 'X'.
            ELSE.
              ls_change_layout_wa-editable = space.
            ENDIF.
            ls_change_layout_wa-u_editable = 'X'.
          WHEN 1.
            ls_change_layout_wa-font = value.
            ls_change_layout_wa-u_font = 'X'.
          WHEN 2.
            ls_change_layout_wa-style = value.
            ls_change_layout_wa-u_style = 'X'.
          WHEN 3.
            IF value EQ 0.
              ls_change_layout_wa-t_image = icon_okay.
            ELSE.
              ls_change_layout_wa-t_image = space.
            ENDIF.

            ls_change_layout_wa-u_t_image = 'X'.
        ENDCASE.
        APPEND ls_change_layout_wa TO lt_change_layout.
      ENDIF.
    ENDLOOP.

*&  Efetiva os ajustes de Layout item a item
    CALL METHOD g_tree->change_node
      EXPORTING
        i_node_key     = ls_selected_node
        i_outtab_line  = ls_outtab
        it_item_layout = lt_change_layout.

  ENDLOOP.

  CALL METHOD g_tree->frontend_update.
  CALL METHOD cl_gui_cfw=>flush.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  add_function_to_toolbar
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM add_function_to_toolbar.

  DATA: l_toolbar TYPE REF TO cl_gui_toolbar.

  CALL METHOD g_tree->get_toolbar_object
    IMPORTING
      er_toolbar = l_toolbar.

  CHECK NOT l_toolbar IS INITIAL.

*& Primeiro cria os sub-botões
*& Somente assim é possivel adicionar eles as opções
*& Neste ponto também é criado a associação do evento
*& para a tratativa do CASE no momento PAI da tela

*& Submenu for fonts
  DATA l_font_menu TYPE REF TO cl_ctmenu.
  CREATE OBJECT l_font_menu.

  CALL METHOD l_font_menu->add_function
    EXPORTING
      fcode = 'FONT_DEFAULT'
      text  = 'Default'.

  CALL METHOD l_font_menu->add_function
    EXPORTING
      fcode = 'PROP'
      text  = 'Prop'.

  CALL METHOD l_font_menu->add_function
    EXPORTING
      fcode = 'FIXED'
      text  = 'Fixed'.

*& Submenu for style
  DATA l_style_menu TYPE REF TO cl_ctmenu.
  CREATE OBJECT l_style_menu.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'STYLE_DEFAULT'
      text  = 'Default'.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'INHERITED'
      text  = 'Inherited'.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'INTENSIFIED'
      text  = 'Intensified'.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'INACTIVE'
      text  = 'Inactive'.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'CRITICAL'
      text  = 'Critical'.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'NEGATIVE'
      text  = 'Negative'.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'POSITIVE'
      text  = 'Positive'.

  CALL METHOD l_style_menu->add_function
    EXPORTING
      fcode = 'EMPHASIZED'
      text  = 'Emphasized'.

*& Submenu for class
  DATA l_class_menu TYPE REF TO cl_ctmenu.
  CREATE OBJECT l_class_menu.

  CALL METHOD l_class_menu->add_function
    EXPORTING
      fcode = 'TEXT'
      text  = 'Text'.

  CALL METHOD l_class_menu->add_function
    EXPORTING
      fcode = 'CHECKBOX'
      text  = 'Checkbox'.

  CALL METHOD l_class_menu->add_function
    EXPORTING
      fcode = 'BUTTON'
      text  = 'Button'.

  CALL METHOD l_class_menu->add_function
    EXPORTING
      fcode = 'LINK'
      text  = 'Link'.

*& Submenu for image/no image
  DATA l_image_menu TYPE REF TO cl_ctmenu.
  CREATE OBJECT l_image_menu.

  CALL METHOD l_image_menu->add_function
    EXPORTING
      fcode = 'IMAGE'
      text  = 'Image'.

  CALL METHOD l_image_menu->add_function
    EXPORTING
      fcode = 'NOIMAGE'
      text  = 'No Image'.

*************************************************************
*************************************************************

*& Agora criará as opções abaixo do botão
*& e depois adicionar os sub-botões

*& Change menu
*& DATA l_change_menu TYPE REF TO cl_ctmenu.
  CREATE OBJECT g_change_menu.

  CALL METHOD g_change_menu->add_submenu
    EXPORTING
      menu = l_font_menu
      text = 'Font'.

  CALL METHOD g_change_menu->add_submenu
    EXPORTING
      menu = l_style_menu
      text = 'Style'.

  CALL METHOD g_change_menu->add_submenu
    EXPORTING
      menu = l_class_menu
      text = 'Class'.

  CALL METHOD g_change_menu->add_submenu
    EXPORTING
      menu = l_image_menu
      text = 'Image'.

*& Adiciona os separadores da toolbar
  CALL METHOD l_toolbar->add_button
    EXPORTING
      fcode     = ''
      icon      = ''
      butn_type = cntb_btype_sep.

*& Adicionar botão criado na toolbar
  CALL METHOD l_toolbar->add_button
    EXPORTING
      fcode     = 'CHANGE'
      icon      = ''
      text      = 'Change'
      butn_type = cntb_btype_dropdown
      quickinfo = 'Change selected items'.

  CALL METHOD l_toolbar->set_static_ctxmenu
    EXPORTING
      fcode   = 'CHANGE'
      ctxmenu = g_change_menu.


*&----------------------------------------------------------
*& Exemplo de como add um botão novo na ALV
*&----------------------------------------------------------
*& Adiciona os separadores da toolbar
  CALL METHOD l_toolbar->add_button
    EXPORTING
      fcode     = ''
      icon      = ''
      butn_type = cntb_btype_sep.


  CALL METHOD l_toolbar->add_button
    EXPORTING
      fcode     = 'ALARM'
      icon      = '@T_ALAR@'
      text      = ''
      butn_type = '0' " 0 = Normal | 1 = dropDow
      quickinfo = 'Teste alerta'.
*&----------------------------------------------------------


*& Instanciar o evento de seleção no botão.

  SET HANDLER lcl_event_handler=>on_function_selected
    FOR l_toolbar.

ENDFORM.                               " add_toolbar
*&---------------------------------------------------------------------*
*&      Form  VALIDADE_INPUT_SCREEN_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM validade_input_screen_0100 .

ENDFORM.
