{$APPTYPE CONSOLE}
program Problem_4_1;

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Problem_4_Data in 'Problem_4_Data.pas',
  U_Patterns in 'U_Patterns.pas';

{$region 'Challenge 4.1'}
// Advent of Code 2024 - Problem 4 - Part 1
// https://adventofcode.com/2024/day/4
//
{$endregion}

type
  str4 = string[4];
var
  buffer : str4 = '0000';

function R4 (i,j:integer):str4;
begin
   for var k := 0 to 3 do begin
           buffer[k+1] := ansichar( data[i][j+k] );
   end;
   result := buffer;
end;
function D4 (i,j:integer):str4;
begin
   for var k := 0 to 3 do begin
           buffer[k+1] := ansichar( data[i+k][j] );
   end;
   result := buffer;
end;
function DR4(i,j:integer):str4;
begin
   for var k := 0 to 3 do begin
           buffer[k+1] := ansichar( data[i+k][j+k] );
   end;
   result := buffer;
end;
function DL4(i,j:integer):str4;
begin
   for var k := 0 to 3 do begin
           buffer[k+1] := ansichar( data[i+k][j-k] );
   end;
   result := buffer;
end;


function count_words( xstart,xstop,
                      ystart,ystop : integer;
                      f : TFunc<integer,integer,str4> ) : integer;
begin
  var s := '';
  var c := 0;
      for var i := ystart to ystop do begin
      for var j := xstart to xstop do begin
              s := f(i,j);
              if (s='XMAS') or (s='SAMX') then inc(c);
          end;
      end;
      result := c;
end;

const N = 140;

begin
   var xmas := 0;

       inc(xmas, count_words(1, N-3, 0, N-1, R4));
       inc(xmas, count_words(1, N,   0, N-4, D4));
       inc(xmas, count_words(1, N-3, 0, N-4, DR4));
       inc(xmas, count_words(4, N,   0, N-4, DL4));

       writeln;
       writeln(xmas);                  // 2547
       readln;
end.
