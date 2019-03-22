# ProcessArguments(@,$) -- commandline argument processor
#-- Arguments: @args, the @ARGV or commandline arguments
#              $argc, the $#ARGV or commandline arguments length
#-- Returns: @returnList, { the first CSV input filename,
#                           the second CSV input filename,
#                           the output CSV filename }. 
sub ProcessArguments {
  lclDebugger->Register('ProcessArguments');
  lclDebugger->OpenHere();
  
  my @args = @{ (shift) };
  my $argc = shift;
  
  my @returnList = ();
  my($firstCSVFile, $secondCSVFile, $outputCSVFile) = ("","","");
  
  # Die with usage message if the arguments are wrong.
  UsageDie() unless $argc;
  UsageDie() unless $argc > 2;
  
  # Trim any switches, if there are any.
  (@args, $argc) = TrimSwitches(\@args, $argc);
  UsageDie() unless $argc > 2;
  
  # Weirdly works online but not in CLI grep...?
  my $optionRegex = qr/--[A-Za-z0-9\-]+/;
  my $splitRegex = qr/=/;


  # Iterate through arguments
  foreach my $argumentIndex (0..($argc-1)){
    my @argumentList = split $splitRegex, $args[$argumentIndex];
    
    UsageDie() unless $#argumentList == 2;
    UsageDie() unless $argumentList[0] =~ $optionRegex;
    UsageDie() unless OptionIsValid($argumentList[0]);
    FileOpenDie($argumentList[1]) unless FileExists($argumentList[1]);
    
    $firstCSVFile = $argumentList[1] if OptionGetFileNumber($argumentList[0]) == 1;
    $secondCSVFile = $argumentList[1] if OptionGetFileNumber($argumentList[0]) == 2;
    $outputCSVFile = $argumentList[1] if OptionGetFileNumber($argumentList[0]) == 3;
    UsageDie() unless OptionGetFileNumber($argumentList[0]);
  }
  
  lclDebugger->CloseHere();
  return($firstCSVFile, $secondCSVFile, $outputCSVFile);
}