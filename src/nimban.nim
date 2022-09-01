import os,
  strutils,
  terminal,
  unicode

const
  #Borders
  border_bl = "└"
  border_br = "┘"
  border_tl = "┌"
  border_tr = "┐"
  border_h = "─"
  border_v = "│"
type
  #
  Column = object
    title: string
    width: int
    id: int
    list: seq[string]
  Cursor_Pos = tuple
    x: int
    y: int 

var
  column_width: int
  column_height: int
  total_width: int
  start_cursor: Cursor_Pos=(0,0)
  columns = newSeq[Column](0)
  column_count: int 

proc word_count(title: string): int=
  var word: bool = false
  for i in 0..title.len:
    if title[i]==' ' or title[i] == '\n' or title[i] == '\t':
      word = false
    elif word == false:
      word = true
      result += 1
  
proc print_title(title: string)=
  var num: int = word_count(title)
  if title.len < 15:
    stdout.write(title)
  elif title[15] != ' ':
    addSep(dest:title, sep:"-\r")

proc draw_column(col: Column) =
  #top
  set_cursor_pos(total_width+1, 0)
  stdout.write(border_tl & border_h.repeat(column_width - 2) & border_tr)
  
  #sides
  for dy in 1..column_height-2:
    set_cursor_pos(total_width+1, dy)
    if dy > 2 and  dy < 3:
      stdout.write(border_v & " " & col.title & " " & border_v)
      continue
    stdout.write(border_v)
    set_cursor_pos(total_width + 1 + col.width, dy)
    stdout.write(border_v)
  #bottom
  set_cursor_pos(total_width+1, column_height)
  stdout.write(border_bl & border_h.repeat(column_width - 2) & border_br)
  
  #Set cursor back to the begining after drawing
  set_cursor_pos(start_cursor.x, start_cursor.y)

proc new_column(title: string)=
  var col: Column
  column_count+=1
  var col_list = newSeq[string](0)
  col = Column(title:title, width:title.len+2, id:column_count, list:col_list)
  columns.add(col)
  draw_column(col)

proc show()=
  #TODO
  return

proc add_item(item: string)=
  #TODO
  return
proc add_column(title: string)=
  #TODO
  return
proc remove_item(item: int)=
  #TODO
  return

proc remove_column(column: int)=
  #TODO
  return

proc help()=
  #TODO
  return
  
proc process_args(args: seq[string])=
  if paramCount() < 1:
     show()
  for i in 0..paramCount():
    case paramStr(i):
    of "s":
      show()
      continue
    of "i":
      add_item(paramStr(i+1))
      continue
    of "c":
      add_column(paramStr(i+1))
      continue
    of "r":
      var item_id:int = parseInt(paramStr(i+1))
      remove_item(item_id)
      continue
    of "rc":
      var column_id:int = parseInt(paramStr(i+1))
      remove_column(column_id)
      continue
    else:
      help()

