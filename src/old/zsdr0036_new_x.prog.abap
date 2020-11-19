*----------------------------------------------------------------------*
*                               Caçola                                 *
*----------------------------------------------------------------------*
* Nome do objeto.: ZSDR0036                                            *
* Título.........: Relatório de Análise de Vendas Caçola               *
* Objetivo ......: Relatório de Análise de Vendas Caçola               *
* Transação .....: ZSDT0060                                            *
*----------------------------------------------------------------------*
* Consultoria ...: Basisone Consultoria                                *
* Data desenv ...: 12.05.2015                                          *
* Tipo de prg ...: Report                                              *
*----------------------------------------------------------------------*
*& by: Silvio Miranda
*&---------------------------------------------------------------------*

REPORT zsdr036_new.

TABLES: vbrk, vbrp, knvv, mara, vbap, vbak, kna1, icon.

RANGES: r_kschl FOR konv-kschl,
        r_value FOR vbap-netpr.
DATA: lv_class_pfrete TYPE p LENGTH 3 DECIMALS 2,
      lv_class_cfixo  TYPE p LENGTH 3 DECIMALS 2,
      lv_class_ircsll TYPE p LENGTH 3 DECIMALS 2.
DATA p_ind TYPE sy-tabix VALUE IS INITIAL.
DATA: lv_qtd_item      TYPE i,            "Quantidade de itens
      lv_txt_qtd_item  TYPE c LENGTH 10,  "Texto da quantidade
      lv_txt_msg_item  TYPE c LENGTH 100, "Texto descritivo da
      lv_txt_msg_cabec TYPE c LENGTH 100. "Texto descritivo pedido


DATA: wa_margem  TYPE zsdr0036-margem_c,
      wa_pmargem TYPE zsdr0036-pmargem_c,
      wa_totalov TYPE zsdr0036-valor_ti.

TYPES: BEGIN OF typ_credito,
         vbeln TYPE vbak-vbeln,
         prc_s TYPE vbak-netwr,
       END OF typ_credito.

DATA: lt_credito TYPE STANDARD TABLE OF typ_credito,
      ls_credito TYPE typ_credito.

DATA: BEGIN OF dynprofelder OCCURS 10.
        INCLUDE STRUCTURE dynpread.
DATA: END OF dynprofelder.

DATA: lt_selscreen TYPE TABLE OF rsparams,
      wa_selscreen TYPE rsparams.

FIELD-SYMBOLS: <lt_data> TYPE ANY TABLE,
               <ls_data> TYPE any.
DATA lr_data               TYPE REF TO data.
DATA lt_maveavel           TYPE REF TO data.

TYPES: BEGIN OF tp_header,
         sysid      TYPE zsdr0036-sysid,
         bukrs_vf   TYPE vbrk-bukrs,
         werks      TYPE vbrp-werks,
         vtweg      TYPE vbrk-vtweg,
         vtextg     TYPE tvtwt-vtext,
         spart      TYPE vbrk-spart,
         vtextt     TYPE tvtwt-vtext,
         vkgrp      TYPE vbrp-vkgrp,
         bezei      TYPE tvgrt-bezei,
         vkbur      TYPE vbrp-vkbur,
         bezeit     TYPE tvkbt-bezei,
         auart      TYPE vbak-auart,
         augru      TYPE vbak-augru,
         bezeia     TYPE tvaut-bezei,
         vbtyp      TYPE vbak-vbtyp,
         vbeln      TYPE vbrk-vbeln,
         ernam      TYPE vbak-ernam,
         aubel      TYPE vbrp-aubel,
         xblnr      TYPE vbrk-xblnr,
         kunag      TYPE vbrk-kunag,
         sortl      TYPE c LENGTH 40,
         name1      TYPE kna1-name1,
         kdgrp      TYPE knvv-kdgrp,
         ktext      TYPE t151t-ktext,
         ort01      TYPE kna1-ort01,
         regio      TYPE kna1-regio,
         route      TYPE vbap-route,
         vtext      TYPE tzont-vtext,
         inco1      TYPE vbkd-inco1,
         erdat      TYPE vbrk-erdat,
         fkdat      TYPE vbrk-fkdat,
         knumv      TYPE vbrk-knumv,
         waerk      TYPE vbrk-waerk,
         abgru      TYPE vbap-abgru,
         total_ov   TYPE zsdr0036_sintetico-total_ov,
         total_cs   TYPE zsdr0036_sintetico-total_cs,
         total_cm   TYPE zsdr0036_sintetico-total_cm,
         total_ic   TYPE zsdr0036_sintetico-total_ic,
         total_pc   TYPE zsdr0036_sintetico-total_pc,
         total_ir   TYPE zsdr0036_sintetico-total_ir,
         total_ipi  TYPE zsdr0036_sintetico-total_ipi,
         total_fr   TYPE zsdr0036_sintetico-total_fr,
         total_cf   TYPE zsdr0036_sintetico-total_cf,
         margem_c   TYPE zsdr0036_sintetico-margem_c,
         cep        TYPE adrc-post_code1, "CEP
         pzmed      TYPE zbwt0002-pzmedrec, "Prazo Médio ZBWT0002-PZMEDREC
         pzmedpon   TYPE zbwt0002-pzmedrec, "Prazo Médio Ponderado
         credito    TYPE zbwt0002-pzmedrec, "Crédito

         "valor total de margem de contribuição
         pmargem_c  TYPE zsdr0036_sintetico-pmargem_c,
         "valor percentual total de margem de contribuição
*         lucro_liq  LIKE konv-kbetr, "valor lucro líquido
*plucro_liq LIKE konv-kbetr, "valor lucro líquido -> porcentagem
*           expand     type c,
         rebate_uni TYPE zsdt040-netwr,
         rebate_tot TYPE zsdt040-netwr,
       END OF tp_header.

TYPES: BEGIN OF tp_item,
         vbeln      TYPE vbrk-vbeln,
         matnr      TYPE vbrp-matnr,
         arktx      TYPE vbrp-arktx,
         wrkst      TYPE mara-wrkst,
         matkl      TYPE vbrp-matkl,
         wgbez      TYPE t023t-wgbez,
         fkimg      TYPE zsdr0036-fkimg,
         vrkme      TYPE vbrp-vrkme,
         kwmeng     TYPE zsdr0036-kwmeng,
         klmeng     TYPE zsdr0036-klmeng,
         meins      TYPE vbap-meins,
         pltyp_auft TYPE vbrp-pltyp_auft,
         abgru      TYPE vbap-abgru,
         valor_un   TYPE zsdr0036-valor_un, "valor unitário
         valor_ti   TYPE zsdr0036-valor_ti, "valor total do item
         valor_cm   TYPE zsdr0036-valor_cm, "valor custo mercado
         valor_co   TYPE zsdr0036-valor_co, "valor comissão
         valor_ic   TYPE zsdr0036-valor_ic, "valor ICMS
         valor_pi   TYPE zsdr0036-valor_pi, "valor PIS/COFINS
         valor_ir   TYPE zsdr0036-valor_ir, "valor IR/CSLL
         valor_ipi  TYPE zsdr0036-valor_ipi, "valor frete
         valor_fr   TYPE zsdr0036-valor_fr, "valor frete
         valor_cf   TYPE zsdr0036-valor_cf, "valor custo fixo
         margem_c   TYPE zsdr0036-margem_c, "margem contribuição
         pmargem_c  TYPE zsdr0036-pmargem_c,
         pzmed      TYPE zbwt0002-pzmedrec, "Prazo Médio ZBWT0002-PZMEDREC
         pzmedpon   TYPE zbwt0002-pzmedrec, "Prazo Médio Ponderado
         credito    TYPE zbwt0002-pzmedrec, "Crédito
         "valor percentual de margem de contribuição
*         lucro_liq  LIKE konv-kbetr, "valor lucro líquido
*plucro_liq LIKE konv-kbetr, "valor lucro líquido -> porcentagemd
         rebate_uni TYPE zsdt040-netwr,
         rebate_tot TYPE zsdt040-netwr,
       END OF tp_item.
DATA: it_vbak_aux TYPE STANDARD TABLE OF vbak.
DATA: wa_vbak_aux TYPE vbak.

DATA: it_vbap_aux TYPE STANDARD TABLE OF vbap,
      wa_vbap_aux TYPE vbap.

DATA: it_vbrk_aux TYPE STANDARD TABLE OF vbrk,
      wa_vbrk_aux TYPE vbrk.

DATA: it_vbrp_aux TYPE STANDARD TABLE OF vbrp,
      wa_vbrp_aux TYPE vbrp.

FIELD-SYMBOLS: <fs_table>    TYPE ANY TABLE,
               <fs_structor> TYPE any.
*----------------------------------------------------------------------*
*       CLASS lcl_report DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_report DEFINITION.    "INCL_OK"

*  INCLUDE: <icon>,   "INCL_OK"
*           <color>.  "INCL_OK"
*           <color>.  "INCL_OK"

  PUBLIC SECTION.

    TYPES: BEGIN OF typ_header,
             sysid      TYPE zsdr0036-sysid,
             bukrs_vf   TYPE vbrk-bukrs,
             werks      TYPE vbrp-werks,
             vtweg      TYPE vbrk-vtweg,
             vtextg     TYPE tvtwt-vtext,
             spart      TYPE vbrk-spart,
             vtextt     TYPE tvtwt-vtext,
             vkgrp      TYPE vbrp-vkgrp,
             bezei      TYPE tvgrt-bezei,
             vkbur      TYPE vbrp-vkbur,
             bezeit     TYPE tvkbt-bezei,
             auart      TYPE vbak-auart,
             augru      TYPE vbak-augru,
             bezeia     TYPE tvaut-bezei,
             vbtyp      TYPE vbak-vbtyp,
             vbeln      TYPE vbrk-vbeln,
             ernam      TYPE vbak-ernam,
             aubel      TYPE vbrp-aubel,
             xblnr      TYPE vbrk-xblnr,
             kunag      TYPE vbrk-kunag,
             sortl      TYPE c LENGTH 40,
             name1      TYPE kna1-name1,
             kdgrp      TYPE knvv-kdgrp,
             ktext      TYPE t151t-ktext,
             ort01      TYPE kna1-ort01,
             regio      TYPE kna1-regio,
             route      TYPE vbap-route,
             vtext      TYPE tzont-vtext,
             inco1      TYPE vbkd-inco1,
             erdat      TYPE vbrk-erdat,
             fkdat      TYPE vbrk-fkdat,
             knumv      TYPE vbrk-knumv,
             waerk      TYPE vbrk-waerk,
             abgru      TYPE vbap-abgru,
             total_ov   TYPE zsdr0036_sintetico-total_ov,
             total_cs   TYPE zsdr0036_sintetico-total_cs,
             total_cm   TYPE zsdr0036_sintetico-total_cm,
             total_ic   TYPE zsdr0036_sintetico-total_ic,
             total_pc   TYPE zsdr0036_sintetico-total_pc,
             total_ir   TYPE zsdr0036_sintetico-total_ir,
             total_ipi  TYPE zsdr0036_sintetico-total_ipi,
             total_fr   TYPE zsdr0036_sintetico-total_fr,
             total_cf   TYPE zsdr0036_sintetico-total_cf,
             margem_c   TYPE zsdr0036_sintetico-margem_c,
             cep        TYPE adrc-post_code1, "CEP
             pzmed      TYPE zbwt0002-pzmedrec, "Prazo Médio ZBWT0002-PZMEDREC
             pzmedpon   TYPE zbwt0002-pzmedrec, "Prazo Médio Ponderado
             credito    TYPE zbwt0002-pzmedrec, "Crédito

             "valor total de margem de contribuição
             pmargem_c  TYPE zsdr0036_sintetico-pmargem_c,
             "valor percentual total de margem de contribuição
*         lucro_liq  LIKE konv-kbetr, "valor lucro líquido
*plucro_liq LIKE konv-kbetr, "valor lucro líquido -> porcentagem
*           expand     type c,
             rebate_uni TYPE zsdt040-netwr,
             rebate_tot TYPE zsdt040-netwr,
           END OF typ_header.

    TYPES: BEGIN OF typ_item,
             vbeln      TYPE vbrk-vbeln,
             matnr      TYPE vbrp-matnr,
             arktx      TYPE vbrp-arktx,
             wrkst      TYPE mara-wrkst,
             matkl      TYPE vbrp-matkl,
             wgbez      TYPE t023t-wgbez,
             fkimg      TYPE zsdr0036-fkimg,
             vrkme      TYPE vbrp-vrkme,
             kwmeng     TYPE zsdr0036-kwmeng,
             klmeng     TYPE zsdr0036-klmeng,
             meins      TYPE vbap-meins,
             pltyp_auft TYPE vbrp-pltyp_auft,
             abgru      TYPE vbap-abgru,
             valor_un   TYPE zsdr0036-valor_un, "valor unitário
             valor_ti   TYPE zsdr0036-valor_ti, "valor total do item
             valor_cm   TYPE zsdr0036-valor_cm, "valor custo mercado
             valor_co   TYPE zsdr0036-valor_co, "valor comissão
             valor_ic   TYPE zsdr0036-valor_ic, "valor ICMS
             valor_pi   TYPE zsdr0036-valor_pi, "valor PIS/COFINS
             valor_ir   TYPE zsdr0036-valor_ir, "valor IR/CSLL
             valor_ipi  TYPE zsdr0036-valor_ipi, "valor frete
             valor_fr   TYPE zsdr0036-valor_fr, "valor frete
             valor_cf   TYPE zsdr0036-valor_cf, "valor custo fixo
             margem_c   TYPE zsdr0036-margem_c, "margem contribuição
             pmargem_c  TYPE zsdr0036-pmargem_c,
             pzmed      TYPE zbwt0002-pzmedrec, "Prazo Médio ZBWT0002-PZMEDREC
             pzmedpon   TYPE zbwt0002-pzmedrec, "Prazo Médio Ponderado
             credito    TYPE zbwt0002-pzmedrec, "Crédito
             "valor percentual de margem de contribuição
