import os,
  strutils,
  terminal,
  unicode

const
  border_bl = "└"
  border_br = "┘"
  border_tl = "┌"
  border_tr = "┐"
  border_h = "─"
  border_v = "│"
  start_cursor = (0,0)
var
  column_length: int
  column_height: int
   
  
  
type
  Column = object
    title: string
    width: int


proc draw_column(col: Column) =
  #top
  set_cursor_pos(1,2)
  stdout.write(border_tl & border_h.repeat(column_length - 2) & border_tr)
  
  #sides
  for dy in 1..column_height-2:
    set_cursor_pos(0, 0)
    stdout.write(border_v)
    set_cursor_pos(x + column_length - 1, y + dy)
    stdout.write(border_v)
  #bottom
  set_cursor_pos(x, column_height - 1 + y)
  stdout.write(border_bl & border_h.repeat(column_length - 2) & border_br)
    
proc new_column(title: string)=
  var colun: Column
  colun = Column(title:title, width:title.len+2)
  draw_column(colun)
  

