unit stems_and_fragments;

interface

const COHERENCE_LENGTH = 4;
      STEM_LENGTH = COHERENCE_LENGTH - 1;

procedure print(s : string; l : integer);
function same_stem(z1, z2 : string) : boolean;
procedure push(var s : string; c : char; l : integer);

implementation

procedure print(s : string; l : integer);

  var i : integer;

  begin
    for i:=1 to l do
      write(s[i]);
  end;

function same_stem(z1, z2 : string) : boolean;
(* Check if two strings share the same stem. *)

  var i : integer;
      result : boolean;

  begin
    result := true;
    for i:= 1 to STEM_LENGTH do
      begin
        result := result and (z1[i] = z2[i]);
      end;
    same_stem := result;
  end;

procedure push(var s : string; c : char; l : integer);
(* Add a new character to the stem and push one step to the left.*)

  var i : integer;

  begin
    for i:= 1 to (l - 1) do
      s[i] := s[i+1];
    s[l] := c;
  end;

end.
