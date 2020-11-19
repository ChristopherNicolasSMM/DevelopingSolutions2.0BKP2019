FUNCTION zfmm_001.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(NUMERO_FORNECEDOR) TYPE  LIFNR OPTIONAL
*"     VALUE(NUMERO_PEDIDO_COMPRA) TYPE  EKKO-EBELN OPTIONAL
*"     VALUE(NUMERO_NF) TYPE  J_1BDOCNUM OPTIONAL
*"     VALUE(DATA_INICIO) TYPE  ERDAT OPTIONAL
*"     VALUE(DATA_FINAL) TYPE  ERDAT OPTIONAL
*"  TABLES
*"      RFC_001 TYPE  ZMM_TT_RFC_001 OPTIONAL
*"----------------------------------------------------------------------

  TYPES: BEGIN OF typ_getdata,
           ebeln TYPE ekko-ebeln, "Cabeçalho de Documento de Compras
           aedat TYPE ekko-aedat,
           lifnr TYPE ekko-lifnr,
           name1 TYPE lfa1-name1, "Nome do fornecedor
           bsart TYPE ekko-bsart,
           ebelp TYPE ekpo-ebelp, "Item de Documento de Compras
           werks TYPE ekpo-werks,
           matnr TYPE ekpo-matnr,
           maktx TYPE makt-maktx, "texto breve de materiais
           menge TYPE ekpo-menge,
           meins TYPE ekpo-meins,
           netpr TYPE ekpo-netpr,
           netwr TYPE ekpo-netwr,
           brtwr TYPE ekpo-brtwr,
           xblnr TYPE ekbe-xblnr, "Histórico de Documento de Compras
           docnr TYPE rbkp-xblnr,
           bldat TYPE rbkp-bldat, "Cabeçalho do documento recibo de faturas
           budat TYPE rbkp-budat,
           zfbdt TYPE rbkp-zfbdt,
           zbd1t TYPE rbkp-zbd1t,
           nfe   TYPE j_1bnfdoc-docnum,
           nfitm TYPE j_1bnflin-itmnum,
         END OF typ_getdata.

  DATA: ls_rfc_001 TYPE zmm_s_rfc_001,
        ls_getdata TYPE typ_getdata,
        lt_getdata TYPE STANDARD TABLE OF typ_getdata.

  DATA: r_numero_fornecedor    TYPE RANGE OF  lifnr WITH HEADER LINE,
        r_numero_pedido_compra TYPE RANGE OF  ekko-ebeln WITH HEADER LINE,
        r_numero_nf            TYPE RANGE OF  j_1bdocnum WITH HEADER LINE.



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
  IF numero_nf >= 1.
    r_numero_nf-sign = 'I'. r_numero_nf-option = 'NE'. r_numero_nf-low = numero_nf.
    IF NOT r_numero_nf-low IS INITIAL OR r_numero_nf-low > 0.
      APPEND r_numero_nf.
      CLEAR  r_numero_nf.
    ENDIF.

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
  ekbe~xblnr, "Histórico de Documento de Compras
  rbkp~xblnr AS docnr,"Histórico de Documento de Compras
  rbkp~bldat,"Cabeçalho do documento recibo de faturas
  rbkp~budat,
  rbkp~zfbdt,
  rbkp~zbd1t
*  j_1bnfdoc~inco1, "Nota Fiscal – Cabeçalho
*  j_1bnflin~docnum,
*  j_1bnflin~itmnum
  FROM ekko
  JOIN ekpo
    ON ekpo~ebeln EQ ekko~ebeln
   JOIN ekbe
    ON ekbe~ebeln EQ ekko~ebeln AND
       ekbe~ebelp EQ ekpo~ebelp

   JOIN rbkp "ekbe~xblnr
    ON rbkp~xblnr EQ ekbe~xblnr

