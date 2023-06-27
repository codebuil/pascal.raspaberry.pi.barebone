Library kernel;
procedure mains;cdecl;
var
        i: Int32;
        scr: PChar = PChar($4100000);       

begin

        for i := 0 to 307200 do
        begin
               scr[i*2] := #63;
               
        end;
               
               
end;
exports 
mains;
end.