*         lucro_liq  LIKE konv-kbetr, "valor lucro líquido
*plucro_liq LIKE konv-kbetr, "valor lucro líquido -> porcentagemd
             rebate_uni TYPE zsdt040-netwr,
             rebate_tot TYPE zsdt040-netwr,
           END OF typ_item.

    DATA: it_header     TYPE TABLE OF typ_header,
          it_header_prx TYPE TABLE OF typ_header,
          wa_header     LIKE LINE OF it_header.

    DATA: it_item     TYPE TABLE OF typ_item,
          it_item_prx TYPE TABLE OF typ_item,
          wa_item     LIKE LINE OF it_item.
    DATA: lv_tabix LIKE sy-tabix.

    DATA: it_vbak TYPE SORTED TABLE OF vbak WITH UNIQUE KEY vbeln,
          wa_vbak LIKE LINE OF it_vbak.

    DATA: it_vbap TYPE STANDARD TABLE OF vbap,
          wa_vbap LIKE LINE OF it_vbap.

    DATA: it_vbrp TYPE STANDARD TABLE OF vbrp,
          wa_vbrp LIKE LINE OF it_vbrp.

    DATA: it_zsdt040 TYPE STANDARD TABLE OF zsdt040,
          wa_zsdt040 LIKE LINE OF it_zsdt040.

    DATA: it_vbrk TYPE SORTED TABLE OF vbrk WITH UNIQUE KEY vbeln,
          wa_vbrk LIKE LINE OF it_vbrk.

    DATA: it_vbfa TYPE TABLE OF vbfa,
          wa_vbfa LIKE LINE OF it_vbfa.

    DATA: it_kna1 TYPE SORTED TABLE OF kna1 WITH UNIQUE KEY kunnr,
          wa_kna1 LIKE LINE OF it_kna1.

    DATA: it_adrc TYPE SORTED TABLE OF adrc WITH UNIQUE KEY addrnumber,
          wa_adrc LIKE LINE OF it_adrc.
    DATA: it_t151t TYPE SORTED TABLE OF t151t WITH UNIQUE KEY
                      spras kdgrp,
          wa_t151t LIKE LINE OF it_t151t.
    DATA: it_tvrot TYPE SORTED TABLE OF tvrot WITH UNIQUE KEY
                        spras route,
          wa_tvrot LIKE LINE OF it_tvrot.

    DATA: it_tvgrt TYPE SORTED TABLE OF tvgrt WITH UNIQUE KEY
                        spras vkgrp,
          wa_tvgrt LIKE LINE OF it_tvgrt.

    DATA: it_tvkbt TYPE SORTED TABLE OF tvkbt WITH UNIQUE KEY
                        spras vkbur,
          wa_tvkbt LIKE LINE OF it_tvkbt.

    DATA: it_knvv TYPE SORTED TABLE OF knvv
                  WITH UNIQUE KEY kunnr vkorg vtweg spart,
          wa_knvv LIKE LINE OF it_knvv.

    DATA: it_konv TYPE SORTED TABLE OF konv
                  WITH UNIQUE KEY knumv kposn zaehk kschl,
          wa_konv LIKE LINE OF it_konv.

    "Dados PRX
    DATA: it_prx_vbrk TYPE STANDARD TABLE OF vbrk.
*          wa_prx_vbrk LIKE LINE OF it_prx_vbrk.

    DATA: it_prx_vbrp TYPE STANDARD TABLE OF vbrp.
*          wa_prx_vbrp LIKE LINE OF it_prx_vbrp.

    DATA: it_prx_vbak TYPE STANDARD TABLE OF vbak,
          wa_prx_vbak LIKE LINE OF it_prx_vbak.

    DATA: it_prx_vbap TYPE STANDARD TABLE OF vbap,
          wa_prx_vbap LIKE LINE OF it_prx_vbap.

    DATA: it_prx_adrc TYPE STANDARD TABLE OF adrc,
          wa_prx_adrc LIKE LINE OF it_prx_adrc.

    DATA: it_prx_mara TYPE STANDARD TABLE OF mara,
          wa_prx_mara LIKE LINE OF it_prx_mara.

    DATA: it_prx_vbkd TYPE STANDARD TABLE OF vbkd,
          wa_prx_vbkd LIKE LINE OF it_prx_vbkd.

*    DATA: it_prx_vbfa TYPE STANDARD TABLE OF vbfa,
*          wa_prx_vbfa LIKE LINE OF it_prx_vbfa.

    DATA: it_prx_kna1 TYPE STANDARD TABLE OF kna1,
          wa_prx_kna1 LIKE LINE OF it_prx_kna1.

    DATA: it_prx_knvv TYPE STANDARD TABLE OF knvv,
          wa_prx_knvv LIKE LINE OF it_prx_knvv.

    DATA: it_prx_konv TYPE STANDARD TABLE OF konv,
          wa_prx_konv LIKE LINE OF it_prx_konv.

    DATA: t_tspat  TYPE STANDARD TABLE OF tspat,
          wa_tspat LIKE LINE OF t_tspat.

    DATA: t_tvakt  TYPE STANDARD TABLE OF tvakt,
          wa_tvakt LIKE LINE OF t_tvakt.

    DATA: t_tvtwt  TYPE STANDARD TABLE OF tvtwt,
          wa_tvtwt LIKE LINE OF t_tvtwt.

    DATA: t_t023t  TYPE STANDARD TABLE OF t023t,
          wa_t023t LIKE LINE OF t_t023t.

    TYPES: BEGIN OF typ_tvak,
             auart TYPE tvak-auart,
             vbtyp TYPE tvak-vbtyp,
           END OF typ_tvak.
    DATA: it_tvak TYPE TABLE OF typ_tvak,
          wa_tvak LIKE LINE OF it_tvak.

    TYPES: BEGIN OF typ_mara,
             matnr TYPE mara-matnr,
             wrkst TYPE mara-wrkst,
           END OF typ_mara.
    DATA: it_mara TYPE TABLE OF typ_mara,
          wa_mara LIKE LINE OF it_mara.

    TYPES: BEGIN OF typ_tvaut,
             augru TYPE tvaut-augru,
             bezei TYPE tvaut-bezei,
           END OF typ_tvaut.
    DATA: it_tvaut TYPE TABLE OF typ_tvaut,
          wa_tvaut LIKE LINE OF it_tvaut.

    DATA: p_list(01).
* Tabela de saída
    TYPES: BEGIN OF typ_saida,
             status TYPE icon-id.
            INCLUDE TYPE zsdr0036_sintetico.
    TYPES:
      i_celltype TYPE salv_t_int4_column,
      t_color    TYPE lvc_t_scol,
      expand     TYPE char1,
      cep        TYPE adrc-post_code1, "CEP
      pzmed      TYPE zbwt0002-pzmedrec, "Prazo Médio ZBWT0002-PZMEDREC
      pzmedpon   TYPE zbwt0002-pzmedrec, "Prazo Médio Ponderado
      credito    TYPE zbwt0002-pzmedrec, "Crédito
      END   OF typ_saida.
    DATA: t_saida TYPE STANDARD TABLE OF typ_saida.
    DATA: wa_saida LIKE LINE OF t_saida.

* Tabela de saída
    TYPES: BEGIN OF typ_saidas,
             status TYPE icon-id.
            INCLUDE TYPE zsdr0036.
    TYPES:
      i_celltype TYPE salv_t_int4_column,
      t_color    TYPE lvc_t_scol,
      expand     TYPE char1,
      cep        TYPE adrc-post_code1, "CEP
      pzmed      TYPE zbwt0002-pzmedrec, "Prazo Médio ZBWT0002-PZMEDREC
      pzmedpon   TYPE zbwt0002-pzmedrec, "Prazo Médio Ponderado
      credito    TYPE zbwt0002-pzmedrec, "Crédito
      END   OF typ_saidas.
    DATA: t_saidas TYPE STANDARD TABLE OF typ_saidas.
    DATA: wa_saidas LIKE LINE OF t_saidas.

*   ALV reference
    DATA: o_alv TYPE REF TO cl_salv_table.

    DATA: picture_id TYPE bds_typeid VALUE 'ZLOGO_CACOLA'.

    METHODS:
      get_data,
      generate_output,
      seleciona_header,
      monta_header,
      seleciona_header_prx,
      monta_header_prx,

      get_default_layout
        IMPORTING i_restrict TYPE salv_de_layout_restriction
        CHANGING  c_layout   TYPE disvariant-variant.

  PRIVATE SECTION.

    METHODS:
      set_pf_status
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_layout
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_top_of_page
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_end_of_page
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_display_setting
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_columns
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_sorts
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_aggregations
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      set_cell_color                                        "#EC WARNOK
        IMPORTING
          i_colname TYPE lvc_fname OPTIONAL
          i_color   TYPE lvc_col
        CHANGING
          cs_vbak   TYPE typ_saida,

      set_cell_colors                                       "#EC WARNOK
        IMPORTING
          i_colname TYPE lvc_fname OPTIONAL
          i_color   TYPE lvc_col
        CHANGING
          cs_vbak   TYPE typ_saidas,

      set_cell_type,                                        "#EC WARNOK

      set_columns_technical
        CHANGING
          co_alv TYPE REF TO cl_salv_table,

      on_link_click
            FOR EVENT link_click OF cl_salv_events_table
        IMPORTING
            row
            column  ,

      on_user_command
            FOR EVENT added_function OF cl_salv_events
        IMPORTING
            e_salv_function.

*
ENDCLASS.                    "lcl_report DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_layout_f4 DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_layout_f4 DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      for_salv
        CHANGING cv_layout TYPE disvariant-variant.
ENDCLASS.                    "lcl_layout_f4 DEFINITION

CONTROLS: ts_dados TYPE TABSTRIP.

SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-s01.
SELECT-OPTIONS:
                s_burks FOR vbrk-bukrs MEMORY ID buk,
                s_vkorg FOR vbrk-vkorg MEMORY ID vko,
                s_vtweg FOR vbrk-vtweg MEMORY ID vtw,
                s_spart FOR vbrk-spart MEMORY ID spa,
                s_vkgrp FOR vbrp-vkgrp MEMORY ID vkg,
                s_vkbur FOR vbrp-vkbur MEMORY ID vkb,
                s_ernam FOR vbak-ernam,
                s_kunag FOR vbrk-kunag MEMORY ID vag,
                s_vbeln FOR vbrk-vbeln,
                s_aubel FOR vbrp-aubel,
                s_fkdat FOR vbrk-fkdat OBLIGATORY,
                s_erdat FOR vbrk-erdat,
                s_inco1 FOR vbrk-inco1,
                s_matnr FOR vbrp-matnr,
                s_matkl FOR vbrp-matkl,
                s_werks FOR vbrp-werks.
SELECTION-SCREEN END OF BLOCK b1.
*PARAMETER: status LIKE vbak-bname.
SELECTION-SCREEN END OF SCREEN 100.

SELECTION-SCREEN BEGIN OF SCREEN 300 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE text-s04.
SELECT-OPTIONS: s_auart FOR vbak-auart,
                s_kdgrp FOR knvv-kdgrp,
                s_route FOR vbap-route,
                s_wrkst FOR mara-wrkst,
                s_ort01 FOR kna1-ort01,
                s_id    FOR icon-id.
*PARAMETER: p_icon LIKE icon-ID.

SELECTION-SCREEN END OF BLOCK b4.

PARAMETERS: p_pfrete TYPE p LENGTH 3 DECIMALS 2 DEFAULT '4.1',
            p_cfixo  TYPE p LENGTH 3 DECIMALS 2 DEFAULT '9',
            p_ircsll TYPE p LENGTH 3 DECIMALS 2 DEFAULT '1.5'.
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text-s05.
PARAMETERS: r_sin RADIOBUTTON GROUP rd4 DEFAULT 'X',
            r_ana RADIOBUTTON GROUP rd4.
SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-s02.
PARAMETERS: r_prd   RADIOBUTTON GROUP rd1 DEFAULT 'X',
            r_prdx  RADIOBUTTON GROUP rd1,
            p_ambox RADIOBUTTON GROUP rd1.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b9 WITH FRAME TITLE text-s03.
PARAMETERS: p_layout TYPE disvariant-variant.
SELECTION-SCREEN END   OF BLOCK b9.
SELECTION-SCREEN END OF SCREEN 300.

