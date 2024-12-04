{$APPTYPE CONSOLE}
program Problem_2_1;

uses
  System.SysUtils,
  System.Math,
  System.Generics.Collections,
  UProblem2_Data in 'UProblem2_Data.pas',
  U_Utils_Functional in '..\U_Utils_Functional.pas';

{region 'Challenge 2.1'}
// Advent of Code 2024 - Problem 2 - Part 1
// https://adventofcode.com/2024/day/1
//
// The data consists of many reports, one report per line.
// Each report is a list of numbers called levels that are separated by spaces.
//
// For example:
// 7 6 4 2 1
// 1 2 7 8 9
// 9 7 6 2 1
// 1 3 2 4 5
// 8 6 4 4 1
// 1 3 6 7 9
// This example data contains six reports each containing five levels.
// The engineers are trying to figure out which reports are safe.
//
// Systems can only tolerate levels that are either gradually increasing or gradually decreasing.
// So, a report only counts as safe if both of the following are true:
// - The levels are either all increasing or all decreasing.
// - Any two adjacent levels differ by at least one and at most three.

// ie monotone, and {diffs} ∈ [1,2,3]
{endregion}

function monotone_nonconstant_bounded(a:TArray<integer>):boolean;
begin
//   if length(a) < 2 then exit(true);                                            // This was unnecessary ...
//   if length(a) < 3 then exit( (abs(a[0]-a[1]) > 0) and                         //    AND ... has errors.
//                               (abs(a[0]-a[1]) < 4) );                          //

   var deltas := UFP.Leave<integer>( UFP.Adj_Delta(a), 1 );

   if abs(UFP.List_Reduce<integer>(deltas,max,minint)) > 3 then exit(false);      //  NO jump of zero, or greater than 3
   if abs(UFP.List_Reduce<integer>(deltas,min,maxint)) = 0 then exit(false);      //

   var diffs := UFP.Leave<integer>( UFP.Adj_Diff(a), 1 );

   var min_diff := UFP.List_Reduce<integer>(diffs,min,maxint);
   var max_diff := UFP.List_Reduce<integer>(diffs,max,minint);

   if sign(min_diff) <> sign(max_diff) then exit(false)                           // ALL changes must be monotonic
                                       else exit(true);
end;


begin
   var k  := 0;
   var sl := get_data;                                   // Pull data set entries one at a time,
       repeat                                            // a bit like a coroutine / python generator function
         var b := monotone_nonconstant_bounded(sl);      // or a database
             if b then inc(k);
             sl := get_data;
       until (sl=nil);

       writeln;
       writeln('Number of safe level sets : ',k);        // 230
       readln;
end.
