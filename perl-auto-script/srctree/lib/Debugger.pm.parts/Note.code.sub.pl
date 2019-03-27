# Note(this, $) -- prints a debugger notification
# Prints a debugger notification if the debugger is enabled.
#-- Arguments: this, the class inheritance
#              $notation, a text string to print out to console
#-- Returns: Nothing.
sub Note {
  my($this, $notation) = @_;

  if($GlobalEnvironment::DebuggerOn){
    print "[".$this->{regstack}->Current().".".$this->{section}."]".Tabulate::Tell().$notation."\n";
  }
}
