#############################################################################
##
#W Geekotopia: Educational GAP tools and utilities (Kameahāʻaweokaponia ʻIʻi)
##  Installation file for functions of the Geekotopia package.
##
## Implementations
##
#############################################################################
filename@ := "/home/geeko/.gap/pkg/Geekotopia/data/sortedRGB.csv";
MakeReadOnlyGlobal("filename@");

#############################################################################
## ANSI Escape Code (cf. https://en.wikipedia.org/wiki/ANSI_escape_code)
##
## PREDEFINED TextAttr CODES
## TextAttr.CSI == "\033[" ................... CSI
## TextAttr.reset == TextAttr.CSI,0,"m" ...... SGR(0) - Reset/Normal (all attributes off)
## TextAttr.bold == TextAttr.CSI,1,"m" ....... SGR(1) - bold
## TextAttr.underscore == TextAttr.CSI,4,"m" . SGR(4) - Underline single
## TextAttr.blink == TextAttr.CSI,5,"m" ...... SGR(5) - blink
## TextAttr.reverse == TextAttr.CSI,7,"m" .... SGR(7) - Image: Negative (swap fg and bg)
## TextAttr.normal == TextAttr.CSI,22,"m" .... SGR(22) - Normal color or intensity (no bold)
## TextAttr.0 == TextAttr.CSI,30,"m" ......... SGR(30) - foreground (black)
## TextAttr.1 == TextAttr.CSI,31,"m" ......... SGR(31) - foreground (red)
## TextAttr.2 == TextAttr.CSI,32,"m" ......... SGR(32) - foreground (green)
## TextAttr.3 == TextAttr.CSI,33,"m" ......... SGR(33) - foreground (yellow)
## TextAttr.4 == TextAttr.CSI,34,"m" ......... SGR(34) - foreground (blue)
## TextAttr.5 == TextAttr.CSI,35,"m" ......... SGR(35) - foreground (magenta)
## TextAttr.6 == TextAttr.CSI,36,"m" ......... SGR(36) - foreground (cyan)
## TextAttr.7 == TextAttr.CSI,37,"m" ......... SGR(37) - foreground (white)
## TextAttr.b0 == TextAttr.CSI,40,"m" ........ SGR(40) - background color (black)
## TextAttr.b1 == TextAttr.CSI,41,"m" ........ SGR(41) - background color (red)
## TextAttr.b2 == TextAttr.CSI,42,"m" ........ SGR(42) - background color (green)
## TextAttr.b3 == TextAttr.CSI,43,"m" ........ SGR(43) - background color (yellow)
## TextAttr.b4 == TextAttr.CSI,44,"m" ........ SGR(44) - background color (blue)
## TextAttr.b5 == TextAttr.CSI,45,"m" ........ SGR(45) - background color (magenta)
## TextAttr.b6 == TextAttr.CSI,46,"m" ........ SGR(46) - background color (cyan)
## TextAttr.b7 == TextAttr.CSI,47,"m" ........ SGR(47) - background color (white)
## TextAttr.delline == TextAttr.CSI,2,"K" .... EL(2) - Erase entire line; keep cursor position
## TextAttr.home == TextAttr.CSI,1,"G" ....... CHA(1) - Cursor Horizontal Attribute (moves cursor home)
##################################################################################################
## DEFINITIONS
## CSI n A ............. CUU (Cursor Up)       Moves the cursor n cells in the given direction.
## CSI n B ............. CUD (Cursor Down)      If the cursor is already at the edge of the
## CSI n C ............. CUF (Cursor Forward)   screen, this has no effect.
## CSI n D ............. CUB (Cursor Back)
## -----------------------------------------------------------------------------------------------
## CSI n E ............. CNL (Cursor Next Line) Moves cursor to beginning of the lin n lines down.
## -----------------------------------------------------------------------------------------------
## CSI n F ............. CPL (Cursor Prev Line) Moves cursor to bening of the line n lines up.
## -----------------------------------------------------------------------------------------------
## CSI n G ............. CHA (Cursor Horizontal Absolute) Moves cursor to column n.
## -----------------------------------------------------------------------------------------------
## CSI n;m H ........... CUP (Cursor Position)  Moves cursor to row n, column m.
## -----------------------------------------------------------------------------------------------
## CSI n J ............. ED (Erase in Display)  Clears part of screen (n={0,1,2,3})
##                                               0=to end of screen, 1=to beginning of screen,
##                                               2=clear entire screen, 3=same as 2, del scrollback
## -----------------------------------------------------------------------------------------------
## CSI n K ............. EL (Erase in Line)     Clears part of the line.  (n={0,1,2})
##                                               0=to end of line;1=to beginning of line;
##                                               2=entire line w/o affecting cursor position
## -----------------------------------------------------------------------------------------------
## CSI n S ............. SU (Scroll Up)         Scroll whole page up by n lines.
## -----------------------------------------------------------------------------------------------
## CSI n T ............. SD (Scroll Down)       Scroll whole page down by n lines.
## -----------------------------------------------------------------------------------------------
## CSI n;m f ........... HVP (Horizontal & Vertical Position) Same as CUP
## -----------------------------------------------------------------------------------------------
## CSI n m ............. SGR (Select Graphic Rendition)
## -----------------------------------------------------------------------------------------------
## CSI 5i .............. AUX Port On            OBSOLETE
## -----------------------------------------------------------------------------------------------
## CSI 4i .............. AUX Port Off           OBSOLETE
## -----------------------------------------------------------------------------------------------
## CSI 6n .............. DSR (Device Status Report) Reports the cursor position.
## -----------------------------------------------------------------------------------------------
## CSI s ............... SCP (Save Cursor Position)
## -----------------------------------------------------------------------------------------------
## CSI u ............... RCP (Restore Cursor Position)
## -----------------------------------------------------------------------------------------------
## CSI ?25l ............ DECTCEM (Hides the cursor)
## -----------------------------------------------------------------------------------------------
## CSI ?25h ............ DECTCEM (Shows the cursor)
##################################################################################################
## SGR Parameters
## 0  ...... Reset/Normal                All attributes off
## 1  ...... Bold (increased intensity)
## 2  ...... Faint (decreased intensity)
## 3  ...... Italic on
## 4  ...... Underline: Single
## 5  ...... Blink: Slow
## 6  ...... Blink: Rapid
## 7  ...... Image: Negative             Inverse/Reverse; swap fg and bg
## 8  ...... Conceal
## 9  ...... Crossed-out                 Characters legible, but marked for deletion
## 10 ...... Primary (default) font
## 11-19 ... n-th alternate font         14 being the 4th, up to 19 being the 9th alternate font
## 20 ...... Fraktur			 (Unavailable) 
## 21 ...... Bold off or Double Underline
## 22 ...... Normal color/intensity
## 23 ...... Not italic; not Fraktur
## 24 ...... Underline off
## 25 ...... Blink off
## 27 ...... Inverse off
## 28 ...... Reveal			 Conceal off
## 29 ...... Not crossed out
## 30-37 ... Set foreground color
## 38 ...... Set foreground color        Next arguments are 5;n or 2;r;g;b
## 39 ...... Default foreground color
## 40-47 ... Set background color
## 48 ...... Set background color        Next arguments are 5;n or 2;r;g;b
## 49 ...... Default background color
## 51 ...... Framed
## 52 ...... Encircled
## 53 ...... Overlined
## 54 ...... Not framed or encircled
## 55 ...... Not overlined
## 60 ...... ideogram underline or right side line
## 61 ...... ideogram double underline or doublie line on right side
## 62 ...... ideogram overline or left side line
## 63 ...... ideogram double overline or double line on left side
## 64 ...... ideogram stress marking
## 65 ...... ideogram attributes off
## 90-97 ... Set bright foreground color
## 100-107.. Set bright background color
##################################################################################################


