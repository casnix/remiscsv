# Push(this, $) -- Pushes a value onto the top of the RegStack.
#-- Arguments: this, class inheritance
#              $value, the value to push onto the RegStack.
#-- Returns: Nothing.
sub Push {
  my $this = shift;
  my $value = shift;

  push @{ $this->{__stack} }, $value;
}
