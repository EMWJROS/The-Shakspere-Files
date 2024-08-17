program make_statistics;
(* Make statistics of fragments and present result as stem and a
   list of possible continuations.*)

uses stems_and_fragments;

var fragment1, fragment2 : string;
    n : integer;
    continuation_pos : integer;

begin
  continuation_pos := STEM_LENGTH + 1;
  readln(fragment1);
  readln(fragment2);
  while not eof do
    begin
      print(fragment1, STEM_LENGTH);
      write(' ');
      if not same_stem(fragment1, fragment2) then
        begin
          write(fragment1[continuation_pos]);
          write(' ');
          writeln('1 ');
          fragment1 := fragment2;
          readln(fragment2);
        end
      else
        begin
          while same_stem(fragment1,fragment2) do
            begin
              n := 0;
              while same_stem(fragment1,fragment2) and
              (fragment1[continuation_pos] = fragment2[continuation_pos]) do
                begin
                  n := n+1;
                  fragment1 := fragment2;
                  readln(fragment2);
                end; (* while fragment1=fragment2 *)
              write(fragment1[continuation_pos]);
              write(' ');
              write(n+1:0);
              write(' ');
              if same_stem(fragment1,fragment2) then
                begin
                  fragment1 := fragment2;
                  readln(fragment2);
                end;
            end; (* while same_stem *)
          if n=0 then
            begin
              write(fragment1[continuation_pos]);
              write(' ');
              write(n+1:0);
              write(' ');
            end;
          fragment1 := fragment2;
          readln(fragment2);
          writeln;
        end; (* else *)
    end; (* while not eof *)
  if not same_stem(fragment1, fragment2) then
    begin
      print(fragment1, STEM_LENGTH);
      write(' ');
      write(fragment1[continuation_pos]);
      write(' ');
      writeln('1 ');
    end
end.
