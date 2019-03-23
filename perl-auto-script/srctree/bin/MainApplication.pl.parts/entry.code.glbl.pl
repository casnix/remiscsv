#
# Entry point
use constant lclDebugger => new Debugger('MainApplication');

lclDebugger->Register('entry');
lclDebugger->OpenHere();
lclDebugger->Note("main(\@ARGV, \$#ARGV) = (".@ARGV.", ".$#ARGV.")\n");
main(\@ARGV, $#ARGV);
lclDebugger->CloseHere();