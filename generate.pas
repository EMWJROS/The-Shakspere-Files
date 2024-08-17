program generate(stats);
(* Generate random text based on statistics file.*)
uses stems_and_fragments;

const MAX_OUTPUT = 3000;
      ROW_LENGTH = 40;

var stem, new_stem : string;
    output_length, row, column, n, k : integer;
    stats_file : text;
    a_single_character, dummy : char;
    continuation : array[1..30] of char;
    count : array[1..30] of integer;
    file_length : integer;

function get_number_of_fragments() : integer;

  var n : integer;

  begin
    n := 0;
    reset(stats_file);
    while not eof(stats_file) do
      begin
        n := n + 1;
        readln(stats_file);
      end; (* while *)
    get_number_of_fragments := n;
  end;

procedure read_stem(var s : string);
 (* Read stem from stats file.*)

  var i : integer;
      a_single_character : char;

  begin
    s[0] := char(STEM_LENGTH);
    for i:=1 to STEM_LENGTH do
      begin
        read(stats_file, a_single_character);
        s[i] := a_single_character;
      end;
  end;

procedure fast_forward(row : integer);

  var n : integer;

  begin
    n:= 0;
    reset(stats_file);

    while n <> row-1 do
      begin
        n := n + 1;
        readln(stats_file);
      end; (* while *)
  end;

begin
  randomize();
  assign(stats_file, 'stats');
  file_length := get_number_of_fragments();
  row := trunc(file_length*random);
  fast_forward(row);
  read_stem(stem);
  print(stem, STEM_LENGTH);
  read(stats_file, dummy);
  read(stats_file, a_single_character);
  write(a_single_character);
  push(stem, a_single_character, STEM_LENGTH);
  (* Start from the beginning.*)
  reset(stats_file);
  read_stem(new_stem);
  while not same_stem(stem, new_stem) do
    begin
      readln(stats_file);
      read_stem(new_stem);
    end; (* while *)
  output_length := 1;
  column := 1;
  while output_length < MAX_OUTPUT do
    begin
      output_length := output_length + 1;
      column := column + 1;
      read(stats_file, dummy);
      k := 0;
      while not eoln(stats_file) do
        begin
          k := k + 1;
          read(stats_file, continuation[k]);
          read(stats_file, count[k]);
          read(stats_file, dummy);
        end; (* while *)
      a_single_character := continuation[trunc(random*(k-1)+0.5)+1];
      write(a_single_character);
      if (a_single_character = ' ') and (column > ROW_LENGTH) then
        begin
          writeln;
          column := 0;
        end;
      push(stem, a_single_character, STEM_LENGTH);
      reset(stats_file);
      n := 0;
      read_stem(new_stem);
      while not (same_stem(stem, new_stem) or eof(stats_file)) do
        begin
          readln(stats_file);
          read_stem(new_stem);
          n := n + 1;
        end; (* while *)
      if eof(stats_file) then
        begin
          row := trunc(file_length*random);
          fast_forward(row);
          read_stem(new_stem);
          stem := new_stem;
        end;
    end; (* while *)
    writeln;
end.
