# CloseHere(this) -- closes the currently opened debug stack.
# Updates the RegStack with the last debug stream, and prints a debugger
#   message about it if the debugger is enabled.
#-- Arguments: Class inheritance.
#-- Returns: Nothing.
sub CloseHere {
  my $this = shift;

  Tabulate::Decrement();
  $this->Note("}");

  $this->{regstack}->Pop();
  $this->&$SetRegStackCurrent();
}
