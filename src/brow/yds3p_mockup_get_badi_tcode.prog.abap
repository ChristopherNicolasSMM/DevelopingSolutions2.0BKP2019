REPORT yds3p_mockup_get_badi_tcode.

TABLES : tstc, tadir, modsapt, modact, trdir, tfdir, enlfdir, tstct.
DATA : jtab LIKE tadir OCCURS 0 WITH HEADER LINE.
DATA : field1(30).
DATA : v_devclass LIKE tadir-devclass.
SELECT-OPTIONS : s_tcode FOR tstc-tcode OBLIGATORY.

LOOP AT s_tcode.

  SELECT SINGLE * FROM tstc WHERE tcode EQ s_tcode-low.
  IF sy-subrc EQ 0.
    SELECT SINGLE * FROM tadir WHERE pgmid = 'R3TR'
    AND object = 'PROG'
    AND obj_name = tstc-pgmna.
    MOVE : tadir-devclass TO v_devclass.


    IF sy-subrc NE 0.
      SELECT SINGLE * FROM trdir WHERE name = tstc-pgmna.
      IF trdir-subc EQ 'F'.
        SELECT SINGLE * FROM tfdir WHERE pname = tstc-pgmna.
        SELECT SINGLE * FROM enlfdir WHERE funcname =
        tfdir-funcname.
        SELECT SINGLE * FROM tadir WHERE pgmid = 'R3TR'
        AND object = 'FUGR'
        AND obj_name EQ enlfdir-area.

        MOVE : tadir-devclass TO v_devclass.
      ENDIF.
    ENDIF.
    SELECT * FROM tadir INTO TABLE jtab
    WHERE pgmid = 'R3TR'
    AND object = 'SMOD'
    AND devclass = v_devclass.

    SELECT SINGLE * FROM tstct WHERE sprsl EQ sy-langu AND
    tcode EQ s_tcode-low.

    FORMAT COLOR COL_POSITIVE INTENSIFIED OFF.
    WRITE:/(19) 'Transaction Code – ',
    20(20) s_tcode-low,
    45(50) tstct-ttext.
    SKIP.
    IF NOT jtab[] IS INITIAL.
      WRITE:/(95) sy-uline.
      FORMAT COLOR COL_HEADING INTENSIFIED ON.
      WRITE:/1 sy-vline,
      2 'Exit Name',
      21 sy-vline ,
      22 'Description',
      95 sy-vline.
      WRITE:/(95) sy-uline.
      LOOP AT jtab.
        SELECT SINGLE * FROM modsapt
        WHERE sprsl = sy-langu AND
        name = jtab-obj_name.
        FORMAT COLOR COL_NORMAL INTENSIFIED OFF.
        WRITE:/1 sy-vline,
        2 jtab-obj_name, "hotspot on,
        21 sy-vline ,
        22 modsapt-modtext INPUT ON,
        95 sy-vline.
        HIDE: jtab-obj_name.
      ENDLOOP.
      WRITE:/(95) sy-uline.
      DESCRIBE TABLE jtab.
      SKIP.
      FORMAT COLOR COL_TOTAL INTENSIFIED ON.
      WRITE:/ 'No of Exits:' , sy-tfill.
    ELSE.
      FORMAT COLOR COL_NEGATIVE INTENSIFIED ON.
      WRITE:/(95) 'No User Exit exists'.
    ENDIF.
  ELSE.
    FORMAT COLOR COL_NEGATIVE INTENSIFIED ON.
    WRITE:/(95) 'Transaction Code Does Not Exist'.
  ENDIF.
ENDLOOP.

AT LINE-SELECTION.
  GET CURSOR FIELD field1.
  CHECK field1(4) EQ 'JTAB'.
  SET PARAMETER ID 'MON' FIELD sy-lisel+1(10).
  CALL TRANSACTION 'SMOD' AND SKIP FIRST   SCREEN.
