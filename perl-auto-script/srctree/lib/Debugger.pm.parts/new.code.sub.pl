# Debugger->new($, $) -- Constructor for the Debugger class
# Creates a new Debugger instance
#-- Arguments: $class, the inherited class (`Debugger' in this case)
#              $section, the program section (commonly file) for this debugger.
#-- Returns: Blessed arguments.
sub new {
  my($class, $section) = @_;

  return bless $section, $class;

  # Mod: bless it and then define RegStack in $this->{regstack}?
}
