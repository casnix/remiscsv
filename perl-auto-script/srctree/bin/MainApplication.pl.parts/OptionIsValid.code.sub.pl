# OptionIsValid($) -- check if the option is a valid commandline option
#-- Arguments: $option, the commandline option
#-- Returns: true or nothing (dies).
sub OptionIsValid {
  lclDebugger->Register('OptionIsValid');
  lclDebugger->OpenHere();
  
  my $option = shift;
  
  UsageDie() unless $option =~ qr/--(first|second|output)-(file)/;
  
  lclDebugger->CloseHere();
  return true;
}