SELECTION-SCREEN: BEGIN OF TABBED BLOCK tab_strip FOR 22 LINES,
                  TAB (20) button1 USER-COMMAND push1,
*                  TAB (20) button2 USER-COMMAND push2,
                  TAB (20) button3 USER-COMMAND push3,
*                  TAB (20) BUTTON4 USER-COMMAND PUSH4,
                  END OF BLOCK tab_strip.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_layout.
  lcl_layout_f4=>for_salv( CHANGING cv_layout = p_layout ).

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_icon.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_id-low.
  TYPES:  BEGIN OF typ_icon,
            id TYPE icon-id,
          END OF typ_icon.

  DATA:
    t_icon              TYPE STANDARD TABLE OF typ_icon INITIAL SIZE 0,
    wa_icon             TYPE typ_icon,
    l_i_field_tab       TYPE STANDARD TABLE OF dfies INITIAL SIZE 0,
    l_i_return_tab      TYPE STANDARD TABLE OF ddshretval INITIAL SIZE 0,
    l_wa_return_tab     TYPE ddshretval,
    l_i_dynpfld_mapping TYPE STANDARD TABLE OF dselc INITIAL SIZE 0.

  wa_icon-id = icon_green_light.
  APPEND wa_icon TO t_icon.
  wa_icon-id = icon_yellow_light.
  APPEND wa_icon TO t_icon.
  wa_icon-id = icon_red_light.
  APPEND wa_icon TO t_icon.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = 'ID'
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = 'P_ICON'
      value_org       = 'S'
    TABLES
      value_tab       = t_icon
      field_tab       = l_i_field_tab
      return_tab      = l_i_return_tab
      dynpfld_mapping = l_i_dynpfld_mapping
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.
  IF sy-subrc = 0.
    READ TABLE l_i_return_tab INTO l_wa_return_tab INDEX 1.
    s_id-low = l_wa_return_tab-fieldval.
  ENDIF.

AT SELECTION-SCREEN.
  PERFORM z_pai_of_selection_screen.

  CLEAR: p_ind.
**********************************************************************
INITIALIZATION.

  DATA: lr_report TYPE REF TO lcl_report.
  ##needed
* Controles do table strip
  button1 = text-b01.
*  button2 = text-b03.
  button3 = text-b02.
*  BUTTON4 = TEXT-B04.
*  BUTTON5 = TEXT-B05.
  tab_strip-prog = sy-repid.
  tab_strip-dynnr = 100.
  tab_strip-activetab = 'BUTTON1'.

  CREATE OBJECT lr_report.
  lr_report->get_default_layout( EXPORTING i_restrict =
                                 if_salv_c_layout=>restrict_none
                                 CHANGING c_layout   = p_layout ).
  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'ZPRF' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'ZPR0' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'ZCED' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'ZCID' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'BX13' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'BX72' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'BX82' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

  MOVE: 'I' TO r_kschl-sign,
        'EQ' TO r_kschl-option,
        'BX23' TO r_kschl-low.
  APPEND r_kschl.
  CLEAR r_kschl.

* Percentuais de margem de contribuição para farol
  zcl_abap_util=>get_stvarv( EXPORTING i_name = 'ZSDR0036_RANGE'
                             CHANGING c_range = r_value[] ).

**********************************************************************
START-OF-SELECTION.
*
  lr_report->get_data( ).
*

**********************************************************************
END-OF-SELECTION.
  lr_report->generate_output( ).

*----------------------------------------------------------------------*
*       CLASS lcl_layout_f4 IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_layout_f4 IMPLEMENTATION.
  METHOD for_salv.

    DATA: ls_layout TYPE salv_s_layout_info,
          ls_key    TYPE salv_s_layout_key.

    ls_key-report = sy-repid.

    ls_layout = cl_salv_layout_service=>f4_layouts(
                  s_key    = ls_key
                  restrict = if_salv_c_layout=>restrict_none  ).

    cv_layout = ls_layout-layout.

  ENDMETHOD.                    "for_salv
ENDCLASS.                    "lcl_layout_f4 IMPLEMENTATION


*----------------------------------------------------------------------*
*       CLASS lcl_report IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_report IMPLEMENTATION.

  METHOD get_data.

    SELECT * INTO TABLE t_tspat
           FROM tspat
           WHERE spras = sy-langu AND
                 spart IN s_spart.
    SORT t_tspat.

    SELECT * INTO TABLE t_tvakt
           FROM tvakt
           WHERE spras = sy-langu.
    SORT t_tvakt.

    SELECT * INTO TABLE t_tvtwt
           FROM tvtwt
           WHERE spras = sy-langu AND
                 vtweg IN s_vtweg.
    SORT t_tvtwt.

    SELECT augru bezei INTO TABLE it_tvaut
           FROM tvaut
           WHERE spras = sy-langu.
    SORT it_tvaut.
    SELECT * INTO TABLE it_t151t
             FROM t151t
             WHERE spras = sy-langu AND
                   kdgrp IN s_kdgrp.

    SELECT * INTO TABLE it_tvgrt
             FROM tvgrt
             WHERE spras = sy-langu AND
                   vkgrp IN s_vkgrp.

    SELECT * INTO TABLE it_tvkbt
             FROM tvkbt
             WHERE spras = sy-langu AND
                   vkbur IN s_vkbur.

    SELECT * INTO TABLE it_tvrot
             FROM tvrot
             WHERE spras = sy-langu AND
                   route IN s_route.

    SELECT auart vbtyp INTO TABLE it_tvak
           FROM tvak
           WHERE auart IN s_auart.
    SORT it_tvak.

    SELECT * INTO TABLE t_t023t
           FROM t023t
           WHERE spras = sy-langu.
    SORT t_t023t.

    IF r_ana = 'X'.
      SELECT matnr wrkst INTO TABLE it_mara
            FROM mara
            WHERE matnr IN s_matnr.
    ENDIF.

    SORT it_mara.
    IF r_prd EQ 'X' OR p_ambox EQ 'X'.
      lr_report->seleciona_header( ).
      lr_report->monta_header( ).
    ENDIF.

    IF r_prdx EQ 'X' OR p_ambox EQ 'X'.
      lr_report->seleciona_header_prx( ).
      lr_report->monta_header_prx( ).
    ENDIF.

    wa_pmargem = ( wa_margem / wa_totalov ) * 100.
* Margem de Contribuição (%) = (soma mg contrib/soma total OV)*100
    SORT: t_saida BY vtweg vtextg spart vtextt vkgrp bezei kdgrp ktext
                     vkbur.
    SORT: t_saidas BY vtweg vtextg spart vtextt vkgrp bezei kdgrp ktext
                     vkbur.

  ENDMETHOD.                    "get_data

  METHOD seleciona_header.
    "Dados de cabeçalho dos pedidos de venda
    SELECT * FROM vbrk INTO TABLE it_vbrk
      WHERE bukrs IN s_burks AND
            vkorg IN s_vkorg AND
            vtweg IN s_vtweg AND
            spart IN s_spart AND
            " ernam IN s_ernam AND
            kunag IN s_kunag AND
            vbeln IN s_vbeln AND
*            auart IN s_auart AND
            fkdat IN s_fkdat AND
            inco1 IN s_inco1 AND
            fksto NE 'X'.
* Doctos de estorno
    DELETE it_vbrk WHERE NOT sfakn IS INITIAL.

    IF NOT it_vbrk[] IS INITIAL.
      SELECT * FROM kna1 INTO TABLE it_kna1
        FOR ALL ENTRIES IN it_vbrk
        WHERE kunnr EQ it_vbrk-kunag.

      SELECT * FROM adrc INTO TABLE it_adrc
        FOR ALL ENTRIES IN it_kna1
        WHERE addrnumber EQ it_kna1-adrnr.

      SELECT * FROM knvv INTO TABLE it_knvv
        FOR ALL ENTRIES IN it_vbrk
        WHERE kunnr EQ it_vbrk-kunag AND
              vkorg EQ it_vbrk-vkorg AND
              vtweg EQ it_vbrk-vtweg AND
              spart EQ it_vbrk-spart.

    ENDIF.

    IF it_vbrk[] IS NOT INITIAL.
      SELECT * FROM vbrp INTO TABLE it_vbrp
        FOR ALL ENTRIES IN it_vbrk
        WHERE vbeln EQ it_vbrk-vbeln AND
              matnr IN s_matnr AND
              matkl IN s_matkl AND
              vkgrp IN s_vkgrp AND
              vkbur IN s_vkbur AND
              aubel IN s_aubel AND
              werks IN s_werks.
      SORT it_vbrp.
      SELECT * FROM konv INTO TABLE it_konv
        FOR ALL ENTRIES IN it_vbrk[]
        WHERE knumv EQ it_vbrk-knumv AND
              kschl IN r_kschl.
    ENDIF.

* Carregar dados dos pedidos
    IF NOT it_vbrp[] IS INITIAL.
      SELECT * FROM vbak INTO TABLE it_vbak
           FOR ALL ENTRIES IN it_vbrp
           WHERE vbeln EQ it_vbrp-aubel AND
                 ernam IN s_ernam.

      " Seleção do cadastro de rebate
      SELECT * FROM zsdt040 INTO TABLE it_zsdt040
         FOR ALL ENTRIES IN it_vbrp
       WHERE matnr EQ it_vbrp-matnr AND
             meins EQ it_vbrp-meins.
    ENDIF.

    IF NOT it_vbak[] IS INITIAL.
      SELECT * FROM vbap INTO TABLE it_vbap
           FOR ALL ENTRIES IN it_vbak
           WHERE vbeln EQ it_vbak-vbeln.
    ENDIF.
    SORT it_vbap BY vbeln posnr.


    it_vbak_aux[] = it_vbak[].
    it_vbrp_aux[] = it_vbrp[].
    it_vbrk_aux[] = it_vbrk[].




  ENDMETHOD.

  METHOD monta_header.
    LOOP AT it_vbrk INTO wa_vbrk.
      wa_header-sysid = 'PRD'.

      MOVE-CORRESPONDING wa_vbrk TO wa_header.
      CLEAR wa_kna1.
      READ TABLE it_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbrk-kunag
                                      BINARY SEARCH.
      CLEAR wa_adrc.
      READ TABLE it_adrc INTO wa_adrc WITH KEY
                                      addrnumber = wa_kna1-adrnr
                                      BINARY SEARCH.

      wa_header-cep = wa_adrc-post_code1.

      CONCATENATE wa_adrc-sort1 wa_adrc-sort2 INTO wa_header-sortl.

      wa_header-name1 = wa_kna1-name1.
      wa_header-ort01 = wa_kna1-ort01.
      wa_header-regio = wa_kna1-regio.

      READ TABLE t_tspat INTO wa_tspat WITH KEY
                         spart = wa_header-spart BINARY SEARCH.
      wa_header-vtextt = wa_tspat-vtext.

      READ TABLE t_tvtwt INTO wa_tvtwt WITH KEY
                         vtweg = wa_header-vtweg BINARY SEARCH.
      wa_header-vtextg = wa_tvtwt-vtext.

      CLEAR wa_knvv.
      READ TABLE it_knvv INTO wa_knvv
                         WITH TABLE KEY kunnr = wa_vbrk-kunag
                                        vkorg = wa_vbrk-vkorg
                                        vtweg = wa_vbrk-vtweg
                                        spart = wa_vbrk-spart.

      wa_header-kdgrp = wa_knvv-kdgrp.
      CLEAR wa_t151t.
      READ TABLE it_t151t INTO wa_t151t WITH KEY spras = sy-langu
                                             kdgrp = wa_header-kdgrp.

      wa_header-ktext = wa_t151t-ktext.

      CLEAR wa_vbrp.
      READ TABLE it_vbrp INTO wa_vbrp WITH KEY vbeln = wa_vbrk-vbeln
                                               BINARY SEARCH.
      CHECK sy-subrc EQ 0.
      IF sy-subrc NE 0.
*        BREAK-POINT.
      ENDIF.

      MOVE-CORRESPONDING wa_vbrp TO wa_header.

      READ TABLE it_vbak INTO wa_vbak WITH KEY vbeln = wa_vbrp-aubel.
      IF sy-subrc IS INITIAL.
        wa_header-auart = wa_vbak-auart.
        wa_header-erdat = wa_vbak-erdat.
        wa_header-augru = wa_vbak-augru.
        wa_header-ernam = wa_vbak-ernam.
      ENDIF.

      CLEAR wa_tvaut.
      READ TABLE it_tvaut INTO wa_tvaut WITH KEY augru = wa_vbak-augru
                                   BINARY SEARCH.
      wa_header-bezeia = wa_tvaut-bezei.
      READ TABLE it_vbap INTO wa_vbap WITH KEY vbeln = wa_vbrp-aubel
                                               BINARY SEARCH.
      IF sy-subrc NE 0.
