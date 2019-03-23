# TrimSwitches(@,$) -- trim switches from command line options, if there are any
#-- Arguments: @args, the @ARGV array copy
#              $argc, the length of @args
#-- Returns: @args and $argc, possibly modified.
sub TrimSwitches {
  lclDebugger->Register('TrimSwitches');
  lclDebugger->OpenHere();
  
  my @args = @{ (shift) };
  my $argc = shift;
  
  return(\@args, $argc) if $args[0] =~ qr/^--[A-Za-z0-9\-]+=.*/; #MUST TEST

  my $firstSwitch = shift @args;
  $argc -= 1;
  UsageDie() unless $firstSwitch =~ qr/^-(d|-debug)\s/; # It's not necessary to check for -h, --help as they call UsageDie()
                                                    # anyway.
  $GlobalEnvironment::DebuggerOn = true if $firstSwitch =~ qr/^-(d|-debug)\s/;
  
  lclDebugger->CloseHere();
  return(\@args, $argc);
}