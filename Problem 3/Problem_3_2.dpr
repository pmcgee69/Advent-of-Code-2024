{$APPTYPE CONSOLE}
program Problem_3_2;

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  U_Parsers in 'U_Parsers.pas';

{$region 'Challenge 3.2'}
// Advent of Code 2024 - Problem 3 - Part 2
// https://adventofcode.com/2024/day/3
//
{$endregion}

procedure bump(var st:TStringStream);
begin
       st.Position:=st.Position+1;
end;

function read_Mul( mul    : TParseResult;
                   stream : TStringStream; var total:int64) : boolean;
var
    dig, com, par : TParseResult;
begin
    result := false;

    dig := Parse_Digit(mul);                            // position doesn't advance
    if dig.ok then begin

        bump(stream);
        repeat
            dig := Parse_Digit(dig);                    // position doesn't advance
            com := Parse_Comma(dig);                    //
            if dig.ok or com.ok then bump(stream);
        until not dig.ok;

        if com.ok then begin
            dig := com;
            repeat
                dig := Parse_Digit(dig);                // position doesn't advance
                par := Parse_EndParen(dig);             //
                if dig.ok or par.ok then bump(stream);
            until not dig.ok;

            if par.ok then begin                        // par = '000,111'
               var s    := par.s.Split([',']);
               var mult := s[0].ToInteger * s[1].ToInteger;
                   inc(total, mult);
                   result := true;
            end;
        end;
    end;
end;

begin
   var total : int64 := 0;
   var mult          := 0;

   var stream := TStringStream.Create;
       stream.LoadFromFile('..\..\problem 3 raw data.txt');

   var mul, du, dont : TParseResult;

       repeat
             mul := Parse_Mul(stream);
             if mul.ok then
                    if not read_mul( mul, stream, total) then
                       writeln(' x  ', stream.Position);

       until stream.position = stream.size;

       writeln(total);           // 173785482
       readln;
end.
