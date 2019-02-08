#!/usr/bin/perl -w

use strict;
use Parse::CSV;

# Need _ things:
#   1) Expected output columns {titles, patterns}
#   2) Expected input column detection {no. cols, patterns}

# main(@,$) -- entry function
# Begins processing
#-- Arguments: @args, the @ARGV or commandline arguments
#              $argc, the $#ARGV or commandline arguments length
#-- Returns: nothing.  exits
sub main {
  my @args = shift;
  my $argc = shift;
  
  my($firstCSVFile, $secondCSVFile, $outputCSVFile) = ProcessArguments(@args, $argc);
  
}

# ProcessArguments(@,$) -- commandline argument processor
#-- Arguments: @args, the @ARGV or commandline arguments
#              $argc, the $#ARGV or commandline arguments length
#-- Returns: @returnList, { the first CSV input filename,
#                           the second CSV input filename,
#                           the output CSV filename }. 
sub ProcessArguments {
  my @args = shift;
  my $argc = shift;
  
  my @returnList = ();
  my($firstCSVFile, $secondCSVFile, $outputCSVFile) = ("","","");
  
  # Die with usage message if the arguments are wrong.
  if($argc != 3){
    UsageDie();
  }
  
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
  
  return($firstCSVFile, $secondCSVFile, $outputCSVFile);
}

# OptionGetFileNumber($) -- determines if argument is first, second, or output file
#-- Arguments: $option, the option from commandline
#-- Returns: 1, for file first input file
#            2, for file second input file
#            3, for the output file 
#            0, for unrecognized option (redundant error checking)
sub OptionGetFileNumber {
  my $option = shift;
  
  return 1 if $option =~ qr/--first-file/;
  return 2 if $option =~ qr/--second-file/;
  return 3 if $option =~ qr/--output-file/;
  
  return 0;
}

# OptionIsValid($) -- check if the option is a valid commandline option
#-- Arguments: $option, the commandline option
#-- Returns: 1 or nothing (dies).
sub OptionIsValid {
  my $option = shift;
  
  UsageDie() unless $option =~ qr/--(first|second|output)-(file)/;
  return 1;
}

# FileExists($) -- check if a file exists
#-- Arguments: $path, path to the file
#-- Returns: true, if file exists
#            false, if file does not exist
sub FileExists {
  my $path = shift;
  
  return(1) if -f $path;
  return(0);
}

# UsageDie(void) -- print the usage message and exit the program
#-- Arguments: none
#-- Returns: nothing, exits. 
sub UsageDie {
  die ("Usage: auto-merge.pl OPTION=fn OPTION=fn OPTION=fn\n".
    "Options: --first-file=filename         The first CSV file to be processed.\n".
    "         --second-file=filename        The second CSV file to be processed.\n". 
    "         --output-file=filename        The filename for the output CSV file.\n". 
    "Created by Matt Rienzo, 2019.\n");
}

# FileOpenDie($) -- print an error message and die
#-- Arguments: $path, path to file
#-- Returns: nothing, dies.
sub FileOpenDie {
  my $path = shift;
  die ("Error opening ".$path."! (Does the file exist?)\n");
}