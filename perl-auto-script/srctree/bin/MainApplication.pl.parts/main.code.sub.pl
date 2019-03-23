# main(@,$) -- entry function
# Begins processing
#-- Arguments: @args, the @ARGV or commandline arguments
#              $argc, the $#ARGV or commandline arguments length
#-- Returns: nothing.  exits
sub main {
  lclDebugger->Register('main');
  lclDebugger->OpenHere();
  lclDebugger->Note("\@_ = ".@_."\n");
  my $args = shift;
  my $argc = shift;
  
  lclDebugger->Note("\$argc = ".$argc.", \$#ARGV = ".$#ARGV".\n");
  lclDebugger->Note("\$args = ".$args.", \\\@ARGV = ".\@ARGV."\n");
  lclDebugger->Note("ProcessArguments(\@args, \$argc) => (\$firstCSVFile, \$secondCSVFile, \$outputCSVFile)\n");
  
  my($firstCSVFile, $secondCSVFile, $outputCSVFile) = ProcessArguments($args, $argc);
  MergeCSVs($firstCSVFile, $secondCSVFile, $outputCSVFile);
  
  lclDebugger->CloseHere();
}