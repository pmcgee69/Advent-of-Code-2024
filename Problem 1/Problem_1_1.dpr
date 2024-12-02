{$APPTYPE CONSOLE}
program Problem_1_1;

uses
  System.SysUtils,
  System.Generics.Collections,
  Problem_1_1_UData in 'Problem_1_1_UData.pas',
  U_Utils_Functional in '..\U_Utils_Functional.pas';

// Advent of Code 2024 - Problem 1 - Part 1
// https://adventofcode.com/2024/day/1
//
// For example:
//   3   4
//   4   3
//   2   5
//   1   3
//   3   9
//   3   3
// Pair up the smallest number in the left list with the smallest number in the right list,
// then the second-smallest left number with the second-smallest right number, and so on.
//
// Within each pair, figure out how far apart the two numbers are.
// Add up all of those distances.


//   const N = 1000;
//   TArray.Sort<integer>(data1);
//   TArray.Sort<integer>(data2);
//
//   var total := 0;
//   for var i := 0 to N-1 do inc(total, abs( data1[i]-data2[i] ) );

begin
   var data1 := TList<integer>.Create(data_1);
   var data2 := TList<integer>.Create(data_2);

   data1.Sort;
   data2.Sort;

   var data  := UFP.ZipTransform<integer, integer, integer>(data1, data2, delta);
               { ZipTransform(data1, data2, delta) }
   var total :=  UFP.List_Reduce<integer>(data, sum);
               { List_Reduce(data, sum) }

   writeln(total);           // 2970687
   readln;
end.


