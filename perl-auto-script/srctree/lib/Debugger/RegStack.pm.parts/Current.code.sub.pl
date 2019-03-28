# Current(this) -- Gets the currently open RegStack value.
#-- Arguments: Class inheritance.
#-- Returns: The currently open RegStack value.
sub Current {
  my $this = shift;
  return $this->{current};
}
