{$APPTYPE CONSOLE}
program Problem_5_1;

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Problem_5_Data in 'Problem_5_Data.pas';

{$region 'Challenge 5.1'}
// Advent of Code 2024 - Problem 5 - Part 1
// https://adventofcode.com/2024/day/5
//
{$endregion}

function mid(p:TArray<string>):integer;
begin
  var x := trunc( length(p)/2 );       // 0-based array
      exit( p[x].ToInteger );
end;


begin
  var lint  :  TList<integer>;
  var total := 0;

      for var p in prints do begin

          var check   := p.Split([',']);
          var current := check[0].ToInteger;
          var ok      := false;
          var i       := 0;

              repeat
                  if graph.TryGetValue( current, lint) then
                     inc(i);
                     current := check[i].ToInteger;
                     ok      := lint.Contains( current );
              until not ok or (i=high(check));

              if ok then inc( total, mid(check) );
      end;

      writeln(total);         // 4790
      readln;
end.


