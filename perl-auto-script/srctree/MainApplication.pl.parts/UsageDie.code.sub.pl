# UsageDie(void) -- print the usage message and exit the program
#-- Arguments: none
#-- Returns: nothing, exits. 
sub UsageDie {
  lclDebugger->Register('UsageDie');
  lclDebugger->OpenHere();
  
  die ("Usage: auto-merge.pl [-dh|--*] OPTION=fn OPTION=fn OPTION=fn\n".
    "Options: --first-file=filename         The first CSV file to be processed.\n".
    "         --second-file=filename        The second CSV file to be processed.\n". 
    "         --output-file=filename        The filename for the output CSV file.\n".
    "Switches (optional):\n".
    "   -h,   --help                        Print usage information.\n".
    "   -d,   --debug                       Output the intermediary CSV matrix to \$output.debug.csv.\n".
    "Created by Matt Rienzo, 2019.\n");
    
  lclDebugger->CloseHere();
}