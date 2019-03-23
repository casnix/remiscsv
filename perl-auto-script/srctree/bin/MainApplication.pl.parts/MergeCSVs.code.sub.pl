# MergeCSVs($,$,$) -- merges the first and second CSV files
#-- Arguments: $firstCSVFile, the first CSV file path
#              $secondCSVFile, the second CSV file path
#              $outputCSVFile, the output CSV file path
#-- Returns: nothing
sub MergeCSVs {
  lclDebugger->Register('MergeCSVs');
  lclDebugger->OpenHere();
  
  my $firstCSVFile = shift;
  my $secondCSVFile = shift;
  my $outputCSVFile = shift;
  
  # 1) Go through $firstCSVFile
  #     a) in new columns, ask user if they want to create a new column in the intermediate CSV, or merge with an
  #        existing column.
  #     b) new columns in output will have mapped names.  columns in intermediate will be mapped to those names or
  #        to regex functions
  # 2) Do the same to $secondCSVFile, with the same intermediate CSV
  # 3) Run regex functions in intermediate CSV, then follow output map to output CSV.
  
  lclDebugger->CloseHere();
}