#############################################################################
##
#F  xxxx() . . . .Description of xxxx 
##
#InstallGlobalFunction( xxxx, function( color )
#end );


#############################################################################
##
#F  BackgroundColor() . . . . Changes the background color 
##
InstallGlobalFunction( BackgroundColor, function( color )
  Print( "\033]11;", color, "\007" );
end );
#############################################################################


#############################################################################
##
#F  Backgrounds() . . . . Cycles through colors, changing background
##
InstallGlobalFunction( Backgrounds, function()
local palette, iterator, item, line;
  palette := LoadColors(filename@);
  iterator := Iterator(palette);
  for item in iterator do
    BackgroundColor(item.COLOR);
    ForegroundColor("black");
    Print( item.COLOR, " = [" );
    if IsBound( item.ALIAS ) then
       Print(item.ALIAS);
    fi;
    Print("] (", CanonicalColor( item ), ")\n");
    Exec("sleep 0.5");
  od;
  return; 
end );
#############################################################################


#############################################################################
##
#F  CanonicalColor ( a ) 
##
InstallGlobalFunction( CanonicalColor, function( a )
local red, green, blue;
  red := HexStringInt( a.RED );
  green := HexStringInt( a.GREEN );
  blue := HexStringInt( a.BLUE );
  if Length(red) = 1 then
     red := Concatenation( "0", red );
  fi;
  if Length(green) = 1 then
     green := Concatenation( "0", green );
  fi;
  if Length(blue) = 1 then
     blue := Concatenation( "0", blue );
  fi;
  return Concatenation(red, green, blue);
end );
#############################################################################


