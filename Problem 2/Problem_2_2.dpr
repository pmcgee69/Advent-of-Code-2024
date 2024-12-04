{$APPTYPE CONSOLE}
program Problem_2_2;

uses
  System.SysUtils,
  System.Math,
  System.Generics.Collections,
  U_Utils_Functional in '..\U_Utils_Functional.pas',
  WC_ArrayHelper in '..\WC_ArrayHelper.pas',
  UProblem2_Data in 'UProblem2_Data.pas';

{$region 'Challenge 2.2'}
// Advent of Code 2024 - Problem 2 - Part 1
// https://adventofcode.com/2024/day/1
//
// Now, the same rules apply as before, except
// if removing a single level from an unsafe report would make it safe,
// the report instead counts as safe.
//
// More of the above example's reports are now safe:
//
//  7 6 4 2 1: Safe without removing any level.
//  1 2 7 8 9: Unsafe regardless of which level is removed.
//  9 7 6 2 1: Unsafe regardless of which level is removed.
//  1 3 2 4 5: Safe by removing the second level, 3.
//  8 6 4 4 1: Safe by removing the third level, 4.
//  1 3 6 7 9: Safe without removing any level.
//
// 4 reports are now safe.
// Update your analysis by handling situations where
// the Problem Dampener can remove a single level from unsafe reports.
{$endregion}

function monotone_nonconstant_bounded(a:TArray<integer>):boolean;
begin

   var deltas := UFP.Leave<integer>( UFP.Adj_Delta(a), 1 );

   if abs(UFP.List_Reduce<integer>(deltas,max,minint)) > 3 then exit(false);      //  NO jump of zero, or greater than 3
   if abs(UFP.List_Reduce<integer>(deltas,min,maxint)) = 0 then exit(false);      //

   var diffs := UFP.Leave<integer>( UFP.Adj_Diff(a), 1 );

   var min_diff := UFP.List_Reduce<integer>(diffs,min,maxint);
   var max_diff := UFP.List_Reduce<integer>(diffs,max,minint);

   if sign(min_diff) <> sign(max_diff) then exit(false)                           // ALL changes must be monotonic
                                       else exit(true);
end;


function fuzz_test(a:TArray<integer>):boolean;
begin
   result := false;

   for var i:= low(a) to high(a) do begin
       var a2 : TArray<integer>;
           setlength(a2,length(a));
           TArray.Copy<integer>(a,a2,length(a));
           TArray.Delete<integer>(a2,i);
           result := monotone_nonconstant_bounded(a2);
           if result then break;
  end;
end;


begin
   var k  := 0;
   var sl := get_data;                                   // Pull data set entries one at a time,
       repeat                                            // a bit like a coroutine / python generator function
         var b := monotone_nonconstant_bounded(sl);      // or a database

             if not b then b:=fuzz_test(sl);

             if b then inc(k);
             sl := get_data;
       until (sl=nil);

       writeln;
       writeln('Number of safe level sets : ',k);        // 230
       readln;
end.