*   INNER JOIN j_1bnflin
*    ON j_1bnflin~xped EQ ekpo~ebeln AND
*       j_1bnflin~nitemped EQ ekpo~ebelp
*
*   INNER JOIN j_1bnfdoc
*    ON j_1bnfdoc~docnum EQ j_1bnflin~docnum

   INTO TABLE @DATA(lt_select)

    WHERE  ekko~lifnr IN @r_numero_fornecedor[]     AND
           ekko~ebeln IN @r_numero_pedido_compra[]  AND
           ekko~aedat BETWEEN @data_inicio AND @data_final.


  LOOP AT lt_select ASSIGNING FIELD-SYMBOL(<fs_select>).

    ls_rfc_001-ebeln  = <fs_select>-ebeln.
    ls_rfc_001-ebelp  = <fs_select>-ebelp.
    ls_rfc_001-aedat  = <fs_select>-aedat.
    ls_rfc_001-xblnr  = <fs_select>-ebeln.
    ls_rfc_001-bldat  = <fs_select>-bldat.
    ls_rfc_001-budat  = <fs_select>-budat.
    ls_rfc_001-bsart  = <fs_select>-bsart.
    ls_rfc_001-lifnr  = <fs_select>-lifnr.
    ls_rfc_001-matnr  = <fs_select>-matnr.
    ls_rfc_001-menge  = <fs_select>-menge.

    TRY .

        CALL FUNCTION 'CONVERSION_EXIT_CUNIT_OUTPUT'
          EXPORTING
            input    = <fs_select>-meins
            language = sy-langu
          IMPORTING
            output   = ls_rfc_001-meins.
    ENDTRY.
    IF ls_rfc_001-meins IS INITIAL.

      ls_rfc_001-meins = ls_getdata-meins.
    ENDIF.

    ls_rfc_001-netpr  = <fs_select>-netpr.
    ls_rfc_001-netwr  = <fs_select>-netwr.
    ls_rfc_001-brtwr  = <fs_select>-brtwr.
    ls_rfc_001-zfbdt  = <fs_select>-zfbdt.
    ls_rfc_001-zbd1t  = <fs_select>-zbd1t.

    SELECT SINGLE maktx FROM makt INTO ls_rfc_001-maktx
       WHERE matnr EQ ls_rfc_001-matnr.

    SELECT SINGLE name1 FROM lfa1 INTO ls_rfc_001-name1
       WHERE lifnr EQ ls_rfc_001-lifnr.

*    ls_rfc_001-nfe    = <fs_select>-docnum.
*    ls_rfc_001-nfitm  = <fs_select>-itmnum.
*    ls_rfc_001-inco1  = <fs_select>-inco1.

    APPEND ls_rfc_001 TO rfc_001.
    CLEAR ls_rfc_001.
  ENDLOOP.

  LOOP AT rfc_001 INTO ls_rfc_001.

    SELECT SINGLE * FROM j_1bnflin
       INNER JOIN j_1bnfdoc
        ON j_1bnfdoc~docnum EQ j_1bnflin~docnum
      INTO @DATA(ls)
      WHERE xped EQ  @ls_rfc_001-ebeln AND
            nitemped EQ @ls_rfc_001-ebelp.

*    SELECT SINGLE * FROM vbrp
*      INNER JOIN j_1bnflin
*      ON j_1bnflin~refkey EQ vbrp~vbeln AND
*         j_1bnflin~refitm EQ vbrp~posnr
*      INNER JOIN j_1bnfdoc
*      ON j_1bnfdoc~docnum EQ j_1bnflin~docnum
*       INTO @DATA(ls)
*      WHERE vbrp~aubel EQ @ls_rfc_001-ebeln AND
*      vbrp~aupos EQ @ls_rfc_001-ebelp.
    IF sy-subrc EQ 0.
      ls_rfc_001-nfe   =  ls-j_1bnflin-docnum.
      ls_rfc_001-nfitm =  ls-j_1bnflin-itmnum.
      ls_rfc_001-inco1 =  ls-j_1bnfdoc-inco1.
    ENDIF.
    MODIFY rfc_001 FROM ls_rfc_001.

  ENDLOOP.
  IF NOT r_numero_nf IS INITIAL.
    DELETE rfc_001 WHERE nfe IN r_numero_nf[].
  ENDIF.

DELETE ADJACENT DUPLICATES FROM rfc_001 COMPARING ALL FIELDS.

ENDFUNCTION.
