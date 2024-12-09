{$APPTYPE CONSOLE}
program Problem_4_2;

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Problem_4_Data in 'Problem_4_Data.pas',
  U_Patterns in 'U_Patterns.pas';

{$region 'Challenge 4.2'}
// Advent of Code 2024 - Problem 4 - Part 2
// https://adventofcode.com/2024/day/4
//
{$endregion}


function mas1(i,j:integer):boolean;
begin
   if (data[i-1][j-1] = 'M') and
      (data[i-1][j+1] = 'S') and
      (data[i+1][j+1] = 'S') and
      (data[i+1][j-1] = 'M') then exit(true)
                             else exit(false);
end;
function mas2(i,j:integer):boolean;
begin
   if (data[i-1][j-1] = 'M') and
      (data[i-1][j+1] = 'M') and
      (data[i+1][j+1] = 'S') and
      (data[i+1][j-1] = 'S') then exit(true)
                             else exit(false);
end;
function mas3(i,j:integer):boolean;
begin
   if (data[i-1][j-1] = 'S') and
      (data[i-1][j+1] = 'M') and
      (data[i+1][j+1] = 'M') and
      (data[i+1][j-1] = 'S') then exit(true)
                             else exit(false);
end;
function mas4(i,j:integer):boolean;
begin
   if (data[i-1][j-1] = 'S') and
      (data[i-1][j+1] = 'S') and
      (data[i+1][j+1] = 'M') and
      (data[i+1][j-1] = 'M') then exit(true)
                             else exit(false);
end;


function count_words( N : integer ) : integer;
begin
  var c := 0;
      for var i := 1 to N-2 do
      for var j := 2 to N-1 do
           if data[i][j] = 'A' then
                if mas1(i,j) or mas2(i,j) or
                   mas3(i,j) or mas4(i,j) then inc(c);
      result := c;
end;


const N = 140;

begin
       writeln;
       writeln( count_words(N) );        // 1939
       readln;
end.



