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
var
  *border_length: int
  *border_height: int
type
  Column = object
    title: string
    width: int


proc draw_column(col: Column): string =
  
proc new_column(title: string): Column=
  col:Column = Column(title:title, width:title.len+2)
  draw_column(col)


    
