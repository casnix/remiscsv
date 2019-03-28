# Pop(this) -- Pops a value off the top of the RegStack.
#-- Arguments: Class inheritance.
#-- Returns: A scalar value from the top of RegStack.
sub Pop {
  my $this = shift;

  return pop @{ $this->{__stack} };
}