*        BREAK-POINT.
      ENDIF.
      wa_header-route = wa_vbap-route.
      wa_header-abgru = wa_vbap-abgru.

      CLEAR wa_tvak.
      READ TABLE it_tvak INTO wa_tvak WITH KEY auart = wa_vbak-auart
                                               BINARY SEARCH.
      wa_header-vbtyp = wa_tvak-vbtyp.

      CLEAR wa_tvrot.
      READ TABLE it_tvrot INTO wa_tvrot WITH TABLE KEY
                               spras = sy-langu
                               route = wa_header-route.
      wa_header-vtext = wa_tvrot-bezei.

      CLEAR wa_tvgrt.
      READ TABLE it_tvgrt INTO wa_tvgrt WITH TABLE KEY
                               spras = sy-langu
                               vkgrp = wa_vbrp-vkgrp.
      wa_header-bezei = wa_tvgrt-bezei.

      CLEAR wa_tvkbt.
      READ TABLE it_tvkbt INTO wa_tvkbt WITH TABLE KEY
                               spras = sy-langu
                               vkbur = wa_vbrp-vkbur.
      wa_header-bezeit = wa_tvkbt-bezei.

      LOOP AT it_konv INTO wa_konv WHERE knumv EQ wa_vbrk-knumv.
        CASE wa_konv-kschl.
          WHEN 'ZPRF'.
            wa_header-total_ov = wa_header-total_ov + wa_konv-kwert.
          WHEN 'ZPR0'.
            wa_header-total_cs = wa_header-total_cs + wa_konv-kwert.
          WHEN 'ZCED' OR 'ZCID'.
            wa_header-total_cm = wa_header-total_cm + wa_konv-kwert.
          WHEN 'BX13'.
            wa_header-total_ic = wa_header-total_ic + wa_konv-kwert.
          WHEN 'BX72' OR 'BX82'.
            wa_header-total_pc = wa_header-total_pc + wa_konv-kwert.
          WHEN 'BX23'.
            wa_header-total_ipi = wa_header-total_ipi + wa_konv-kwert.
        ENDCASE.
      ENDLOOP.

      wa_header-total_ir = wa_header-total_ov * ( p_ircsll / 100 ).

      IF wa_header-inco1 NE 'FOB'.
        wa_header-total_fr = wa_header-total_ov * ( p_pfrete / 100 ).
      ELSE.
        wa_header-total_fr = 0.
      ENDIF.

      wa_header-total_cf = wa_header-total_ov * ( p_cfixo / 100 ).

      IF wa_header-total_ov IS NOT INITIAL.
        IF wa_header-auart EQ 'ZDOA'.
          wa_header-margem_c = 1 *
      ( wa_header-total_cs + wa_header-total_pc + wa_header-total_ic +
        wa_header-total_ir + wa_header-total_cm + wa_header-total_fr ).
          IF wa_header-total_ov IS NOT INITIAL.
            wa_header-pmargem_c = 100 *
        ( wa_header-total_cs + wa_header-total_pc + wa_header-total_ic +
          wa_header-total_ir + wa_header-total_cm + wa_header-total_fr )
          / wa_header-total_ov.
          ENDIF.
        ELSE.
          wa_header-margem_c =
        ( wa_header-total_ov - wa_header-total_cs - wa_header-total_ic -
          wa_header-total_pc - wa_header-total_ir - wa_header-total_fr -
          wa_header-total_cm ).

          IF wa_header-total_ov IS NOT INITIAL.
            wa_header-pmargem_c = ( (
          wa_header-total_ov - wa_header-total_cs - wa_header-total_ic -
          wa_header-total_pc - wa_header-total_ir - wa_header-total_fr -
          wa_header-total_cm ) / wa_header-total_ov ) * 100.
          ENDIF.

        ENDIF.




      ENDIF.

      IF wa_header-auart = 'ZDOA'.
        wa_header-margem_c  = wa_header-margem_c * -1.
        wa_header-pmargem_c = wa_header-pmargem_c * -1.
      ENDIF.

      IF wa_header-vbtyp NE 'C'.
        wa_header-margem_c  = wa_header-margem_c * -1.
        wa_header-pmargem_c = wa_header-pmargem_c * -1.
        wa_header-total_ov  = wa_header-total_ov * -1.
        wa_header-total_cs  = wa_header-total_cs * -1.
        wa_header-total_cm  = wa_header-total_cm * -1.
        wa_header-total_ic  = wa_header-total_ic * -1.
        wa_header-total_pc  = wa_header-total_pc * -1.
        wa_header-total_ir  = wa_header-total_ir * -1.
        wa_header-total_ipi = wa_header-total_ipi * -1.
        wa_header-total_fr  = wa_header-total_fr * -1.
        wa_header-total_cf  = wa_header-total_cf * -1.
      ENDIF.


       PERFORM prazo_med_header  CHANGING wa_header.


      APPEND wa_header TO it_header.
      IF r_sin = 'X'.
        MOVE-CORRESPONDING wa_header TO wa_saida.
        PERFORM set_flag USING wa_saida-pmargem_c
                       CHANGING wa_saida-status.

        REFRESH wa_saida-t_color[].
        IF wa_saida-total_ov < 0 AND wa_saida-vbtyp NE 'I'.
          set_cell_color( EXPORTING
* Colorir tota a linha.. omite o nome do campo
*                          i_colname = 'TOTAL_OV' "Opcional
                          i_color   = 6
                        CHANGING
                        cs_vbak   = wa_saida ).
        ENDIF.

        IF wa_saida-auart EQ 'ZDOA'.
          set_cell_color( EXPORTING
* Colorir tota a linha.. omite o nome do campo
*                          i_colname = 'TOTAL_OV' "Opcional
                          i_color   = 7
                        CHANGING
                        cs_vbak   = wa_saida ).
        ENDIF.

        " Rebate - Início
        SORT it_zsdt040 BY matnr meins.

        READ TABLE it_vbrp INTO wa_vbrp WITH KEY vbeln = wa_saida-vbeln BINARY SEARCH.
        IF sy-subrc IS INITIAL.
          LOOP AT it_vbrp INTO wa_vbrp FROM sy-tabix.
            IF wa_vbrp-vbeln NE wa_saida-vbeln.
              EXIT.
            ENDIF.

            READ TABLE it_zsdt040 INTO wa_zsdt040 WITH KEY matnr = wa_vbrp-matnr meins = wa_vbrp-meins BINARY SEARCH.
            IF sy-subrc IS INITIAL.
              wa_saida-rebate_tot = wa_saida-rebate_tot + ( wa_vbrp-fkimg * wa_zsdt040-netwr ).
            ENDIF.
          ENDLOOP.
        ENDIF.
        " Rebate - Fim

        APPEND wa_saida TO t_saida.
      ENDIF.
      CLEAR wa_header.
    ENDLOOP.
    SORT t_saida.
    DELETE t_saida WHERE auart NOT IN s_auart.
    DELETE t_saida WHERE kdgrp NOT IN s_kdgrp.
    DELETE t_saida WHERE route NOT IN s_route.
    DELETE t_saida WHERE ort01 NOT IN s_ort01.
    DELETE t_saida WHERE status NOT IN s_id.
    DELETE t_saida WHERE ernam NOT IN s_ernam.    " 29/02/2016
    SORT it_header.
    DELETE it_header WHERE ernam NOT IN s_ernam. " 29/02/2016


* Margem de Contribuição (%) = (soma mg contrib/soma total OV)*100
    LOOP AT t_saida INTO wa_saida.
      wa_margem  = wa_margem  + wa_saida-margem_c.
      wa_totalov = wa_totalov + wa_saida-total_ov.
    ENDLOOP.
*    wa_pmargem = ( wa_margem / wa_totalov ) * 100.

    IF r_ana = 'X'.
      SORT it_header BY vbeln.
* Analitico
      LOOP AT it_vbrp INTO wa_vbrp.
        CLEAR wa_vbap.
        READ TABLE it_vbap INTO wa_vbap WITH KEY
                                vbeln = wa_vbrp-aubel
                                posnr = wa_vbrp-aupos
                                BINARY SEARCH.
        CLEAR wa_header.
        READ TABLE it_header INTO wa_header WITH KEY vbeln = wa_vbrp-vbeln
                                                 BINARY SEARCH.
        CHECK sy-subrc EQ 0.
        CLEAR wa_item.
        READ TABLE t_t023t INTO wa_t023t WITH KEY
                        matkl = wa_vbrp-matkl BINARY SEARCH.

        wa_item-vbeln = wa_vbrp-vbeln.
        wa_item-abgru = wa_vbap-abgru.
        wa_item-matnr = wa_vbrp-matnr.
        wa_item-arktx = wa_vbrp-arktx.
        wa_item-matkl = wa_vbrp-matkl.
        wa_item-fkimg = wa_vbrp-fkimg.
        wa_item-vrkme = wa_vbrp-vrkme.
        wa_item-wgbez = wa_t023t-wgbez.
        wa_item-kwmeng = wa_vbap-kwmeng.
        wa_item-meins  = wa_vbap-meins.
        wa_item-klmeng = wa_vbap-klmeng.
        wa_item-pltyp_auft = wa_vbrp-pltyp_auft.
        CLEAR wa_mara.
        READ TABLE it_mara INTO wa_mara WITH KEY
              matnr = wa_vbrp-matnr BINARY SEARCH.
        wa_item-wrkst = wa_mara-wrkst.

        LOOP AT it_konv INTO wa_konv WHERE knumv EQ wa_header-knumv AND
                                           kposn EQ wa_vbrp-posnr.
          CASE wa_konv-kschl.
            WHEN 'ZPRF'. "valor unitario do item
              wa_item-valor_un = wa_konv-kbetr.
              wa_item-valor_ti = wa_konv-kwert.
              wa_item-valor_ir = wa_konv-kwert * ( lv_class_ircsll / 100 ).

              IF wa_header-inco1 NE 'FOB'.
                wa_item-valor_fr = wa_konv-kwert * ( lv_class_pfrete / 100 ).
              ELSE.
                wa_item-valor_fr = 0.
              ENDIF.

              wa_item-valor_cf = wa_konv-kwert * ( lv_class_cfixo  / 100 ).
            WHEN 'ZPR0'. "valor de custo de mercado
              wa_item-valor_cm = wa_konv-kwert.
            WHEN 'ZCED' OR 'ZCID'. "valor de comissão
              wa_item-valor_co = wa_konv-kwert.
            WHEN 'BX13'. "valor ICMS
              wa_item-valor_ic = wa_konv-kwert.
            WHEN 'BX72' OR 'BX82'. "valor pis + cofins
              wa_item-valor_pi = wa_item-valor_pi + wa_konv-kwert.
            WHEN 'BX23'. "valor IPI
              wa_item-valor_ipi = wa_konv-kwert.
          ENDCASE.
        ENDLOOP.

        wa_item-valor_ir = wa_item-valor_ti * ( p_ircsll / 100 ).

        IF wa_header-inco1 NE 'FOB'.
          wa_item-valor_fr = wa_item-valor_ti * ( p_pfrete / 100 ).
        ELSE.
          wa_item-valor_fr = 0.
        ENDIF.

        wa_item-valor_cf = wa_item-valor_ti * ( p_cfixo / 100 ).
        IF wa_header-auart EQ 'ZDOA'.
          wa_item-margem_c = 1 * (   wa_item-valor_cm +
                                     wa_item-valor_ic +
                                     wa_item-valor_pi +
                                     wa_item-valor_ir +
                                     wa_item-valor_co +
                                     wa_item-valor_fr ).
          IF wa_item-valor_ti IS NOT INITIAL.
            wa_item-pmargem_c =
                 ( wa_item-margem_c / wa_item-valor_ti ) * 100.
          ENDIF.

        ELSE. "demais categorias de venda
          IF wa_item-valor_ti IS NOT INITIAL.
            wa_item-margem_c = ( wa_item-valor_ti -
                                 wa_item-valor_cm -
                                 wa_item-valor_ic -
                                 wa_item-valor_pi -
                                 wa_item-valor_ir -
                                 wa_item-valor_fr -
                                 wa_item-valor_co ).
            IF NOT wa_item-valor_ti IS INITIAL.
              wa_item-pmargem_c =
                   ( wa_item-margem_c / wa_item-valor_ti ) * 100.
            ENDIF.
          ENDIF.

        ENDIF.

        IF wa_header-auart = 'ZDOA'.
          wa_item-margem_c  = wa_item-margem_c  * -1.
          wa_item-pmargem_c = wa_item-pmargem_c * -1.
        ENDIF.

        IF wa_header-vbtyp NE 'C'.
          "Para itens de cenário de devolução campos abaixo devem ser
          wa_item-valor_ti  = wa_item-valor_ti  * -1.
          wa_item-margem_c  = wa_item-margem_c  * -1.
          wa_item-pmargem_c = wa_item-pmargem_c * -1.
          wa_item-kwmeng    = wa_item-kwmeng * -1.
          wa_item-klmeng    = wa_item-klmeng * -1.
          wa_item-fkimg     = wa_item-fkimg  * -1.
          wa_item-valor_un  = wa_item-valor_un * -1.
          wa_item-valor_cm  = wa_item-valor_cm * -1.
          wa_item-valor_co  = wa_item-valor_co * -1.
          wa_item-valor_ic  = wa_item-valor_ic * -1.
          wa_item-valor_pi  = wa_item-valor_pi * -1.
          wa_item-valor_ir  = wa_item-valor_ir * -1.
          wa_item-valor_ipi = wa_item-valor_ipi * -1.
          wa_item-valor_fr  = wa_item-valor_fr * -1.
          wa_item-valor_cf  = wa_item-valor_cf * -1.
        ENDIF.

        PERFORM prazo_med_itm CHANGING wa_item.

        APPEND wa_item TO it_item.
        CLEAR wa_item.

        lv_qtd_item = lv_qtd_item + 1.
      ENDLOOP.

      SORT it_item BY vbeln.
      SORT it_zsdt040 BY matnr meins.

      LOOP AT it_header INTO wa_header.
        MOVE-CORRESPONDING wa_header TO wa_saidas.
        LOOP AT it_item INTO wa_item WHERE vbeln = wa_header-vbeln.
          MOVE-CORRESPONDING wa_item TO wa_saidas.
          REFRESH wa_saidas-t_color[].
          PERFORM set_flag USING wa_saidas-pmargem_c
                       CHANGING wa_saidas-status.

          IF wa_saidas-valor_ti < 0.

            set_cell_colors( EXPORTING
*                            i_colname = 'VALOR_TI' "Opcional
                            i_color   = 6
                          CHANGING
                          cs_vbak   = wa_saidas ).
          ENDIF.
          IF wa_saidas-auart = 'ZDOA'.
            set_cell_colors( EXPORTING
*                            i_colname = 'VALOR_TI' "Opcional
                            i_color   = 7
                          CHANGING
                          cs_vbak   = wa_saidas ).
          ENDIF.

          " Rebate - Início
          READ TABLE it_zsdt040 INTO wa_zsdt040 WITH KEY matnr = wa_saidas-matnr meins = wa_saidas-meins BINARY SEARCH.
          IF sy-subrc IS INITIAL.
            wa_saidas-rebate_uni = wa_zsdt040-netwr.
            wa_saidas-rebate_tot = wa_saidas-fkimg * wa_zsdt040-netwr.
          ENDIF.
          " Rebate - Fim

          APPEND wa_saidas TO t_saidas.
        ENDLOOP.
      ENDLOOP.

      DELETE t_saidas WHERE wrkst NOT IN s_wrkst.
      DELETE t_saidas WHERE auart NOT IN s_auart.
      DELETE t_saidas WHERE kdgrp NOT IN s_kdgrp.
      DELETE t_saidas WHERE route NOT IN s_route.
      DELETE t_saidas WHERE ort01 NOT IN s_ort01.
      DELETE t_saidas WHERE status NOT IN s_id.