#############################################################################
##
#F  CanonicalizeColorData ( colors )
##
InstallGlobalFunction( CanonicalizeColorData, function ( colors )
local iterator, item;
  iterator := Iterator( colors );
  for item in iterator do
    item.COLOR := Capitalize( item.COLOR );
  od; 
  return;
end );
#############################################################################


#############################################################################
##
#F  Capitalize ( word )
##
InstallGlobalFunction( Capitalize, function( word )
local capNext, c;
  capNext := true;
  for c in [1..Length(word)] do
    if capNext and IsAlphaChar(word[c]) then
      word[c] := UppercaseChar( word[c] );
      capNext := false;
    elif word[c] = ' ' then
      # mark space with '\<' (LineBreak) and cap the next char
      capNext := true;
      word[c] := '\<';
    fi;
  od;
  # Remove LineBreaks which are marking spots where spaces where
  word := StripLineBreakCharacters( word );
  return word;
end );
#############################################################################


#############################################################################
##
#F  Cls() . . . . Clear screen
##
InstallGlobalFunction( Cls, function()
  Print( TextAttr.CSI, 2, "J" ); # Clears Screen
  Print( TextAttr.CSI, 1, ";", 1, "H" );
end );
#############################################################################


#############################################################################
##
#F  Commatize( <num> ) . . . . . . . .   format a number with commas
##
InstallGlobalFunction( Commatize, function( nbr )
  local commas, count, i, m, part, parts, pos0, pos1, str, strlen;
  str := String(nbr);
  strlen := Length(str);
  m := strlen mod 3;
  if not m = 0 then
    part := str{[1..m]};
    pos0 := m+1;
  elif strlen = 3 then
    part := str;
    pos0 := 0;
  else                          # m = 0 AND strlen <> 3
    part := str{[1..3]};
    pos0 := 4;
  fi;
  count := Length(part);
  commas := (strlen - count)/3;
  if count = 0 then
    parts := [];
  else
    parts := [ part ];
  fi;
  for i in [1..commas] do
    pos1 := pos0 + 2;
    part := str{[ pos0..pos1 ]};
    pos0 := pos0 + 3;
    Append( parts, [ part ] );
  od;
  return JoinStringsWithSeparator(parts);
end );
#############################################################################


#############################################################################
##
#F  CompColors ( a, b )
##
InstallGlobalFunction( CompColors, function( a, b )
local fA, fB;
  fA := CanonicalColor( a );
  fB := CanonicalColor( b );
  return fA < fB;
end );
#############################################################################


