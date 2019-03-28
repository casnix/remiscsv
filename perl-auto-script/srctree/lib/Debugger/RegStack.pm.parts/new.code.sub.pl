# RegStack->new($,$) -- constructor for the RegStack class
#-- Arguments: $class, inherited RegStack class
#              $stub, first value on stack.
#-- Returns: Blessed reference to self.
sub new {
  my($class, $stub) = @_;

  my $self = {
    current => $stub,
    __stack => [ $stub ],
  };

  return bless $self, $class;
}
