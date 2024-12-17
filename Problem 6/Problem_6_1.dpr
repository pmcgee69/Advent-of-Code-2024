{$APPTYPE CONSOLE}
program Problem_6_1;

uses
  System.SysUtils,
  Problem_6_Data in 'Problem_6_Data.pas',
  U_Utils_Functional in '..\U_Utils_Functional.pas';

const
       N = 130;
type
       TupleInt = UFP.TupleInt;
const
       step_up : TupleInt = (fst: 0; snd:-1);
       step_r  : TupleInt = (fst: 1; snd: 0);
       step_dn : TupleInt = (fst: 0; snd: 1);
       step_l  : TupleInt = (fst:-1; snd: 0);
var
       step    : array [TDirection] of TupleInt;


procedure rotate(var d:TDirection);
begin
       if d = left then d:=up  else inc(d)
end;


function move(var current:TupleInt; var dirn:TDirection):boolean;
begin
       result := true;

       case dirn of                                        // exit condition
          up    : result := (current.snd >   0);
          right : result := (current.fst < N-1);
          down  : result := (current.snd < N-1);
          left  : result := (current.fst >   0);
       end;

       if not result then exit;

   var next := AddTuple( current, step[dirn] );

       if data[next.snd][next.fst] <> '#' then current := next
                                          else rotate(dirn);
end;


begin
       step[up   ] := step_up;     step[right] := step_r;
       step[down ] := step_dn;     step[left ] := step_l;

   var total := 1;  // '^' Starting point

       repeat
//           writeln( total:5, ' ',current.snd, '  ', current.fst);
             if data[current.snd][current.fst] = '.' then begin
                var s := data[current.snd];
                    s[current.fst] := 'x';
                    data[current.snd] := s;
                    inc(total);
             end;
       until not move(current, dirn);

       writeln(total);
       readln;
end.
