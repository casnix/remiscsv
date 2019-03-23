# Register($, $) -- update debugger in runtime
# Pushes a new section on the debugger's section stack, commonly for function
#   debugging.
#-- Arguments: $this, the inherited Debugger instance
#              $section, the section name to push on stack.
#-- Returns: Nothing.
sub Register {
  my($this, $section) = @_;

  # 1) Need a register stack/buffer of dynamic length
  # 2) Need to push $section onto that stack.
  $this->{regstack}->Push($section);
}
