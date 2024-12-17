{$APPTYPE CONSOLE}
program Problem_5_2;

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Problem_5_Data in '..\Problem_5_Data.pas',
  U_Shuffle in 'U_Shuffle.pas',
  U_Utils_Functional in '..\U_Utils_Functional.pas';
//  WC_ArrayHelper in '..\WC_ArrayHelper.pas',
//  U_next_permutation in 'U_next_permutation.pas',
//  U_Bad_Shuffle in 'U_Bad_Shuffle.pas';

{$region 'Challenge 5.2'}
// Advent of Code 2024 - Problem 5 - Part 2
// https://adventofcode.com/2024/day/5
//
{$endregion}

function mid(p:TArray<string>):integer;
begin
  var x := trunc( length(p)/2 );       // 0-based array
      exit( p[x].ToInteger );
end;



begin
  var total := 0;
      for var p in prints do begin
          var pages := p.Split([',']);

              if not Ordered(pages) then inc( total, map_chains(pages) );
//             if length(pages) < 12  then
//                 if bad_reshuffle( pages ) then inc( total, mid(pages) );      // Bad permutation approach.
      end;
      writeln(total);         //       6319
      readln;
end.


