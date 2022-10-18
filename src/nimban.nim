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
    title: Title
    height: int
    id: int
    list: seq[string]
  Title = object
    line: string
    num: int
  #Cursor_Pos = tuple
   # x: int
   # y: int 

var
  column_width: int = 17
  column_height: int 
  total_width: int
  #start_cursor: Cursor_Pos=(0,0)
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
  
proc new_title(title: string) : Title=
  var line_num:int = 1
  if title.len < 13:
    result = Title(line:title, num:line_num)
  else:
    var sep_title:seq[string] = title.split(sep="(\\w{15,})+",1)
    line_num = sep_title.len()
    result = Title(line:title, num: line_num)
proc print_title(title: Title)=
  var done:string = ""
  var line_num:int = 0
  if title.line.len < 13:
    stdout.write(border_v & " " & title.line & " " & border_v)
  else:
    var sep_title:seq[string] = title.line.split(sep="(\\w{15,})+",1)
    line_num = sep_title.len()
    for line in 0..sep_title.len()-1:
      var curr:string = sep_title[line]
      if curr[curr.len] != ' ':
        sep_title[line].add("- " & border_v & ("\r"))
        done = done & border_v & " " & sep_title[line]
      else:
        sep_title[line].add(border_v & "\r ")
        done = done & border_v & " " & sep_title[line]
  done = done & border_bl & border_h.repeat(column_width - 2) & border_br
  stdout.write(done)
  
proc draw_column(col: Column) =
  #top
  set_cursor_pos(total_width+1, 0)
  stdout.write(border_tl & border_h.repeat(column_width - 2) & border_tr)
  print_title(col.title)
  #sides
  for dy in col.title.num + 2..column_height-2:
    set_cursor_pos(total_width+1, dy)
    stdout.write(border_v)
    set_cursor_pos(total_width + 1 + column_width, dy)
    stdout.write(border_v)
  #bottom
  set_cursor_pos(total_width+1, column_height)
  stdout.write(border_bl & border_h.repeat(column_width - 2) & border_br)
  
  total_width = total_width + column_width
  #Set cursor back to the begining after drawing
  set_cursor_pos(0,0)

#[proc new_column(title: string)=
  var col: Column
  column_count+=1
  var col_list = newSeq[string](0)
  col = Column(title:title, width:title.len+2, id:column_count, list:col_list)
  columns.add(col)
  draw_column(col)]#

proc show()=
  for col in 0..columns.len():
    draw_column(columns[col])
  return

proc add_item(column_id: int, item: string)=
  #TODO
  columns[column_id-1].list.add(item)
proc new_column(title: Title)=
  var col: Column
  column_count+=1
  var col_list = newSeq[string](0)
  col = Column(title: title, height: (col_list.len * 2) + title.num, id:column_count, list:col_list)
  columns.add(col)
 

proc remove_item(column_id: int, item_id: int)=
  #TODO
  columns[column_id-1].list.delete(item_id)

proc remove_column(column_id: int)=
  #TODO
  columns.delete(column_id-1)

proc help()=
  #TODO
  
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
      new_column(new_title(paramStr(i+1))
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

