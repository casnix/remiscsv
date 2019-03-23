# FileExists($) -- check if a file exists
#-- Arguments: $path, path to the file
#-- Returns: true, if file exists
#            false, if file does not exist
sub FileExists {
  lclDebugger->Register('FileExists');
  lclDebugger->OpenHere();
  my $path = shift;
  
  lclDebugger->CloseHere();
  return true if -f $path;
  return false;
}