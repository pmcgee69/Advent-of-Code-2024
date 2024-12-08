unit U_Parsers;

interface
uses System.SysUtils, System.Classes;

type
  TParseResult = record
    ok  : boolean;
    s   : string;
    str : TStringStream;
    du  : boolean;
  end;

  function Parse_Do      (st:TStringstream):TParseResult;
  function Parse_Dont    (st:TStringstream):TParseResult;
  function Parse_Mul     (st:TStringstream):TParseResult;
  function Parse_Digit   (pr:TParseResult ):TParseResult;
  function Parse_Comma   (pr:TParseResult ):TParseResult;
  function Parse_EndParen(pr:TParseResult ):TParseResult;

implementation

type
  TDigits = set of '0'..'9';
var
  Digits  : TDigits = ['0'..'9'];

    function Parse_Do(st:TStringstream):TParseResult;
    begin
        result.ok  := false;
        result.s   := '';
        result.str := st;
    var same       := st.Position;

        if st.ReadString(3) <> 'do(' then
           st.Position := same
        else begin
           result.ok := true;
           result.s  := '';
        end;
    end;

    function Parse_Dont(st:TStringstream):TParseResult;
    begin
        result.ok  := false;
        result.s   := '';
        result.str := st;
    var same       := st.Position;

        if st.ReadString(6) <> 'don''t(' then
           st.Position := same
        else begin
           result.ok := true;
           result.s  := '';
        end;
    end;

  function Parse_Mul(st:TStringstream):TParseResult;
  begin
        result.ok  := false;
        result.s   := '';
        result.str := st;
    var same       := st.Position;

        if st.ReadString(4) <> 'mul(' then
           st.Position := same
        else begin
           result.ok := true;
           result.s  := '';
        end;
  end;

  function Parse_Digit(pr:TParseResult):TParseResult;
  begin
        result.ok  := false;
        result.s   := pr.s;
        result.str := pr.str;
    var same       := pr.str.Position;
    var ch         := pr.str.ReadString(1)[1];

        if (ch in Digits) then begin
           result.ok := true;
           result.s  := pr.s+ch;
        end;
        result.str.Position := same;
  end;

  function Parse_Comma(pr:TParseResult):TParseResult;
  begin
        result.ok  := false;
        result.s   := pr.s;
        result.str := pr.str;
    var same       := pr.str.Position;
    var ch         := pr.str.ReadString(1)[1];

        if (ch = ',') then begin
           result.ok := true;
           result.s  := pr.s+ch;
        end;
        result.str.Position := same;
  end;

  function Parse_EndParen(pr:TParseResult):TParseResult;
  begin
        result.ok  := false;
        result.s   := pr.s;
        result.str := pr.str;
    var same       := pr.str.Position;
    var ch         := pr.str.ReadString(1)[1];

        if (ch = ')') then begin
           result.ok := true;
           result.s  := pr.s;
        end;
        result.str.Position := same;
  end;

end.
