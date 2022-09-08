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
  columns:seq[Column]
  column_count: int 

proc word_count(title: string): int=
  var word: bool = false
  for i in 0..title.len:
    if title[i]==' ' or title[i] == '\n' or title[i] == '\t':
      word = false
    elif word == false:
      word = true
      result += 1
  
proc print_title(title: string): int=
  var num: int = word_count(title)
  var done:string = ""
  var line_num:int = 0
  if title.len < 15:
    stdout.write(border_v & " " & title & " " & border_v)
  else:
    var sep_title:seq[string] = title.split(sep="(\\w{15,})+",1)
    line_num = sep_title.len()
    for line in 0..sep_title.len()-1:
      var curr:string = sep_title[line]
      if curr[curr.len] != ' ':
        sep_title[line].add("- " & border_v & ("\r"))
        done = done & border_v & " " & sep_title[line]
      else:
        sep_title[line].add("\r ")
        done = done & border_v & " " & sep_title[line] & border_v
  stdout.write(done)
  return line_num
  
proc draw_column(col: Column) =
  #top
  set_cursor_pos(total_width+1, 0)
  stdout.write(border_tl & border_h.repeat(column_width - 2) & border_tr)
  
  #sides
  for dy in 1..column_height-2:
    set_cursor_pos(total_width+1, dy)
    if dy > 2 and  dy < 3:
      #find way to print title between number of lines that title takes up ie dy > 2 and dy < number_of_lines
      #print_title
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

#[proc new_column(title: string)=
  var col: Column
  column_count+=1
  var col_list = newSeq[string](0)
  col = Column(title:title, width:title.len+2, id:column_count, list:col_list)
  columns.add(col)
  draw_column(col)]#

proc show()=
  #TODO
  return

proc add_item(column_id: int, item: string)=
  #TODO
  var col:Column = columns[column_id-1]
  col.list.add(item)
  return
proc new_column(title: string)=
  var col: Column
  column_count+=1
  var col_list = newSeq[string](0)
  col = Column(title:title, width:title.len+2, id:column_count, list:col_list)
  columns.add(col)
 

proc remove_item(column_id: int, item_id: int)=
  #TODO
  var col:Column = columns[column_id-1]
  col.list.delete(item_id)
  return

proc remove_column(column_id: int)=
  #TODO
  columns.delete(column_id-1)
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
      add_item(parseInt(paramStr(i+1)),paramStr(i+2))
      continue
    of "c":
      new_column(paramStr(i+1))
      continue
    of "r":
      var item_id:int = parseInt(paramStr(i+2))
      var col_id:int = parseInt(paramStr(i+1))
      remove_item(col_id, item_id)
      continue
    of "rc":
      var column_id:int = parseInt(paramStr(i+1))
      remove_column(column_id)
      continue
    else:
      help()