* Margem de Contribuição (%) = (soma mg contrib/soma total OV)*100
      LOOP AT t_saidas INTO wa_saidas.
        wa_margem  = wa_margem  + wa_saidas-margem_c.
        wa_totalov = wa_totalov + wa_saidas-valor_ti.
      ENDLOOP.
    ENDIF.

    SORT t_saidas.
  ENDMETHOD.

  METHOD seleciona_header_prx.
    CALL FUNCTION 'ZF_ZSDR0036_NEW'
      DESTINATION 'PRD_PRX'
      EXPORTING
        s_erdat     = s_erdat[]
        s_burks     = s_burks[]
        s_vkorg     = s_vkorg[]
        s_vtweg     = s_vtweg[]
        s_spart     = s_spart[]
        s_vkgrp     = s_vkgrp[]
        s_vkbur     = s_vkbur[]
        s_ernam     = s_ernam[]
*       s_kunAG     = s_kunAG[]
        s_vbeln     = s_vbeln[]
*       s_auart     = s_auart[]
        s_fkdat     = s_fkdat[]
        s_inco1     = s_inco1[]
        s_kdgrp     = s_kdgrp[]
*       s_route     = s_route[]
        s_matnr     = s_matnr[]
        s_wrkst     = s_wrkst[]
        s_matkl     = s_matkl[]
      TABLES
        it_prx_vbrk = it_prx_vbrk
        it_prx_vbrp = it_prx_vbrp
        it_prx_mara = it_prx_mara
        it_prx_vbkd = it_prx_vbkd
        it_prx_kna1 = it_prx_kna1
        it_prx_knvv = it_prx_knvv
        it_prx_konv = it_prx_konv
        it_prx_vbak = it_prx_vbak
        it_prx_vbap = it_prx_vbap
        it_prx_adrc = it_prx_adrc.

    it_knvv[] = it_prx_knvv[].

    SORT: it_prx_vbrk, it_prx_vbrp, it_prx_mara, it_prx_vbkd,
          it_prx_kna1, it_prx_knvv, it_prx_konv, it_prx_vbak,
          it_prx_vbap, it_prx_adrc.
    SORT it_prx_vbap BY vbeln posnr.
    IF NOT s_aubel[] IS INITIAL.
      DELETE it_prx_vbrp WHERE NOT aubel IN s_aubel.
    ENDIF.
    IF NOT s_werks[] IS INITIAL.
      DELETE it_prx_vbrp WHERE NOT werks IN s_werks.
    ENDIF.
    it_vbak_aux[] = it_vbak[].
    it_vbrp_aux[] = it_vbrp[].
    it_vbrk_aux[] = it_vbrk[].

  ENDMETHOD.

  METHOD monta_header_prx.

    LOOP AT it_prx_vbrk INTO wa_vbrk.
      wa_header-sysid = 'PRX'.

      MOVE-CORRESPONDING wa_vbrk TO wa_header.
      CLEAR wa_kna1.
      READ TABLE it_prx_kna1 INTO wa_kna1 WITH KEY
                             kunnr = wa_vbrk-kunag
                                  BINARY SEARCH.
      CLEAR wa_adrc.
      READ TABLE it_prx_adrc INTO wa_adrc WITH KEY
                                      addrnumber = wa_kna1-adrnr
                                      BINARY SEARCH.

      wa_header-cep = wa_adrc-post_code1.

      CONCATENATE wa_adrc-sort1 wa_adrc-sort2 INTO wa_header-sortl.

      wa_header-name1 = wa_kna1-name1.
      wa_header-ort01 = wa_kna1-ort01.
      wa_header-regio = wa_kna1-regio.

      READ TABLE t_tspat INTO wa_tspat WITH KEY
                         spart = wa_header-spart BINARY SEARCH.
      wa_header-vtextt = wa_tspat-vtext.

      READ TABLE t_tvtwt INTO wa_tvtwt WITH KEY
                         vtweg = wa_header-vtweg BINARY SEARCH.
      wa_header-vtextg = wa_tvtwt-vtext.

      CLEAR wa_knvv.
      READ TABLE it_knvv INTO wa_knvv
                         WITH TABLE KEY kunnr = wa_vbrk-kunag
                                        vkorg = wa_vbrk-vkorg
                                        vtweg = wa_vbrk-vtweg
                                        spart = wa_vbrk-spart.

      wa_header-kdgrp = wa_knvv-kdgrp.
      CLEAR wa_t151t.
      READ TABLE it_t151t INTO wa_t151t WITH KEY spras = sy-langu
                                             kdgrp = wa_header-kdgrp.

      wa_header-ktext = wa_t151t-ktext.

      CLEAR wa_vbrp.
      READ TABLE it_prx_vbrp INTO wa_vbrp
                         WITH KEY vbeln = wa_vbrk-vbeln
                            BINARY SEARCH.
      CHECK sy-subrc EQ 0.
      IF sy-subrc NE 0.
*        BREAK-POINT.
      ENDIF.

      MOVE-CORRESPONDING wa_vbrp TO wa_header.

      READ TABLE it_prx_vbak INTO wa_vbak WITH KEY
                                          vbeln = wa_vbrp-aubel.
      IF sy-subrc IS INITIAL.
        wa_header-auart = wa_vbak-auart.
        wa_header-erdat = wa_vbak-erdat.
        wa_header-augru = wa_vbak-augru.
        wa_header-ernam = wa_vbak-ernam.
      ENDIF.

      CLEAR wa_tvaut.
      READ TABLE it_tvaut INTO wa_tvaut WITH KEY augru = wa_vbak-augru
                                   BINARY SEARCH.
      wa_header-bezeia = wa_tvaut-bezei.

      READ TABLE it_prx_vbap INTO wa_vbap WITH KEY
                                           vbeln = wa_vbrp-aubel
                                               BINARY SEARCH.
      IF sy-subrc NE 0.
*        BREAK-POINT.
      ENDIF.
      wa_header-route = wa_vbap-route.
      wa_header-abgru = wa_vbap-abgru.

      CLEAR wa_tvak.
      READ TABLE it_tvak INTO wa_tvak WITH KEY auart = wa_vbak-auart
                                               BINARY SEARCH.
      wa_header-vbtyp = wa_tvak-vbtyp.

      CLEAR wa_tvrot.
      READ TABLE it_tvrot INTO wa_tvrot WITH TABLE KEY
                               spras = sy-langu
                               route = wa_header-route.
      wa_header-vtext = wa_tvrot-bezei.

      CLEAR wa_tvgrt.
      READ TABLE it_tvgrt INTO wa_tvgrt WITH TABLE KEY
                               spras = sy-langu
                               vkgrp = wa_vbrp-vkgrp.
      wa_header-bezei = wa_tvgrt-bezei.

      CLEAR wa_tvkbt.
      READ TABLE it_tvkbt INTO wa_tvkbt WITH TABLE KEY
                               spras = sy-langu
                               vkbur = wa_vbrp-vkbur.
      wa_header-bezeit = wa_tvkbt-bezei.

      LOOP AT it_prx_konv INTO wa_konv WHERE knumv EQ wa_vbrk-knumv.
        CASE wa_konv-kschl.
          WHEN 'ZPRF'.
            wa_header-total_ov = wa_header-total_ov + wa_konv-kwert.
          WHEN 'ZPR0'.
            wa_header-total_cs = wa_header-total_cs + wa_konv-kwert.
          WHEN 'ZCED' OR 'ZCID'.
            wa_header-total_cm = wa_header-total_cm + wa_konv-kwert.
          WHEN 'BX13'.
            wa_header-total_ic = wa_header-total_ic + wa_konv-kwert.
          WHEN 'BX72' OR 'BX82'.
            wa_header-total_pc = wa_header-total_pc + wa_konv-kwert.
          WHEN 'BX23'.
            wa_header-total_ipi = wa_header-total_ipi + wa_konv-kwert.
        ENDCASE.
      ENDLOOP.

      wa_header-total_ir = 0. "wa_header-total_ov * ( p_ircsll / 100 ).

      IF wa_header-inco1 NE 'FOB'.
        wa_header-total_fr = wa_header-total_ov * ( p_pfrete / 100 ).
      ELSE.
        wa_header-total_fr = 0.
      ENDIF.

      wa_header-total_cf = wa_header-total_ov * ( p_cfixo / 100 ).

      IF wa_header-total_ov IS NOT INITIAL.
        IF wa_header-auart EQ 'ZDOA'.
          wa_header-margem_c = 1 *
      ( wa_header-total_cs + wa_header-total_pc + wa_header-total_ic +
        wa_header-total_ir + wa_header-total_cm + wa_header-total_fr ).

          wa_header-pmargem_c = 100 *
       ( wa_header-total_cs + wa_header-total_pc + wa_header-total_ic +
        wa_header-total_ir + wa_header-total_cm + wa_header-total_fr )
         / wa_header-total_ov.
        ELSE.
          wa_header-margem_c =
        ( wa_header-total_ov - wa_header-total_cs - wa_header-total_ic -
          wa_header-total_pc - wa_header-total_ir - wa_header-total_fr -
          wa_header-total_cm ).

          wa_header-pmargem_c = ( ( wa_header-total_ov -
          wa_header-total_cs - wa_header-total_ic - wa_header-total_pc -
        wa_header-total_ir - wa_header-total_fr - wa_header-total_cm ) /
        wa_header-total_ov ) * 100.

        ENDIF.

        IF r_sin EQ 'X'.
          wa_header-pzmedpon =  wa_header-pzmed * wa_header-total_ov.
        ENDIF.


      ENDIF.

      IF wa_header-auart = 'ZDOA'.
        wa_header-margem_c  = wa_header-margem_c * -1.
        wa_header-pmargem_c = wa_header-pmargem_c * -1.
      ENDIF.

      IF wa_header-vbtyp NE 'C'.
        wa_header-margem_c  = wa_header-margem_c * -1.
        wa_header-pmargem_c = wa_header-pmargem_c * -1.
        wa_header-total_ov  = wa_header-total_ov * -1.
        wa_header-total_cs  = wa_header-total_cs * -1.
        wa_header-total_cm  = wa_header-total_cm * -1.
        wa_header-total_ic  = wa_header-total_ic * -1.
        wa_header-total_pc  = wa_header-total_pc * -1.
        wa_header-total_ir  = wa_header-total_ir * -1.
        wa_header-total_ipi = wa_header-total_ipi * -1.
        wa_header-total_fr  = wa_header-total_fr * -1.
        wa_header-total_cf  = wa_header-total_cf * -1.
      ENDIF.


      PERFORM prazo_med_header  CHANGING wa_header.


      APPEND wa_header TO it_header_prx.
      IF r_sin = 'X'.
        MOVE-CORRESPONDING wa_header TO wa_saida.
        PERFORM set_flag USING wa_saida-pmargem_c
                     CHANGING wa_saida-status.
        REFRESH wa_saida-t_color[].
        IF wa_header-total_ov < 0.
          set_cell_color( EXPORTING
*                        i_colname = 'TOTAL_OV' "Opcional
                          i_color   = 6
                        CHANGING
                        cs_vbak   = wa_saida ).
        ENDIF.