#############################################################################
##
#F  ConsolidateColors( c ) . . . . . . . . Consolidate Colors 
##
InstallGlobalFunction( ConsolidateColors, function( collection )
local baseItem, item, iter, consolidatedColors;
  consolidatedColors := [];  # Begin as empty list
  iter := Iterator( collection );
  baseItem := NextIterator( iter );
  baseItem.ALIAS := StructuralCopy(baseItem.COLOR);
  for item in iter do
      if baseItem.RED = item.RED
         and baseItem.GREEN = item.GREEN
         and baseItem.BLUE = item.BLUE
      then
         Append(baseItem.ALIAS, ", ");
         Append(baseItem.ALIAS, item.COLOR);
         #Print("(", baseItem.COLOR, " : ", item.COLOR, ") ", baseItem, "\n");
      else
        Add( consolidatedColors, baseItem );
        baseItem := StructuralCopy(item);
        baseItem.ALIAS := StructuralCopy(baseItem.COLOR);
      fi;
  od;
  return consolidatedColors;
end);
#############################################################################


#############################################################################
##
#F  Count ( n, l )
##
InstallGlobalFunction( Count, function(n, l)
local i;
   for i in [1..n] do
      Print(TextAttr.home, TextAttr.delline, String(i, -6), "\c");
      Sleep(l); 
   od;
end );
#############################################################################


#############################################################################
##
#F  CSI() . . . . send the CSI command to the terminal
##
InstallGlobalFunction( CSI, function( csiFunc, params... )
local args, i, printCSI;
  printCSI := function( codeString )
    Print(TextAttr.CSI, codeString);
  end;

  if csiFunc = "A" then # CUU
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      Print("Error:  too many args for CUU\n");
    fi;
  elif csiFunc = "B" then # CUD
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      Print("Error:  too many args for CUD\n");
    fi;
  elif csiFunc = "C" then # CUF
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      Print("Error:  too many args for CUF\n");
    fi;
  elif csiFunc = "D" then # CUB
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      Print("Error:  too many args for CUB\n");
    fi;
  elif csiFunc = "E" then # CNL
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      Print("Error:  too many args for CNL\n");
    fi;
  elif csiFunc = "F" then # CPL
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      Print("Error:  too many args for CPL\n");
    fi;
  elif csiFunc = "G" then # CHA
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      Print("Error: too many args for CHA\n");
    fi;
  elif csiFunc = "H" then # CUP
    if Length(params) = 2 then
      printCSI(Concatenation(params[1],";",params[2], csiFunc));
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1],";", csiFunc));
    elif Length(params) = 0 then
      printCSI(csiFunc);
    else
      Print("Error:  too many arguments for CUP.\n");
    fi;
  elif csiFunc = "J" then # ED
    if Length(params) = 1 then
      # Should we validate arg in [0,1,2,3]?
      printCSI(Concatenation(params[1], csiFunc)); 
    else
      printCSI(csiFunc);
    fi;
  elif csiFunc = "K" then # EL
    if Length(params) = 1 then
      # Should we validate arg in [0,1,2]?
      printCSI(Concatenation(params[1], csiFunc)); 
    else
      printCSI(csiFunc);
    fi;
  elif csiFunc = "S" then # SU
    if Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      printCSI(csiFunc);
    fi;
  elif csiFunc = "T" then # SD
    if Length(params) = 1 then
      printCSI(Concatenation(params[1], csiFunc));
    else
      printCSI(csiFunc);
    fi;
  elif csiFunc = "f" then # HVP
    if Length(params) = 2 then
      printCSI(Concatenation(params[1],";",params[2], csiFunc));
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1],";", csiFunc));
    elif Length(params) = 0 then
      printCSI(csiFunc);
    else
      Print("Error:  too many arguments for HVP.\n");
    fi;
  elif csiFunc = "m" then # SGR
    if Length(params) = 0 then
      printCSI(csiFunc);
    elif Length(params) = 1 then
      printCSI(Concatenation(params[1],csiFunc));
    else
    fi;
  elif csiFunc = "i" then # AUX Port On/Off
    if Length(params) >= 1 then
      if params[1] = "4" or params[1] = "5" then
        printCSI(Concatenation(params[1],csiFunc));
      else
        Print("AUX Port requires On(5) or Off(4), \n\tbut received [",params[1],"]\n");
      fi;
    else
      Print("Error: Missing argument - On(5) or Off(4)?\n");
    fi;
  elif csiFunc = "n" then # DSR
    printCSI(Concatenation("6", csiFunc));
  elif csiFunc = "s" then # SCP - Store Cursor Position
    printCSI(csiFunc);
  elif csiFunc = "u" then # RCP - Recall Cursor Position
    printCSI(csiFunc);
  elif csiFunc = "l" then # DECTCEM - Hide cursor
    printCSI(Concatenation("?25",csiFunc));
  elif csiFunc = "h" then # DECTCEM - Show cursor
    printCSI(Concatenation("?25",csiFunc));
  else
    Print("ERROR: Unknown CSI function: ", csiFunc, "\n");
  fi;
  return;
