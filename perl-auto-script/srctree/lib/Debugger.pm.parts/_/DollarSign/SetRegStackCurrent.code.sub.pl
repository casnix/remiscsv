# $SetRegStackCurrent($) -- sets the regstack current object to the top of stack
#-- Arguments: Class inheritance.
#-- Returns: Nothing.
my $SetRegStackCurrent = sub {
  my $this = shift;


  my $topOfRegStack = $this->{regstack}->Top();
  $this->{regstack}->Set($topOfRegStack);
};
