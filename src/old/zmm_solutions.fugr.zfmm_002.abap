FUNCTION zfmm_002.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(DATA_INICIO) TYPE  ERDAT OPTIONAL
*"     VALUE(DATA_FINAL) TYPE  ERDAT OPTIONAL
*"  TABLES
*"      RFC_002 TYPE  ZMM_TT_RFC_002 OPTIONAL
*"----------------------------------------------------------------------

  SELECT
    ekko~ebeln,
    ekko~lifnr,
    ekko~zzvoltot,
    ekpo~ebelp,
    ekpo~werks,
    ekpo~lgort,
    ekpo~meins,
    ekpo~matnr,
    mbew~lbkum,
    mkpf~budat,
    mkpf~cputm,
    mbew~salk3,
    mbew~verpr,
    mseg~bwart,
    mseg~budat_mkpf
*    j_1bnfdoc~j_1bnftot
  FROM ekko
  JOIN ekpo
    ON ekpo~ebeln EQ ekko~ebeln
  JOIN mbew
    ON mbew~matnr EQ ekpo~matnr
  JOIN mseg
    ON mseg~ebeln EQ ekko~ebeln
    JOIN mkpf
    ON mkpf~mblnr EQ  mseg~mblnr
  INNER JOIN j_1bnfdoc
    ON j_1bnfdoc~docnum  EQ  ''
INTO TABLE @DATA(lt_getdata)
    WHERE  ekko~aedat BETWEEN  @data_inicio AND  @data_final
           AND ekko~lifnr <> ''.




*  LOOP AT lt_getdata ASSIGNING FIELD-SYMBOL(<fs_getdata>).
*
*    APPEND <fs_getdata> TO rfc_002.
*    CLEAR  <fs_getdata>.
*  ENDLOOP.



ENDFUNCTION.