* Bonificações
        IF wa_saida-auart EQ 'ZDOA'.
          set_cell_color( EXPORTING
*                            i_colname = 'VALOR_TI' "Opcional
                          i_color   = 7
                        CHANGING
                        cs_vbak   = wa_saida ).
        ENDIF.

        APPEND wa_saida TO t_saida.
      ENDIF.
      CLEAR wa_header.
    ENDLOOP.

    SORT t_saida.

    DELETE t_saida WHERE auart NOT IN s_auart.
    DELETE t_saida WHERE kdgrp NOT IN s_kdgrp.
    DELETE t_saida WHERE route NOT IN s_route.
    DELETE t_saida WHERE ort01 NOT IN s_ort01.
    DELETE t_saida WHERE status NOT IN s_id.
    DELETE t_saida WHERE kunag NOT IN s_kunag.
    DELETE t_saida WHERE ernam NOT IN s_ernam.

* Margem de Contribuição (%) = (soma mg contrib/soma total OV)*100
    LOOP AT t_saida INTO wa_saida.
      wa_margem  = wa_margem  + wa_saida-margem_c.
      wa_totalov = wa_totalov + wa_saida-total_ov.
    ENDLOOP.
*    wa_pmargem = ( wa_margem / wa_totalov ) * 100.
* Margem de Contribuição (%) = (soma mg contrib/soma total OV)*100
    SORT it_header_prx.
    IF r_ana = 'X'.
* Analitico
      SORT it_header_prx BY vbeln.
      LOOP AT it_prx_vbrp INTO wa_vbrp.
        CLEAR wa_vbap.
        READ TABLE it_prx_vbap INTO wa_vbap WITH KEY
                                vbeln = wa_vbrp-aubel
                                posnr = wa_vbrp-aupos
                                BINARY SEARCH.
        CLEAR wa_header.
        READ TABLE it_header_prx INTO wa_header
                    WITH KEY vbeln = wa_vbrp-vbeln
                    BINARY SEARCH.
        CHECK sy-subrc EQ 0.
        CLEAR wa_item.
        READ TABLE t_t023t INTO wa_t023t WITH KEY
                        matkl = wa_vbrp-matkl BINARY SEARCH.
        wa_item-abgru = wa_vbap-abgru.
        wa_item-vbeln = wa_vbrp-vbeln.
        wa_item-matnr = wa_vbrp-matnr.
        wa_item-arktx = wa_vbrp-arktx.
        wa_item-matkl = wa_vbrp-matkl.
        wa_item-fkimg = wa_vbrp-fkimg.
        wa_item-vrkme = wa_vbrp-vrkme.
        wa_item-wgbez = wa_t023t-wgbez.
        wa_item-kwmeng = wa_vbap-kwmeng.
        wa_item-meins  = wa_vbap-meins.
        wa_item-klmeng = wa_vbap-klmeng.
        wa_item-pltyp_auft = wa_vbrp-pltyp_auft.
        CLEAR wa_mara.
        READ TABLE it_mara INTO wa_mara WITH KEY
              matnr = wa_vbrp-matnr BINARY SEARCH.
        wa_item-wrkst = wa_mara-wrkst.

        LOOP AT it_prx_konv INTO wa_konv
                WHERE knumv EQ wa_header-knumv AND
                      kposn EQ wa_vbrp-posnr.
          CASE wa_konv-kschl.
            WHEN 'ZPRF'. "valor unitario do item
              wa_item-valor_un = wa_konv-kbetr.
              wa_item-valor_ti = wa_konv-kwert.
              wa_item-valor_ir = 0. " wa_konv-kwert * ( lv_class_ircsll / 100 ).

              IF wa_header-inco1 NE 'FOB'.
                wa_item-valor_fr = wa_konv-kwert * ( lv_class_pfrete / 100 ).
              ELSE.
                wa_item-valor_fr = 0.
              ENDIF.

              wa_item-valor_cf = wa_konv-kwert * ( lv_class_cfixo  / 100 ).
            WHEN 'ZPR0'. "valor de custo de mercado
              wa_item-valor_cm = wa_konv-kwert.
            WHEN 'ZCED' OR 'ZCID'. "valor de comissão
              wa_item-valor_co = wa_konv-kwert.
            WHEN 'BX13'. "valor ICMS
              wa_item-valor_ic = wa_konv-kwert.
            WHEN 'BX72' OR 'BX82'. "valor pis + cofins
              wa_item-valor_pi = wa_item-valor_pi + wa_konv-kwert.
            WHEN 'BX23'. "valor IPI
              wa_item-valor_ipi = wa_konv-kwert.
          ENDCASE.
        ENDLOOP.

        wa_item-valor_ir = 0. " wa_item-valor_ti * ( p_ircsll / 100 ).

        IF wa_header-inco1 NE 'FOB'.
          wa_item-valor_fr = wa_item-valor_ti * ( p_pfrete / 100 ).
        ELSE.
          wa_item-valor_fr = 0.
        ENDIF.

        wa_item-valor_cf = wa_item-valor_ti * ( p_cfixo / 100 ).
        IF wa_header-auart EQ 'ZDOA'.
          wa_item-margem_c = 1 * (   wa_item-valor_cm +
                                     wa_item-valor_ic +
                                     wa_item-valor_pi +
                                     wa_item-valor_ir +
                                     wa_item-valor_co +
                                     wa_item-valor_fr ).
          IF NOT wa_item-valor_ti IS INITIAL.
            wa_item-pmargem_c =
                 ( wa_item-margem_c / wa_item-valor_ti ) * 100.
          ENDIF.

          IF wa_item-valor_ti IS NOT INITIAL.
            wa_item-pmargem_c = 100 * ( wa_item-valor_cm -
                                        wa_item-valor_ic -
                                         wa_item-valor_ir -
                                         wa_item-valor_co -
                                         wa_item-valor_fr ) /
                                         wa_item-valor_ti.
          ENDIF.
        ELSE. "demais categorias de venda
          IF wa_item-valor_ti IS NOT INITIAL.
            wa_item-margem_c = (
                                 wa_item-valor_ti -
                                 wa_item-valor_cm -
                                 wa_item-valor_ic -
                                 wa_item-valor_pi -
                                 wa_item-valor_ir -
                                 wa_item-valor_fr -
                                 wa_item-valor_co ).

            wa_item-pmargem_c =
                 ( wa_item-margem_c / wa_item-valor_ti ) * 100.
          ENDIF.
        ENDIF.

        IF wa_header-auart = 'ZDOA'.
          wa_item-margem_c  = wa_item-margem_c  * -1.
          wa_item-pmargem_c = wa_item-pmargem_c * -1.
        ENDIF.

        IF wa_header-vbtyp NE 'C'.
          "Para itens de cenário de devolução campos abaixo devem ser
          wa_item-valor_ti  = wa_item-valor_ti  * -1.
          wa_item-margem_c  = wa_item-margem_c  * -1.
          wa_item-pmargem_c = wa_item-pmargem_c * -1.
          wa_item-kwmeng    = wa_item-kwmeng * -1.
          wa_item-klmeng    = wa_item-klmeng * -1.
          wa_item-fkimg     = wa_item-fkimg  * -1.
          wa_item-valor_un  = wa_item-valor_un * -1.
          wa_item-valor_cm  = wa_item-valor_cm * -1.
          wa_item-valor_co  = wa_item-valor_co * -1.
          wa_item-valor_ic  = wa_item-valor_ic * -1.
          wa_item-valor_pi  = wa_item-valor_pi * -1.
          wa_item-valor_ir  = wa_item-valor_ir * -1.
          wa_item-valor_ipi = wa_item-valor_ipi * -1.
          wa_item-valor_fr  = wa_item-valor_fr * -1.
          wa_item-valor_cf  = wa_item-valor_cf * -1.
        ENDIF.

        PERFORM prazo_med_itm CHANGING wa_item.
        APPEND wa_item TO it_item_prx.
        CLEAR wa_item.

        lv_qtd_item = lv_qtd_item + 1.
      ENDLOOP.

      SORT it_item_prx BY vbeln.
      LOOP AT it_header_prx INTO wa_header.
        wa_header-sysid = 'PRX'.
        MOVE-CORRESPONDING wa_header TO wa_saidas.
        LOOP AT it_item_prx INTO wa_item WHERE vbeln = wa_header-vbeln.
          MOVE-CORRESPONDING wa_item TO wa_saidas.
          PERFORM set_flag USING wa_saidas-pmargem_c
                       CHANGING wa_saidas-status.
          REFRESH wa_saidas-t_color[].
          IF wa_saidas-valor_ti < 0.
            set_cell_colors( EXPORTING
*                            i_colname = 'VALOR_TI' "Opcional
                            i_color   = 6
                          CHANGING
                          cs_vbak   = wa_saidas ).
          ENDIF.
* Bonificações
          IF wa_saidas-auart EQ 'ZDOA'.
            set_cell_colors( EXPORTING
*                            i_colname = 'VALOR_TI' "Opcional
                            i_color   = 7
                          CHANGING
                          cs_vbak   = wa_saidas ).
          ENDIF.
          APPEND wa_saidas TO t_saidas.
        ENDLOOP.
      ENDLOOP.

    ENDIF.

    SORT t_saidas.
    DELETE t_saidas WHERE wrkst NOT IN s_wrkst.
    DELETE t_saidas WHERE auart NOT IN s_auart.
    DELETE t_saidas WHERE kdgrp NOT IN s_kdgrp.
    DELETE t_saidas WHERE route NOT IN s_route.
    DELETE t_saidas WHERE ort01 NOT IN s_ort01.
    DELETE t_saidas WHERE status NOT IN s_id.
*      lv_qtd_item = lv_qtd_item + 1.
* Margem de Contribuição (%) = (soma mg contrib/soma total OV)*100
    LOOP AT t_saidas INTO wa_saidas.
      wa_margem  = wa_margem  + wa_saidas-margem_c.
      wa_totalov = wa_totalov + wa_saidas-valor_ti.
    ENDLOOP.
  ENDMETHOD.

*
*.......................................................................
  METHOD generate_output.
* New ALV instance
*   We are calling the static Factory method which will give back
*   the ALV object reference.
*
* exception class
    DATA: lx_msg TYPE REF TO cx_salv_msg.

    IF r_sin = 'X'.
      TRY.
          cl_salv_table=>factory(
            EXPORTING
              list_display = p_list
            IMPORTING
              r_salv_table = o_alv
            CHANGING
              t_table      = t_saida ).
        CATCH cx_salv_msg INTO lx_msg.
          MESSAGE lx_msg TYPE 'E'.
      ENDTRY.
    ELSE.
      TRY.
          cl_salv_table=>factory(
            EXPORTING
              list_display = p_list
            IMPORTING
              r_salv_table = o_alv
            CHANGING
              t_table      = t_saidas ).
        CATCH cx_salv_msg INTO lx_msg.
          MESSAGE lx_msg TYPE 'E'.
      ENDTRY.
    ENDIF.

    set_top_of_page( CHANGING co_alv = o_alv ).
    set_end_of_page( CHANGING co_alv = o_alv ).
    set_pf_status( CHANGING co_alv = o_alv ).
    set_layout( CHANGING co_alv = o_alv ).
    set_display_setting( CHANGING co_alv = o_alv ).
    set_columns( CHANGING co_alv = o_alv ).
    set_sorts( CHANGING co_alv = o_alv ).
    set_aggregations( CHANGING co_alv = o_alv ).
    set_columns_technical( CHANGING co_alv = o_alv ).

*...Events
    DATA: lo_events TYPE REF TO cl_salv_events_table.
*
*   all events
    lo_events = o_alv->get_event( ).
*
*   event handler
    SET HANDLER lr_report->on_link_click FOR lo_events.
    SET HANDLER lr_report->on_user_command FOR lo_events.

* Displaying the ALV
*   Here we will call the DISPLAY method to get the output on the screen
    o_alv->display( ).
*
  ENDMETHOD.                    "generate_output

  METHOD get_default_layout.
    DATA: ls_layout TYPE salv_s_layout_info,
          ls_key    TYPE salv_s_layout_key.

    ls_key-report = sy-repid.

    ls_layout = cl_salv_layout_service=>get_default_layout(
      s_key    = ls_key
      restrict = i_restrict ).

    c_layout = ls_layout-layout.

  ENDMETHOD.                    "get_default_layout

  METHOD set_pf_status.
*
    DATA: lo_functions TYPE REF TO cl_salv_functions_list.

* Default PF-STATUS
    lo_functions = co_alv->get_functions( ).
    lo_functions->set_default( abap_true ).
*    LO_FUNCTIONS->set_export_spreadsheet( ABAP_TRUE ).
*    lo_functions->set_export_send( abap_true ).
*    lo_functions->set_export_localfile( abap_true ).
*    lo_functions->set_export_mail( abap_true ).
*    lo_functions->set_export_html( abap_true ).
*    lo_functions->set_export_xml( abap_true ).
*    lo_functions->set_export_folder( abap_true ).
*    lo_functions->set_export_wordprocessor( abap_true ).
    lo_functions->set_all( abap_true ).

