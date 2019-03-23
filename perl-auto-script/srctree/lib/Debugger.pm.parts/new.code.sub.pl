# Debugger->new($, $) -- Constructor for the Debugger class
# Creates a new Debugger instance
#-- Arguments: $class, the inherited class (`Debugger' in this case)
#              $section, the program section (commonly file) for this debugger.
#-- Returns: Blessed class object.
sub new {
  my $class = shift;

  my $self = {
    section => shift,
    regstack => RegStack->new('Debugger'),
  };

  return bless $self, $class;

  # Mod: bless it and then define RegStack in $this->{regstack}?
}
