# OptionGetFileNumber($) -- determines if argument is first, second, or output file
#-- Arguments: $option, the option from commandline
#-- Returns: 1, for file first input file
#            2, for file second input file
#            3, for the output file 
#            0, for unrecognized option (redundant error checking)
sub OptionGetFileNumber {
  lclDebugger->Register('OptionGetFileNumber');
  lclDebugger->OpenHere();
  
  my $option = shift;
  
  lclDebugger->CloseHere();
  
  return 1 if $option =~ qr/--first-file/;
  return 2 if $option =~ qr/--second-file/;
  return 3 if $option =~ qr/--output-file/;
  
  return 0;
}