* Custom PF-STATUS
*    co_alv->set_screen_status(
*      pfstatus      =  'SALV_STANDARD'
*      report        =  'SALV_DEMO_TABLE_SELECTIONS'
*      set_functions = co_alv->c_functions_all ).

  ENDMETHOD.                    "set_pf_status

  METHOD set_layout.
*
    DATA: lo_layout  TYPE REF TO cl_salv_layout,
          lf_variant TYPE slis_vari,
          ls_key     TYPE salv_s_layout_key.
*
*   get layout object
    lo_layout = co_alv->get_layout( ).
*
*   set Layout save restriction
*   1. Set Layout Key .. Unique key identifies the Differenet ALVs
    ls_key-report = sy-repid.
    lo_layout->set_key( ls_key ).
*   2. Remove Save layout the restriction.
    lo_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).
*
*   set initial Layout
    lf_variant = p_layout.
    lo_layout->set_initial_layout( lf_variant ).
*
  ENDMETHOD.                    "set_layout

  METHOD set_top_of_page.

* Set the top of list
    DATA: lr_grid  TYPE REF TO cl_salv_form_layout_grid,
          lr_gridx TYPE REF TO cl_salv_form_layout_grid,
          lr_flow  TYPE REF TO cl_salv_form_layout_flow,
          lr_pict  TYPE REF TO cl_salv_form_picture,
          lr_logo  TYPE REF TO cl_salv_form_layout_logo,
          lr_label TYPE REF TO cl_salv_form_label,
          lr_text  TYPE REF TO cl_salv_form_text.

    DATA: lv_text TYPE string.

    DATA: lv_qtd_total     TYPE i,           "Quantidade total
          lv_qtd_prd       TYPE i,           "Quantidade total PRD
          lv_qtd_prx       TYPE i,           "Quantidade total PRX
          lv_txt_qtd_total TYPE c LENGTH 10, "Texto quantidade total
          lv_txt_qtd_prd   TYPE c LENGTH 10, "Texto quantidade total PRD
          lv_txt_qtd_prx   TYPE c LENGTH 10, "Texto quantidade total PRX
          lv_txt_msg_total TYPE c LENGTH 100, "Texto descritivo total
          lv_txt_msg_prd   TYPE c LENGTH 100, "Texto descritivo total PRD
          lv_txt_msg_prx   TYPE c LENGTH 100. "Texto descritivo total PRX

    DESCRIBE TABLE it_header LINES lv_qtd_total.
    DESCRIBE TABLE it_vbrk LINES lv_qtd_prd.
    DESCRIBE TABLE it_prx_vbak LINES lv_qtd_prx.

    WRITE lv_qtd_total TO lv_txt_qtd_total.
    WRITE lv_qtd_prd TO lv_txt_qtd_prd.
    WRITE lv_qtd_prx TO lv_txt_qtd_prx.

    CONCATENATE text-l10 lv_txt_qtd_total text-l11
    INTO lv_txt_msg_total SEPARATED BY space.

    CONCATENATE text-l12 lv_txt_qtd_prd
    INTO lv_txt_msg_prd SEPARATED BY space.

    CONCATENATE text-l13 lv_txt_qtd_prx
    INTO lv_txt_msg_prx SEPARATED BY space.

    CREATE OBJECT lr_grid.

    lr_grid->create_header_information( row = 1  column = 1
                                        text = sy-title
                                        tooltip = text-t01 ).

    lr_gridx = lr_grid->create_grid( row = 2  column = 1  ).
    lr_label = lr_gridx->create_label( row = 2 column = 1
                                      text    = text-t02
                                      tooltip = text-t03 ).

    lr_text  = lr_gridx->create_text(  row = 2 column = 2
                                       text    = sy-repid
                                       tooltip = sy-repid ).

    lr_label = lr_gridx->create_label( row = 3 column = 1
                                       text    = text-t04
                                       tooltip = text-t05 ).

    lr_text  = lr_gridx->create_text(  row = 3 column = 2
                                       text = sy-datum
                                       tooltip = sy-datum ).

    lr_label = lr_gridx->create_label( row = 4 column = 1
                                      text    = text-t06
                                      tooltip = text-t07 ).
    lr_text  = lr_gridx->create_text(  row = 4 column = 2
                                       text = sy-uzeit
                                       tooltip = sy-uzeit ).

    lr_text  = lr_gridx->create_text(  row = 5 column = 2
                                       text    = lv_txt_msg_total
                                       tooltip = text-l01 ).

    lr_text = lr_gridx->create_text( row = 6 column = 2
                                       text    = lv_txt_msg_prd
                                       tooltip = text-l02 ).

    lr_text  = lr_gridx->create_text(  row = 7 column = 2
                                       text = lv_txt_msg_prx
                                       tooltip = text-l03 ).
    lr_text  = lr_gridx->create_text(  row = 8 column = 2
                                       text = text-l04
                                       tooltip = text-l04 ).
    lr_text  = lr_gridx->create_text(  row = 8 column = 3
                                       text = wa_pmargem
                                       tooltip = text-l04 ).
* Create logo layout, set grid content on left and logo image on right
    CREATE OBJECT lr_logo.
    lr_logo->set_left_content( lr_grid ).
    lr_logo->set_right_logo(  me->picture_id ).

* Set the element top_of_list
    co_alv->set_top_of_list( lr_logo ).

  ENDMETHOD.                    "set_top_of_page

  METHOD set_end_of_page.

  ENDMETHOD.                    "set_end_of_page

  METHOD set_display_setting.
*
    DATA: lo_display   TYPE REF TO cl_salv_display_settings,
          lo_selection TYPE REF TO cl_salv_selections.
*
*   get display object
    lo_display = o_alv->get_display_settings( ).
*
*   set ZEBRA pattern
    lo_display->set_striped_pattern( 'X' ).
*
*   Title to ALV
    lo_display->set_list_header( sy-title ).

* Modo de seleção de linhas/colunas
    lo_selection = o_alv->get_selections( ).
    lo_selection->set_selection_mode(
                     if_salv_c_selection_mode=>single ).


  ENDMETHOD.                    "set_display_setting

  METHOD set_columns.
*
*...Get all the Columns
    DATA:
      lo_cols                TYPE REF TO cl_salv_columns_table,
      lo_functional_settings TYPE REF TO cl_salv_functional_settings,
      lo_tooltips            TYPE REF TO cl_salv_tooltips,
      lv_value               TYPE lvc_value.

    DATA: lo_column TYPE REF TO cl_salv_column_table.

    lo_cols = o_alv->get_columns( ).
*
*   set the Column optimization
    lo_cols->set_optimize( 'X' ).

*** Aplicar Cor a Coluna inteira
*    TRY.
*        lo_column ?= lo_cols->get_column( 'ERDAT' ).
*        ls_color-col = col_total.
*        lo_column->set_color( ls_color ).
*      CATCH cx_salv_not_found.
*    ENDTRY.

*   We will set this COLOR table field name of the internal table to
*   COLUMNS tab reference for the specific colors
    TRY.
        lo_cols->set_color_column( 'T_COLOR' ).
      CATCH cx_salv_data_error.                         "#EC NO_HANDLER
    ENDTRY.

*
*...Process individual columns

