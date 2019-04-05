use strict;
use warnings;
use boolean ':all';
use FindBin; use lib $FindBin::Bin;

use GlobalEnvironment;
use Debugger;
use Packet;
use Popsoof::Messenger;
use Popsoof::String;

#
# ISA Modifications
#our @ISA = qw(Popsoof::Messenger);
#
#

#
# Global variables for internal use
use constant lclDebugger => Debugger->new('newman');
use constant lclVersion => "0.0.1";
#
#

#
# Entry stub
{
  $GlobalEnvironment::DebuggerOn = true;
  lclDebugger->Register('entry');
  lclDebugger->OpenHere();

  my $status = Main($#ARGV, \@ARGV);
  print "Perl script exited with $status status\n";
  lclDebugger->CloseHere();

  exit($status);
}
#
#

# int Main($,$) -- The main function.
#-- Arguments: $argc, the argument count
#              $argv, a reference to the argument vector.
#-- Returns: An integer 0 or less for status.
sub Main {
  my $argc = shift;
  my $argv = shift;

  lclDebugger->Register('Main');
  lclDebugger->OpenHere();

  my($inputCSV, $outputCSV, $packetNum, %patternArgs) = ProcessArguments($argc, $argv);
  lclDebugger->Note("\$inputCSV = ".$inputCSV);
  lclDebugger->Note("\$outputCSV = ".$outputCSV);
  lclDebugger->Note("\$packetNum = ".$packetNum);

  my $strInput = Popsoof::String->new($inputCSV);
  my $strOutput = Popsoof::String->new($outputCSV);

  my $packetRun = Packet->new($packetNum);
  $packetRun->Message("Constructing a new packet based on packet number ".$packetNum.":\n");

  $packetRun->Message("Loading input as reference...\n");
  $packetRun->LoadInput(\$strInput);

  $packetRun->Message("Loading output as disk location reference...\n");
  $packetRun->FixOutput(\$strOutput);

  $packetRun->Message("Storing pattern arguments...\n");
  $packetRun->Store(%patternArgs);

  $packetRun->Message("Done.\nExecuting packet:\n");
  $packetRun->Execute();

  my $strState = $packetRun->StateString();
  $packetRun->Message("Packet completed with ".$returnState->Value()."\n");

  my $returnState = $packetRun->State();
  lclDebugger->CloseHere();

  return $returnState;
}

# (string, string) ProcessArguments($,$) -- commandline argument processor
#-- Arguments: $argc, the argument count
#              $argv, a reference to the argument vector.
#-- Returns: @returnList, { the input source parts directory
#                           the output source path. }
sub ProcessArguments {
  lclDebugger->Register('ProcessArguments');
  lclDebugger->OpenHere();

  my $argc = shift;
  my $argv = shift;

  lclDebugger->Note("\$argc = ".$argc);
  lclDebugger->Note("\$argv = [ ".join(",", @{ $argv })." ]");

  my($inputCSV, $outputCSV, $packetNum, %patternArgs) = ("", "", "", ());

  # Weirdly works online but not in CLI grep...?
  my $srcSwitches = qr/-(i|o|p|-input|-output|-packet)/;
  my $cmdSwitches = qr/-(w|h|v|d|s|S|-license|-help|-version|-debugger|-silent|-run-silent)/;

  # Iterate through arguments
  my $boolSkip = false;
  foreach my $argumentIndex (0..$argc){
    lclDebugger->Note("\$argv->[".$argumentIndex."] = ".$argv->[$argumentIndex]);
    if($boolSkip) {
      $boolSkip = false;
      next;
    }

    ($inputSrcParts = $argv->[$argumentIndex + 1]) if $argv->[$argumentIndex] eq "-i" || $argv->[$argumentIndex] eq "--input";
    ($outputSrcPath = $argv->[$argumentIndex + 1]) if $argv->[$argumentIndex] eq "-o" || $argv->[$argumentIndex] eq "--output";
    ($packetNum = $argv->[$argumentIndex + 1]) if $argv->[$argumentIndex] eq "-p" || $argv->[$argumentIndex] eq "--packet";

    if($argv->[$argumentIndex] eq "-p") {
      for(my $n = $argumentIndex + 2; $n < $argc; $n++){
        my @keyValPair = split /=/, $argv->[$n];
        my $key = $keyValPair[0];
        my $value = $keyValPair[1];

        %patternArgs{$key} = $value;
      }

      last;
    }

    if($argv->[$argumentIndex] =~ $srcSwitches) {
      $boolSkip = true;
      next;
    }

    PrintLicenseNotice() if ($argv->[$argumentIndex] eq "-w" || $argv->[$argumentIndex] eq "--license");
    UsageDie() if $argv->[$argumentIndex] eq "-h" || $argv->[$argumentIndex] eq "--help";
    PrintVersion() if $argv->[$argumentIndex] eq "-v" || $argv->[$argumentIndex] eq "--version";
    EnableDebugger() if $argv->[$argumentIndex] eq "-d" || $argv->[$argumentIndex] eq "--debugger";
    SetSilent() if $argv->[$argumentIndex] eq "-s" || $argv->[$argumentIndex] eq "--silent";
    RunSilent() if $argv->[$argumentIndex] eq "-S" || $argv->[$argumentIndex] eq "--run-silent";

    UsageDie() unless $argv->[$argumentIndex] =~ $cmdSwitches;
  }

  lclDebugger->CloseHere();
  return($inputCSV, $outputCSV, $packetNum, %patternArgs);
}

# void UsageDie(void) -- print the usage message and exit the program
#-- Arguments: none
#-- Returns: nothing, exits.
sub UsageDie {
  lclDebugger->Register('UsageDie');
  lclDebugger->OpenHere();

  die ("Usage: newman.pl [-whvdsS|-<long argument>|...] [-i input path] [-f output path] [-p pattern ring] [pattern arguments]\n".
    "Options: -i --input                    The input source parts directory path.\n".
    "         -o --output                   The output source file path.\n".
    "         -p --packet                   The pattern matching packet/ring to use.\n".
    "         -w --license                  Print license notice.\n".
    "         -h --help                     Print usage message.\n".
    "         -v --version                  Print version.\n".
    "         -d --debugger                 Enable the built in debugger (for autobild developers).\n".
    "         -s --silent                   Run with no output messaging.\n".
    "         -S --run-silent               Run with minimal output messaging.\n".
    "Patterns:\n".
    "      -p 0 2input=<file> rowtitle=<pattern>\n".
    "               Pattern 0 extracts all cells in column <columntitle> from two CSV files,\n".
    "               and outputs a single column CSV with all of those cells.\n".
    "      -p 1 2input=<file>\n".
    "               Pattern 1 compares two input CSV files and outputs a single column CSV file\n".
    "               with the row numbers of matching cells.\n".
    "      -p 2 2input=<file>\n".
    "               Pattern 2 removes all rows matching the row numbers in a second input file.\n".
    "Created by Matt Rienzo, 2019.\n");

  lclDebugger->CloseHere();
}

# void PrintLicenseNotice(void) -- Prints the license notice.
#-- Arguments: None.
#-- Returns: Nothing.
sub PrintLicenseNotice {
  die ("newman.pl -- Written for the UE Newman Center, in the Evansville Diocese of the\n".
    "Holy Catholic Church by Matt Rienzo, 2019.  License uncertain.\n");
}

# void PrintVersion(void) -- Prints the version.
#-- Arguments: None.
#-- Returns: Nothing.
sub PrintVersion {
  die ("newman.pl\n".
  "Version: ".lclVersion."\n".
  "Created 2019 Matt Rienzo\n");
}

# void EnableDebugger(void) -- Enables the built in debugger.
#-- Arguments: None.
#-- Returns: Nothing.
sub EnableDebugger {
  $GlobalEnvironment::DebuggerOn = true;
}

# void SetSilent(void) -- Enables silent mode.
#-- Arguments: None.
#-- Returns: Nothing.
sub SetSilent {
  $GlobalEnvironment::Silent = true;
}

# void RunSilent(void) -- Enables minimal silent mode.
#-- Arguments: None.
#-- Returns: Nothing.
sub SetSilent {
  $GlobalEnvironment::RunSilent = true;
}
