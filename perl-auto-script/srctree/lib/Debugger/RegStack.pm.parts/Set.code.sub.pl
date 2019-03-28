# Set(this, $) -- Sets the current section.
#-- Arguments: this, the class inheritance
#              $section, the section to set to.
#-- Returns: Nothing.
sub Set {
  my $this = shift;
  my $section = shift;

  $this->{current} = $section;
}
