# new($class, $section) -- Constructor for the Debugger class
#-- Arguments: $class, the inherited class (`Debugger' in this case)
#              $section, the program section (commonly file) for this debugger.
#rr Returns: Blessed arguments.
sub new {
  my($class, $section) = @_;

  return bless $section, $class;
}
