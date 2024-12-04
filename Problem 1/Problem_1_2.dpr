{$APPTYPE CONSOLE}
program Problem_1_2;

uses
  System.SysUtils,
  System.Generics.Collections,
  Problem_1_1_UData in 'Problem_1_1_UData.pas',
  U_Utils_Functional in '..\U_Utils_Functional.pas';

{$region 'Challenge 1.2'}
// Advent of Code 2024 - Problem 1 - Part 2
// https://adventofcode.com/2024/day/1
//
// For example:
//   3   4
//   4   3
//   2   5
//   1   3
//   3   9
//   3   3
// This time, you'll need to figure out exactly how often each number
// from the left list appears in the right list.
// Multiply each number in the left list by the number of times that number appears in the right list.
// Calculate a total similarity score by adding up each result.
{$endregion}

begin
       var c    := 0;
       var dict := TDictionary<integer,integer>.Create;

       for var d in data_2 do begin
           if dict.TryGetValue(d,c) then dict.AddOrSetValue(d,c+1)
                                    else dict.Add(d,1);
       end;

       var counts := TList<integer>.Create;
       var data1  := TList<integer>.Create(data_1);

       for var d in data1 do begin
           if dict.TryGetValue(d,c) then counts.add(c)
                                    else counts.add(0)
       end;

       var data   := UFP.ZipTransform<integer, integer, integer>(data1, counts, mult);
                   { ZipTransform(data1,counts,mult) }
       var total  :=  UFP.List_Reduce<integer>(data, sum, 0);
                   { List_Reduce(data,sum) }

       writeln(total);           // 23963899
       dict.free;
       readln;
end.


