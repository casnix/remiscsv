# Top(this) -- Get the top of the RegStack
# Grabs the value at the top of the RegStack without modifying the stack.
#-- Arguments: Class inheritance.
#-- Returns: $topOfStack, the value at the top of the RegStack.
sub Top {
  my $this = shift;

  my $stackLength = scalar( @{ $this->{__stack} } );
  return $this->{__stack}[$stackLength - 1];
}
