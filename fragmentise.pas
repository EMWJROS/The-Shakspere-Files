program fragmentise(input, output);
uses stems_and_fragments;

var
  a_single_character : char;
  fragment : string;

procedure read_fragment(var s : string);

  var i : integer;
      a_single_character : char;

  begin
    s[0] := char(COHERENCE_LENGTH);
    for i:=1 to COHERENCE_LENGTH do
      begin
        read(a_single_character);
        s[i] := a_single_character;
      end;
  end;

begin
 read_fragment(fragment);
 print(fragment, COHERENCE_LENGTH);
 writeln;
 while not eof do
   begin
     read(a_single_character);
     push(fragment, a_single_character, COHERENCE_LENGTH);
     print(fragment, COHERENCE_LENGTH);
     writeln;
   end; (* while *)
end. (* program *)