*   Change the properties of the Columns KUNNR
    TRY.
        lo_column ?= lo_cols->get_column( 'SORTL' ).
        lo_column->set_long_text( text-c01 ).
        lo_column->set_medium_text( text-c02 ).
        lo_column->set_short_text( text-c03 ).
        lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.


    "aqui
    TRY.
        lo_column ?= lo_cols->get_column( 'PZMED' ).
        lo_column->set_long_text( 'Prazo Med.' ).
        lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.
    TRY.
        lo_column ?= lo_cols->get_column( 'PZMEDPON' ).
        lo_column->set_long_text( 'Pz.Med.Pond.' ).
        lo_column->set_output_length( 20 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.
    TRY.
        lo_column ?= lo_cols->get_column( 'CREDITO' ).
        lo_column->set_long_text( 'Credito' ).
        lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.



*   Change the properties of the Columns KUNNR
    TRY.
        lo_column ?= lo_cols->get_column( 'AUBEL' ).
        lo_column->set_long_text( text-c04 ).
        lo_column->set_medium_text( text-c05 ).
        lo_column->set_short_text( text-c06 ).
        lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lo_column ?= lo_cols->get_column( 'VBELN' ).
        lo_column->set_long_text( text-c07 ).
        lo_column->set_medium_text( text-c08 ).
        lo_column->set_short_text( text-c09 ).
        lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lo_column ?= lo_cols->get_column( 'XBLNR' ).
        lo_column->set_long_text( text-c11 ).
        lo_column->set_medium_text( text-c12 ).
        lo_column->set_short_text( text-c13 ).
*        lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lo_column ?= lo_cols->get_column( 'VBELN' ).
        lo_column->set_cell_type( if_salv_c_cell_type=>hotspot ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lo_column ?= lo_cols->get_column( 'AUBEL' ).
        lo_column->set_cell_type( if_salv_c_cell_type=>hotspot ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lo_column ?= lo_cols->get_column( 'STATUS' ).
        lo_column->set_icon( if_salv_c_bool_sap=>true ).
        lo_column->set_long_text( text-c10 ).
        lo_column->set_alignment( if_salv_c_alignment=>centered ).
*        lo_column->set_output_length( 20 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

*   Set the Cell Type
    TRY.
        lo_cols->set_cell_type_column( 'I_CELLTYPE' ).
      CATCH cx_salv_data_error.                         "#EC NO_HANDLER
    ENDTRY.

*...Tooltips
    lo_functional_settings = o_alv->get_functional_settings( ).
    lo_tooltips = lo_functional_settings->get_tooltips( ).
    TRY.
        lv_value = icon_green_light.
        lo_tooltips->add_tooltip(
          type    = cl_salv_tooltip=>c_type_icon
          value   = lv_value
       tooltip = text-r01 ).                                "#EC NOTEXT
      CATCH cx_salv_existing.                           "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lv_value = icon_yellow_light.
        lo_tooltips->add_tooltip(
          type    = cl_salv_tooltip=>c_type_icon
          value   = lv_value
       tooltip = text-r02 ).                                "#EC NOTEXT
      CATCH cx_salv_existing.                           "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lv_value = icon_red_light.
        lo_tooltips->add_tooltip(
          type    = cl_salv_tooltip=>c_type_icon
          value   = lv_value
       tooltip = text-r03 ).                                "#EC NOTEXT
      CATCH cx_salv_existing.                           "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lo_column ?= lo_cols->get_column( 'REBATE_UNI' ).
        lo_column->set_long_text( text-c14 ).
        lo_column->set_medium_text( text-c18 ).
        lo_column->set_short_text( text-c19 ).

        "lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lo_column ?= lo_cols->get_column( 'REBATE_TOT' ).
        lo_column->set_long_text( text-c15 ).
        lo_column->set_medium_text( text-c16 ).
        lo_column->set_short_text( text-c17 ).

        "lo_column->set_output_length( 10 ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.


  ENDMETHOD.                    "set_columns

  METHOD set_sorts.
*
    DATA: lo_sort TYPE REF TO cl_salv_sorts.
*
*   get Sort object
    lo_sort = co_alv->get_sorts( ).
*
*   Set the SORT on the AUART with Subtotal
    TRY.
        CALL METHOD lo_sort->add_sort
          EXPORTING
            columnname = 'SYSID'
            subtotal   = if_salv_c_bool_sap=>false.

      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
    ENDTRY.

*    TRY.
*        CALL METHOD lo_sort->add_sort
*          EXPORTING
*            columnname = 'VTWEG'
*            subtotal   = if_salv_c_bool_sap=>true.
*
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.
*
*    TRY.
*        CALL METHOD lo_sort->add_sort
*          EXPORTING
*            columnname = 'SPART'
*            subtotal   = if_salv_c_bool_sap=>true.
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.
*
*    TRY.
*        CALL METHOD lo_sort->add_sort
*          EXPORTING
*            columnname = 'VKGRP'
*            subtotal   = if_salv_c_bool_sap=>true.
*
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.
*
*    TRY.
*        CALL METHOD lo_sort->add_sort
*          EXPORTING
*            columnname = 'KDGRP'
*            subtotal   = if_salv_c_bool_sap=>true.
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.
*
*    TRY.
*        CALL METHOD lo_sort->add_sort
*          EXPORTING
*            columnname = 'SPART'
*            subtotal   = if_salv_c_bool_sap=>true.
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.
*
*    TRY.
*        CALL METHOD lo_sort->add_sort
*          EXPORTING
*            columnname = 'AUART'
*            subtotal   = if_salv_c_bool_sap=>true.
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.
*
*    TRY.
*        CALL METHOD lo_sort->add_sort
*          EXPORTING
*            columnname = 'KUNNR'
*            subtotal   = if_salv_c_bool_sap=>true.
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.

**
*    TRY.
**    call method lo_sort->get_compressed_subtotal.
**      receiving
**        value  = 'AUART'.
*      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
*      CATCH cx_salv_existing .                          "#EC NO_HANDLER
*      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
*    ENDTRY.

  ENDMETHOD.                    "set_sorts

  METHOD set_cell_color.

    DATA: ls_s_color TYPE lvc_s_scol.

*   Para colorir a linha inteira ocultar o nome da coluna

    CLEAR ls_s_color.
    ls_s_color-fname     = i_colname.         "Nome Coluna
    ls_s_color-color-col = i_color.
    ls_s_color-color-int = 0.
    ls_s_color-color-inv = 0.
    APPEND ls_s_color TO cs_vbak-t_color.

  ENDMETHOD.                    "set_cell_color

  METHOD set_cell_colors.

    DATA: ls_s_color TYPE lvc_s_scol.

*   Para colorir a linha inteira ocultar o nome da coluna

    CLEAR ls_s_color.
    ls_s_color-fname     = i_colname.         "Nome Coluna
    ls_s_color-color-col = i_color.
    ls_s_color-color-int = 0.
    ls_s_color-color-inv = 0.
    APPEND ls_s_color TO cs_vbak-t_color.

  ENDMETHOD.                    "set_cell_color
  METHOD set_aggregations.
*
    DATA: lo_aggrs TYPE REF TO cl_salv_aggregations,
          lo_aggr  TYPE REF TO cl_salv_aggregation,
          lv_bool  TYPE sap_bool.
*
    lo_aggrs = co_alv->get_aggregations( ).

*
*   Add TOTAL for COLUMN NETWR

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_OV'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_CS'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_CM'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_IC'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_PC'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_IR'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_IPI'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_FR'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'TOTAL_CF'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_TI'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_CM'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_CO'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.


    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_IC'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_PI'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.


    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_IR'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.


    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_IPI'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.


    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_FR'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'VALOR_CF'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.

    TRY.

        CALL METHOD lo_aggrs->add_aggregation
          EXPORTING
            columnname  = 'REBATE_TOT'
            aggregation = if_salv_c_aggregation=>total.

      CATCH cx_salv_data_error .                        "#EC NO_HANDLER
      CATCH cx_salv_not_found .                         "#EC NO_HANDLER
      CATCH cx_salv_existing .                          "#EC NO_HANDLER
    ENDTRY.
*
*   Bring the total line to top
*    lo_aggrs->set_aggregation_before_items( ).
*
  ENDMETHOD.                    "set_aggregations

  METHOD set_cell_type.

    DATA: lt_celltype TYPE salv_t_int4_column.
    DATA: ls_celltype LIKE LINE OF lt_celltype.

*   Para cada registro da tabela que será exibida deve informar o estilo
*   da coluna que deseja alterar

    ls_celltype-columnname = 'VBELN'.
    ls_celltype-value      = if_salv_c_cell_type=>hotspot.
    APPEND ls_celltype TO lt_celltype.

    ls_celltype-columnname = 'AUBEL'.
    ls_celltype-value      = if_salv_c_cell_type=>hotspot.
    APPEND ls_celltype TO lt_celltype.
*    ls_celltype-columnname = 'ERDAT'.
*    ls_celltype-value      = if_salv_c_cell_type=>button.
*    APPEND ls_celltype TO lt_celltype.

    wa_saida-i_celltype = lt_celltype.

  ENDMETHOD.                    "set_cell_type

  METHOD set_columns_technical.

    DATA: lr_columns TYPE REF TO cl_salv_columns_table,
          lr_column1 TYPE REF TO cl_salv_column_table,
          lr_column  TYPE REF TO cl_salv_column.

    lr_columns = co_alv->get_columns( ).

    TRY.
        lr_column1 ?= lr_columns->get_column( 'MANDT' ).
        lr_column1->set_technical( if_salv_c_bool_sap=>true ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lr_column = lr_columns->get_column( 'XSTRING' ).
        lr_column->set_technical( if_salv_c_bool_sap=>true ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lr_column = lr_columns->get_column( 'TAB_INDEX' ).
        lr_column->set_technical( if_salv_c_bool_sap=>true ).
      CATCH cx_salv_not_found.                          "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.                    "set_columns_technical

* Handles the UI on the column (HotSpot)
  METHOD on_link_click.
*
    DATA: wa_saida TYPE typ_saida.
*
*   Get the Sales Order number from the table
    IF r_sin = 'X'.
      READ TABLE t_saida INTO wa_saida INDEX row.
    ELSE.
      READ TABLE t_saidas INTO wa_saidas INDEX row.
      MOVE-CORRESPONDING wa_saidas TO wa_saida.
    ENDIF.

    IF wa_saida-sysid = 'PRD'.
      CASE column.
        WHEN 'AUBEL'.
          SET PARAMETER ID 'AUN' FIELD  wa_saida-aubel.
          CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN. "#EC CI_CALLTA

        WHEN 'VBELN'.
          SET PARAMETER ID 'VF' FIELD  wa_saida-vbeln.
          CALL TRANSACTION 'VF03' AND SKIP FIRST SCREEN. "#EC CI_CALLTA

      ENDCASE.
    ELSE.
      MESSAGE i002(zmsggr).
*   Ordem de Venda/Fatura no ambiente PRX.. não é possível fazer drill-d

    ENDIF.
*
  ENDMETHOD.                    "on_link_click

* Handles the UI Command
  METHOD on_user_command.

    DATA: lo_selections TYPE REF TO cl_salv_selections,
          lt_rows       TYPE salv_t_row,
          ls_row        TYPE LINE OF salv_t_row.

    lo_selections = o_alv->get_selections( ).
    lt_rows = lo_selections->get_selected_rows( ).

    CASE e_salv_function.
      WHEN 'COMANDO1'.

    ENDCASE.

  ENDMETHOD.                    "on_user_command
ENDCLASS.                    "lcl_report IMPLEMENTATION

*&---------------------------------------------------------------------*
*&      Form  F4_LAYOUTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_TEST_RESTRICT  text
*      <--P_P_LAY06  text
*----------------------------------------------------------------------*
FORM f4_layouts
        USING i_restrict TYPE salv_de_layout_restriction ##called
             CHANGING c_layout TYPE disvariant-variant.

  DATA: ls_layout TYPE salv_s_layout_info,
        ls_key    TYPE salv_s_layout_key.

  ls_key-report = sy-repid.

  ls_layout = cl_salv_layout_service=>f4_layouts(
    s_key    = ls_key
    restrict = i_restrict ).

  c_layout = ls_layout-layout.
ENDFORM.                    " F4_LAYOUTS
*&---------------------------------------------------------------------*
*&      Form  SET_FLAG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_WA_HEADER_PMARGEM_C  text
*      <--P_WA_SAIDA_STATUS  text
*----------------------------------------------------------------------*
FORM set_flag  USING    p_margem
               CHANGING p_status.
  READ TABLE r_value INDEX 1.
  IF p_margem BETWEEN r_value-low AND r_value-high.
    p_status = icon_red_light.
  ENDIF.
  READ TABLE r_value INDEX 2.
  IF p_margem BETWEEN r_value-low AND r_value-high.
    p_status = icon_yellow_light.
  ENDIF.
  READ TABLE r_value INDEX 3.
  IF p_margem BETWEEN r_value-low AND r_value-high.
    p_status = icon_green_light.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  Z_PAI_OF_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM z_pai_of_selection_screen .
* Processo para table strip
  CASE sy-dynnr.
    WHEN 1000.
      CASE sy-ucomm.
        WHEN 'PUSH1'.
          tab_strip-dynnr = 100.
          tab_strip-activetab = 'BUTTON1'.
          MESSAGE s000(zmsggr) WITH text-b01.
        WHEN 'PUSH2'.
          tab_strip-dynnr = 200.
          tab_strip-activetab = 'BUTTON2'.
          MESSAGE s000(zmsggr) WITH text-b03.
        WHEN 'PUSH3'.
          tab_strip-dynnr = 300.
          tab_strip-activetab = 'BUTTON3'.
          MESSAGE s000(zmsggr) WITH text-b02.
        WHEN 'PUSH4'.
          tab_strip-dynnr = 400.
          tab_strip-activetab = 'BUTTON4'.
          MESSAGE s000(zmsggr) WITH text-b04.
*        WHEN 'PUSH5'.
*          TAB_STRIP-DYNNR = 500.
*          TAB_STRIP-ACTIVETAB = 'BUTTON5'.
*          MESSAGE S000(ZMSGGR) WITH TEXT-B05.
      ENDCASE.
  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_MATCHCODE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_T_SPFLI  text
*      -->P_1422   text
*      <--P_L_CONNID  text
*----------------------------------------------------------------------*
FORM f_matchcode TABLES   p_tabela
                 USING    p_campo TYPE any
                 CHANGING p_valor TYPE any.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = p_campo
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = p_campo
      value_org       = 'S'
    TABLES
      value_tab       = p_tabela
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PRAZO_MED
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_WA_ITEM  text
*----------------------------------------------------------------------*
FORM prazo_med_itm  CHANGING ls_item TYPE tp_item.

  READ TABLE it_vbrp_aux INTO wa_vbrp_aux WITH KEY vbeln = ls_item-vbeln BINARY SEARCH.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

  READ TABLE it_vbak_aux INTO wa_vbak_aux WITH KEY vbeln = wa_vbrp_aux-aubel BINARY SEARCH.
  IF sy-subrc EQ 0.
    ls_item-pzmed = (
    ( wa_vbak_aux-zzdiap +
    ( ( wa_vbak_aux-zzparc - 1 ) * wa_vbak_aux-zzdiae )
                     + wa_vbak_aux-zzdiap )
                     * wa_vbak_aux-zzdiae )
                     / 2
                     / wa_vbak_aux-zzparc.
    ls_item-pzmedpon =  ls_item-pzmed * ls_item-valor_un.

    READ TABLE it_vbap_aux INTO wa_vbap_aux WITH KEY vbeln = wa_vbak_aux-vbeln
                                                     matnr = ls_item-matnr BINARY SEARCH.
    IF sy-subrc EQ 0.
      ls_item-credito = ( ls_item-valor_un - wa_vbap_aux-ntgew ) * 60 / 100 .
    ENDIF.
  ELSE.
    SELECT vbeln zzdiap zzparc zzdiae INTO CORRESPONDING FIELDS OF  TABLE it_vbak_aux
        FROM vbak WHERE vbeln = wa_vbrp_aux-aubel.
    READ TABLE it_vbak_aux INTO wa_vbak_aux WITH KEY vbeln = wa_vbrp_aux-aubel BINARY SEARCH.
    IF sy-subrc EQ 0.
      ls_item-pzmed = (
      ( wa_vbak_aux-zzdiap +
      ( ( wa_vbak_aux-zzparc - 1 ) * wa_vbak_aux-zzdiae )
                       + wa_vbak_aux-zzdiap )
                       * wa_vbak_aux-zzdiae )
                       / 2
                       / wa_vbak_aux-zzparc.
      ls_item-pzmedpon =  ls_item-pzmed * ls_item-valor_un.

      READ TABLE it_vbap_aux INTO wa_vbap_aux WITH KEY vbeln = wa_vbak_aux-vbeln
                                                       matnr = ls_item-matnr BINARY SEARCH.
      IF sy-subrc EQ 0.
        ls_item-credito = ( ls_item-valor_un - wa_vbap_aux-ntgew ) * 60 / 100 .
      ENDIF.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PRAZO_MED_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_WA_HEADER  text
*----------------------------------------------------------------------*
FORM prazo_med_header CHANGING ls_header TYPE tp_header.

DATA ind type sy-tabix.

  READ TABLE it_vbrp_aux INTO wa_vbrp_aux WITH KEY vbeln = ls_header-vbeln BINARY SEARCH.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

*  READ TABLE it_vbak_aux INTO wa_vbak_aux WITH KEY vbeln = wa_vbrp_aux-aubel BINARY SEARCH.
*  IF sy-subrc EQ 0.
*    ls_header-pzmed = (
*    ( wa_vbak_aux-zzdiap +
*    ( ( wa_vbak_aux-zzparc - 1 ) * wa_vbak_aux-zzdiae )
*                     + wa_vbak_aux-zzdiap )
*                     * wa_vbak_aux-zzdiae )
*                     / 2
*                     / wa_vbak_aux-zzparc.
*    ls_header-pzmedpon =  ls_header-pzmed * ls_header-total_ov.
*  ENDIF.
    LOOP at it_vbak_aux into wa_vbak_aux where vbeln = wa_vbrp_aux-aubel.
      add 1 to ind.
    ls_header-pzmed = ls_header-pzmed + (
    ( wa_vbak_aux-zzdiap +
    ( ( wa_vbak_aux-zzparc - 1 ) * wa_vbak_aux-zzdiae )
                     + wa_vbak_aux-zzdiap )
                     * wa_vbak_aux-zzdiae )
                     / 2
                     / wa_vbak_aux-zzparc.

ENDLOOP.
  ls_header-pzmed = ls_header-pzmed  / ind.
  ls_header-pzmedpon = (  ls_header-pzmed * ls_header-total_ov ).


    LOOP AT it_vbap_aux INTO wa_vbap_aux WHERE vbeln = wa_vbak_aux-vbeln .
      ls_header-credito = ls_header-credito + ( ( wa_vbap_aux-netpr - wa_vbap_aux-ntgew ) * 60 / 100 ).
    ENDLOOP.

ENDFORM.
