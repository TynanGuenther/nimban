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


proc print_title(title: string)=
  if title.len > 10

proc draw_column(col: Column) =
  #top
  set_cursor_pos(total_width+1, 0)
  stdout.write(border_tl & border_h.repeat(column_width - 2) & border_tr)
  
  #sides
  for dy in 1..column_height-2:
    set_cursor_pos(total_width+1, dy)
    if dy >2 && dy<3
      stdout.write(border_v & " " & col.title & " " & border_v
      continue
    stdout.write(border_v)
    set_cursor_pos(total_width+ 1 + col.width, dy)
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
  

