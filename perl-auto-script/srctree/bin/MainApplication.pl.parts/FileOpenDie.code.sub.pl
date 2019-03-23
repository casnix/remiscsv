# FileOpenDie($) -- print an error message and die
#-- Arguments: $path, path to file
#-- Returns: nothing, dies.
sub FileOpenDie {
  lclDebugger->Register('FileOpenDie');
  lclDebugger->OpenHere();
  
  my $path = shift;
  die ("Error opening ".$path."! (Does the file exist?)\n");
  
  lclDebugger->CloseHere();
}