end );


#############################################################################
##
#F  FixAliases ( palette )
##
InstallGlobalFunction( FixAliases, function( palette )
local item, iterator, aliases, color;
  iterator := Iterator( palette );
  for item in iterator do
    color := [ item.COLOR ];
    aliases := SplitString( item.ALIAS, ',', ' ' );
    aliases := Difference( aliases, color );
    item.ALIAS := UngroupAliases( aliases );
  od;
  return palette;
end );
#############################################################################


#############################################################################
##
#F  ForegroundColor() . . . . Changes the foreground color 
##
InstallGlobalFunction( ForegroundColor, function( color )
  Print( "\033]10;", color, "\007" );
end );
#############################################################################


#############################################################################
##
#F  HumanNumbers() . . . . . . . . . . . . . . . . . . . . . . . . . . guess!
##
InstallGlobalFunction( HumanNumbers, function()
local human;

    human := Filename(DirectoriesPackagePrograms("humannumbers"), "humannumbers");

    Exec(human);
end );
#############################################################################


#############################################################################
##
#F  LoadColors
##
InstallGlobalFunction( LoadColors, function(filename)
local data;
    data := ReadCSV( filename );
    CanonicalizeColorData( data );
    return data;
end );
#############################################################################


#############################################################################
##
#F  ProcessColorfile( colorFile )
##
InstallGlobalFunction( ProcessColorfile, function( colorFile )
local palette;
  palette := LoadColors( colorFile );;
  Sort( palette, CompColors );
  palette := ConsolidateColors( palette );
  palette := FixAliases( palette );
  PrintCSV( filename@, palette, ["RED", "GREEN", "BLUE", "COLOR", "ALIAS"] );
  Print( "Wrote consolidated file to ", filename@, "\n" );
  return;
end );
#############################################################################


#############################################################################
##
#F  SampleColors
##
InstallGlobalFunction( SampleColors, function()
local extra, t;
    extra := ["CSI", "reset", "delline", "home"];
    Print("\n\n\n\n");
    for t in Difference(RecNames(TextAttr), extra) do
        Print(TextAttr.(t), "TextAttr.", t, "     Isn't this colorful?",
                TextAttr.reset, "\n");
    od;
end );
#############################################################################


#############################################################################
##
#F  UngroupAliases( groupedAliases )
##
InstallGlobalFunction( UngroupAliases, function( groupedAliases )
local buffer, i;
  buffer := "";
  for i in [1..Length(groupedAliases)] do
    if i = 1 then
      Append(buffer, groupedAliases[i]);
    else
      Append(buffer, ", ");
      Append(buffer, groupedAliases[i]);
    fi;
  od;
  return buffer;
end );
#############################################################################

#E  files.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

