FUNCTION zfmm_003.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(NUMERO_FORNECEDOR) TYPE  LIFNR OPTIONAL
*"     VALUE(NUMERO_PEDIDO_COMPRA) TYPE  EKKO-EBELN OPTIONAL
*"     VALUE(DATA_INICIO) TYPE  ERDAT OPTIONAL
*"     VALUE(DATA_FINAL) TYPE  ERDAT OPTIONAL
*"  TABLES
*"      RFC_003 TYPE  ZMM_TT_RFC_003 OPTIONAL
*"----------------------------------------------------------------------

  TYPES: BEGIN OF typ_getdata,
           ebeln TYPE ekko-ebeln, "Cabeçalho de Documento de Compras
           aedat TYPE ekko-aedat,
           lifnr TYPE ekko-lifnr,
           bsart TYPE ekko-bsart,
           ebelp TYPE ekpo-ebelp, "Item de Documento de Compras
           werks TYPE ekpo-werks,
           matnr TYPE ekpo-matnr,
           menge TYPE ekpo-menge,
           meins TYPE ekpo-meins,
           netpr TYPE ekpo-netpr,
           netwr TYPE ekpo-netwr,
           brtwr TYPE ekpo-brtwr,
           xblnr TYPE ekbe-xblnr, "Histórico de Documento de Compras
           docnr TYPE rbkp-xblnr,
           zbd1t TYPE rbkp-zbd1t,
         END OF typ_getdata.

  DATA: ls_rfc_003 TYPE zmm_s_rfc_003,
        ls_getdata TYPE typ_getdata.



**************RANGES
  DATA: r_empresa       TYPE RANGE OF  bukrs   WITH HEADER LINE,
        r_centro        TYPE RANGE OF  werks_d WITH HEADER LINE,
        r_dt_ped        TYPE RANGE OF  erdat   WITH HEADER LINE,
        r_pedido_compra TYPE RANGE OF  ebeln   WITH HEADER LINE,
        r_tipo          TYPE RANGE OF  esart   WITH HEADER LINE,
        r_fornecedor    TYPE RANGE OF  lifnr   WITH HEADER LINE,
        r_material      TYPE RANGE OF  matnr   WITH HEADER LINE.



  DATA: r_numero_fornecedor    TYPE RANGE OF  lifnr WITH HEADER LINE,
        r_numero_pedido_compra TYPE RANGE OF  ekko-ebeln WITH HEADER LINE.


  r_numero_fornecedor-sign = 'I'. r_numero_fornecedor-option = 'EQ'. r_numero_fornecedor-low = numero_fornecedor.
  IF NOT r_numero_fornecedor-low IS INITIAL OR r_numero_fornecedor-low > 0.
    APPEND r_numero_fornecedor.
    CLEAR  r_numero_fornecedor.
  ENDIF.
  r_numero_pedido_compra-sign = 'I'. r_numero_pedido_compra-option = 'EQ'. r_numero_pedido_compra-low = numero_pedido_compra.
  IF NOT r_numero_pedido_compra-low IS INITIAL OR r_numero_pedido_compra-low > 0.
    APPEND r_numero_pedido_compra.
    CLEAR  r_numero_pedido_compra.
  ENDIF.


  SELECT
  ekko~ebeln,"Cabeçalho de Documento de Compras
  ekko~aedat,
  ekko~lifnr,
  ekko~bsart,
  ekpo~ebelp,"Item de Documento de Compras
  ekpo~werks,
  ekpo~matnr,
  ekpo~menge,
  ekpo~meins,
  ekpo~netpr,
  ekpo~netwr,
  ekpo~brtwr,
  ekbe~xblnr,"Histórico de Documento de Compras
  rbkp~xblnr AS docnr,"Histórico de Documento de Compras
  rbkp~zbd1t
  FROM  ekko
   JOIN ekpo
    ON ekpo~ebeln EQ ekko~ebeln
   JOIN ekbe
    ON ekbe~ebeln EQ ekko~ebeln AND
       ekbe~ebelp EQ ekpo~ebelp
   JOIN rbkp
    ON rbkp~xblnr EQ ekbe~xblnr
INTO TABLE @DATA(lt_select)
    WHERE  ekko~lifnr IN @r_numero_fornecedor[]     AND
           ekko~ebeln IN @r_numero_pedido_compra[]  AND
           ekko~aedat BETWEEN @data_inicio AND @data_final.


  LOOP AT lt_select ASSIGNING FIELD-SYMBOL(<fs_select>).



    ls_rfc_003-ebeln  = <fs_select>-ebeln.
    ls_rfc_003-aedat  = <fs_select>-aedat.
    ls_rfc_003-lifnr  = <fs_select>-lifnr.
    ls_rfc_003-bsart  = <fs_select>-bsart.
    ls_rfc_003-ebelp  = <fs_select>-ebelp.
    ls_rfc_003-werks  = <fs_select>-werks.
    ls_rfc_003-matnr  = <fs_select>-matnr.
    ls_rfc_003-menge  = <fs_select>-menge.
    ls_rfc_003-meins  = <fs_select>-meins.
    ls_rfc_003-netpr  = <fs_select>-netpr.
    ls_rfc_003-netwr  = <fs_select>-netwr.
    ls_rfc_003-brtwr  = <fs_select>-brtwr.
    ls_rfc_003-xblnr  = <fs_select>-xblnr.
    ls_rfc_003-xblnr  = <fs_select>-xblnr.
    ls_rfc_003-zbd1t  = <fs_select>-zbd1t.

    TRY .

        CALL FUNCTION 'CONVERSION_EXIT_CUNIT_OUTPUT'
          EXPORTING
            input    = <fs_select>-meins
            language = sy-langu
          IMPORTING
            output   = ls_rfc_003-meins.
    ENDTRY.
    IF ls_rfc_003-meins IS INITIAL.

      ls_rfc_003-meins = <fs_select>-meins.
    ENDIF.


    SELECT SINGLE maktx FROM makt INTO ls_rfc_003-maktx
   WHERE matnr EQ ls_rfc_003-matnr.

    SELECT SINGLE name1 FROM lfa1 INTO ls_rfc_003-name1
       WHERE lifnr EQ ls_rfc_003-lifnr.


*    ls_rfc_003-bsart  = <fs_select>-bsart.
*    ls_rfc_003-lifnr  = <fs_select>-lifnr.
*    ls_rfc_003-matnr  = <fs_select>-matnr.
*    ls_rfc_003-menge  = <fs_select>-menge.
*    ls_rfc_003-meins  = <fs_select>-meins.
*    ls_rfc_003-netpr  = <fs_select>-netpr.
*    ls_rfc_003-netwr  = <fs_select>-netwr.
*    ls_rfc_003-brtwr  = <fs_select>-brtwr.
*    ls_rfc_003-zbd1t  = <fs_select>-zbd1t.
    APPEND ls_rfc_003 TO rfc_003.
    CLEAR ls_rfc_003.
  ENDLOOP.


ENDFUNCTION.
