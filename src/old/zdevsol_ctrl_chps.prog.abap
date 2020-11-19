***********************************************************************
* Nome do Programa : YO_TRANS *
* Título do Programa: Editor *
* Programador : *
* Data : *
* Última Atualização: *
* *
* Descrição : Edição *
* Include : *
* Transação Chamada : *
* Requests do Progr.: *
*----------------------------------------------------------------------*
report zdevsol_ctrl_chps.
data: itab(200) type c occurs 0 with header line,
str(80).
parameters pname like trdir-name obligatory.

start-of-selection.
  check not pname is initial.
  read report pname into itab.
  check sy-subrc = 0.
  editor-call for itab backup into itab.
  if sy-subrc = 0.
    if not itab[] is initial.
      insert report pname from itab.
      if sy-subrc = 0.
        concatenate 'PROGRAMA' pname 'GRAVADO.'
        into str separated by space.
        write: / str.
      endif.
    endif.
  endif.

end-of-selection.
