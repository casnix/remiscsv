# OpenHere(this) -- opens the debug stream at the top of the stack
# Updates the RegStack with the top of the stack, and prints a debug message
#   about it if the debugger is enabled.
#-- Arguments: Class inheritance.
#-- Returns: Nothing.
sub OpenHere {
  my $this = shift;

  $this->&$SetRegStackCurrent();

  $this->Note("{");
  Tabulate::Increment();
}
