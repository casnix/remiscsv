# Register($, $) -- update debugger in runtime
# Pushes a new section on the debugger's section stack, commonly for function
#   debugging.
#-- Arguments: $this, the inherited Debugger instance
#              $codeSection, the section name to push on stack.
#-- Returns: Nothing.
sub Register {
  my($this, $codeSection) = @_;

  $this->{regstack}->Push($section);
}
